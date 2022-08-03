//
//  RepoViewModel.swift
//  FindRepo
//
//  Created by Dariia Pavlovska on 10.07.2022.
//

import Combine
import Foundation

final class RepoViewModel: ObservableObject {

    typealias FetchedPageResult = Result<Page?, RepoViewModel.RepoError>

    enum RepoError: LocalizedError {
        case custom(error: Error)
        case failedToDecode
        case invalidUrl
    }

    enum RepoAction {
        case fetchFirstPage
        case fetchNextPage
    }
    
    @Published var repo_count = 0
    @Published var page = 1
    @Published var repos: [Repo] = []
    @Published var error: RepoError?
    @Published var searchTerm = ""
    @Published private(set) var searchNeverHappened = true
    var nextPageIsAvailable: Bool { repo_count != repos.count }

    private let actionSubject = PassthroughSubject<RepoAction, Never>()
    private var cancellables = Set<AnyCancellable>()

    deinit {
        onDissappear()
    }

    func onAppear() {
        Publishers
            .CombineLatest(
                $searchTerm
                    .map { $0.replacingOccurrences(of: " ", with: "+") }
                    .removeDuplicates(),
                actionSubject
            )
            .print("DEBUG")
            .flatMap { [weak self] searchTerm, actionSubject ->
                AnyPublisher<(FetchedPageResult, FetchedPageResult), Never> in
                guard let self = self else {
                    return Empty(completeImmediately: true)
                        .eraseToAnyPublisher()
                }
                if actionSubject == .fetchFirstPage {
                    self.repos = []
                }
                guard !searchTerm.isEmpty else {
                    return Empty(completeImmediately: false)
                        .eraseToAnyPublisher()
                }
                return Publishers
                    .Zip(
                        ApiService.live
                            .fetchReposPage(searchTerm, self.page),
                        ApiService.live
                            .fetchReposPage(searchTerm, self.page + 1)
                    )
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
            .sink { [weak self] resultFirstPage, resultSecondPage in
                self?.searchNeverHappened = false
                
                switch (resultFirstPage, resultSecondPage) {
                case (.success(let page1), .success(let page2)):
                    self?.repos.append(contentsOf: page1?.items ?? [])
                    self?.repos.append(contentsOf: page2?.items ?? [])

                    guard let page1 = page1 else { return }
                    self?.repo_count = page1.total_count
                    self?.page += 2
                case (.success(let page1), .failure(let error2)):
                    self?.repos.append(contentsOf: page1?.items ?? [])
                    self?.page += 1
                    guard let page1 = page1 else { return }
                    self?.repo_count = page1.total_count
                    self?.error = error2
                case (.failure(let error1), .success):
                    self?.error = error1
                case (.failure(let error1), _):
                    self?.error = error1
                }
            }
            .store(in: &cancellables)
    }

    private func onDissappear() {
        cancellables = []
    }
    func onSubmit() {
        actionSubject.send(.fetchFirstPage)
    }

    func fetchNextPage() {
        if nextPageIsAvailable {
            actionSubject.send(.fetchNextPage)
        }
    }
}

extension RepoViewModel.RepoError: Identifiable {
    var id: String { errorDescription }

    var errorDescription: String {
        switch self {
        case .failedToDecode:
            return "Failed to decode response"
        case .invalidUrl:
            return "Invalid URL"
        case .custom(let error):
            return "\(error)"
        }
    }
}
