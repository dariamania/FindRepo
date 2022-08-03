//
//  HistoryView.swift
//  FindRepo
//
//  Created by Dariia Pavlovska on 09.07.2022.
//

import SwiftUI

struct HistoryView: View {
    
    @EnvironmentObject var history: HistoryModel
    
    var body: some View {
        NavigationView {
            VStack {
                if history.saved.isEmpty {
                    Text("No viewed repos yet...")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                } else {
                    List {
                        ForEach(history.saved, id: \.id) { repo in
                            HistoryRowView(repo: repo)
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle("Viewed repos")
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(.gray)
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
