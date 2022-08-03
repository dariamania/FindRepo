//
//  RepoView.swift
//  FindRepo
//
//  Created by Dariia Pavlovska on 10.07.2022.
//

import SwiftUI

struct RepoRowView: View {
    
    var repo: Repo
    
    var body: some View {
        HStack {
            HStack {
                VStack {
                    Image(systemName: "archivebox")
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(repo.full_name)
                        .bold()
                        .foregroundColor(.blue)
                    Text(repo.description ?? "")
                    HStack {
                        Text("Updated on \(DateHelper.convertDate(repo.updated_at))")
                            .foregroundColor(.gray)
                        Image(systemName: "star")
                        Text(" \(repo.stargazers_count)")
                    }
                }
            }
        }
        .padding(.vertical, 6)
    }
}

struct RepoView_Previews: PreviewProvider {
    static var previews: some View {
        RepoRowView(repo: .mock())
    }
}
