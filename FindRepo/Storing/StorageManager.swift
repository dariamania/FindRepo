//
//  StorageManager.swift
//  FindRepo
//
//  Created by Dariia Pavlovska on 11.07.2022.
//

import Foundation
import Disk

final class StorageManager {
    
    static let shared = StorageManager()
    
    private let directory = Disk.Directory.documents
    private let modelPath = "Repos/Repo.json"
    
    func saveDataToDisk(_ value: Repo) {
        do {
            try Disk.append(value, to: modelPath, in: directory)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func retrieveDataFromDisk() -> [Repo]? {
        do {
            let value = try Disk.retrieve(modelPath, from: directory, as: [Repo].self)
            return value
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func removeData() {
        do {
            try Disk.remove(modelPath, from: directory)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
