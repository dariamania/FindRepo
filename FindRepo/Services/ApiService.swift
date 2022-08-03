//
//  NetworkingServices.swift
//  FindRepo
//
//  Created by Dariia Pavlovska on 17.07.2022.
//

import Combine
import Foundation

struct ApiService {
    static let itemsPerPage: Int = 15
    let fetchReposPage: (_ searchTerm: String, _ page: Int) -> AnyPublisher<Result<Page?, RepoViewModel.RepoError>, Never>
}

extension ApiService {
    /// Live service used in App
    static let live = ApiService(
        fetchReposPage: { searchTerm, page in
            let reposUrlString = "https://api.github.com/search/repositories?o=desc&q=" + searchTerm + "&s=stars&type=Repositories&page=\(page)&per_page=\(ApiService.itemsPerPage)"
            guard
                let url = URL(string: reposUrlString),
                let defaultURL = URL(string: "https://api.github.com/search/repositories?q=swift")
            else {
                return Just(.failure(RepoViewModel.RepoError.invalidUrl))
                    .eraseToAnyPublisher()
            }

            let token = NetworkRequest.accessToken ?? ""
            let components = URLComponents(string: reposUrlString)
            var request = URLRequest(url: components?.url ?? defaultURL)
            request.httpMethod = "GET"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

            return URLSession.shared
                .dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .decode(type: Page?.self, decoder: JSONDecoder())
                .replaceError(with: nil)
                .map { .success($0) }
                .eraseToAnyPublisher()
        }
    )
}
