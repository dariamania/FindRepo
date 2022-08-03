//
//  HomeTabView.swift
//  FindRepo
//
//  Created by Dariia Pavlovska on 09.07.2022.
//

import SwiftUI

struct HomeTabView: View {
    
    @StateObject var history = HistoryModel()
    @EnvironmentObject var signInViewModel: SignInViewModel
    @ObservedObject private var viewModel: RepositoriesViewModel

    private var signOutButton: some View {
      Button("Sign Out") {
        StorageManager.shared.removeData()
        viewModel.signOut()
        signInViewModel.userIsLoggedIn = false
      }
    }

    init(viewModel: RepositoriesViewModel = RepositoriesViewModel()) {
      self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            TabView {
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass.circle.fill")
                            Text("Search")
                    }
                
                HistoryView()
                    .tabItem {
                        Image(systemName: "clock.fill")
                        Text("History")
                    }
            }
            .environmentObject(history)
            .accentColor(.black)
        }
        .navigationBarTitle(viewModel.username, displayMode: .inline)
        .navigationBarItems(leading: signOutButton)
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView(
            viewModel: RepositoriesViewModel.preview()
        )
    }
}
