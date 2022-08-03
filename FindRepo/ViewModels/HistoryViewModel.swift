//
//  HistoryViewModel.swift
//  FindRepo
//
//  Created by Dariia Pavlovska on 11.07.2022.
//

import SwiftUI

class HistoryModel: ObservableObject {
    
    @Published var saved: [Repo] = []
    
    init() {
        saved = StorageManager.shared.retrieveDataFromDisk() ?? []
    }

    func itemUrl(repo: Repo) -> String {
        let isContained = saved.contains { $0 == repo }
        if !isContained {
            if saved.count == 20 {
                saved.removeFirst()
            }
            saved.append(repo)
            StorageManager.shared.saveDataToDisk(repo)
        }
        print("Show:", repo.html_url)
        return repo.html_url
    }
}
