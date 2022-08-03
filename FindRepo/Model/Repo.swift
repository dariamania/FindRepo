//
//  RepoModel.swift
//  FindRepo
//
//  Created by Dariia Pavlovska on 10.07.2022.
//

import Foundation

struct Page: Codable {
    let total_count: Int
    let incomplete_results: Bool
    let items: [Repo]
}

struct Repo: Codable, Equatable {
    let id: Int
    let name: String
    let full_name: String
    let url: String
    let html_url: String
    let description: String?
    let updated_at: String
    let stargazers_count: Int
}


extension Repo {
    static func mock() -> Repo {
        Repo(
            id: 0,
            name: "StarWars",
            full_name: "Yalantis/StarWars.iOS",
            url: "https://api.github.com/users/Yalantis",
            html_url: "https://github.com/Yalantis/StarWars.iOS",
            description: "This component implements transition animation to crumble view-controller into tiny pieces.",
            updated_at: "2022-07-03T11:16:08Z",
            stargazers_count: 3705
        )
    }
}
