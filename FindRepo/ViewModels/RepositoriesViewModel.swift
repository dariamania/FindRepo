//
//  RepositoriesViewModel.swift
//  FindRepo
//
//  Created by Dariia Pavlovska on 14.07.2022.
//

import SwiftUI

class RepositoriesViewModel: ObservableObject {
    let username: String

    init() {
        self.username = NetworkRequest.username ?? ""
    }

    private init(username: String) {
        self.username = username
    }

    func signOut() {
        NetworkRequest.signOut()
    }

    static func preview() -> RepositoriesViewModel {
        return RepositoriesViewModel(
            username: "GitHub user")
    }
}

