//
//  HistoryRowView.swift
//  FindRepo
//
//  Created by Dariia Pavlovska on 11.07.2022.
//

import SwiftUI

struct HistoryRowView: View {
    
    var repo: Repo
    
    var body: some View {
        HStack {
            HStack {
                VStack {
                    Image(systemName: "bookmark")
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(repo.full_name)
                        .bold()
                        .foregroundColor(.black)
                    
                    Text(repo.description ?? "")
                }
            }
        }
        .padding(.vertical, 6)
    }
}

struct HistoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryRowView(repo: .init(id: 0,
                                   name: "StarWars",
                                   full_name: "Yalantis/StarWars.iOS",
                                   url: "https://api.github.com/users/Yalantis",
                                   html_url: "https://github.com/Yalantis/StarWars.iOS",
                                   description: "This component implements transition animation to crumble view-controller into tiny pieces.",
                                   updated_at: "2022-07-03T11:16:08Z",
                                   stargazers_count: 3705))
    }
}
