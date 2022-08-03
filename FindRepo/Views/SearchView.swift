//
//  SearchView.swift
//  FindRepo
//
//  Created by Dariia Pavlovska on 09.07.2022.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var viewModel = RepoViewModel()
    @EnvironmentObject var history: HistoryModel
    
    var body: some View {
        NavigationView {
            if viewModel.searchNeverHappened {
                VStack {
                    Text("Find a repo")
                        .font(.title.weight(.bold))
                    
                    Text("Start searching for solution")
                        .multilineTextAlignment(.center)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundColor(.gray)
                .navigationTitle("Type a repo name")
            } else {
                List {
                    ForEach(viewModel.repos.sorted { $0.stargazers_count > $1.stargazers_count }, id: \.id) { repo in
                        Button(
                            action: {
                                guard let itemUrl = URL(string: history.itemUrl(repo: repo)) else { return }
                                UIApplication.shared.open(itemUrl)
                            },
                            label: {
                                RepoRowView(repo: repo)
                            }
                        )
                    }

                    if viewModel.nextPageIsAvailable {
                        ProgressView()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .onAppear(perform: viewModel.fetchNextPage)
                    }
                } // end of List
                .listStyle(.plain)
                .navigationTitle("\(viewModel.repo_count) repositories found")
                .navigationBarTitleDisplayMode(.inline)
            }
            
        }
        .searchable(text: $viewModel.searchTerm)
        .onSubmit(of: .search) {
            viewModel.onSubmit()
        }
        .onAppear {
            viewModel.onAppear()
        }
        .alert(
            item: $viewModel.error,
            content: { error in
                Alert(
                    title: Text("Some error appeared"),
                    message: Text(error.errorDescription),
                    dismissButton: .default(Text("Cancel"))
                )
            }
        )
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
