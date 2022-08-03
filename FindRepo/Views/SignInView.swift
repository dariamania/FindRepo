//
//  SignInView.swift
//  FindRepo
//
//  Created by Dariia Pavlovska on 14.07.2022.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject private var viewModel = SignInViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                NavigationLink(
                    destination: HomeTabView().environmentObject(viewModel),
                    isActive: $viewModel.userIsLoggedIn,
                    label: { EmptyView() }
                )

                gitImage

                gitLabel

                if viewModel.isLoading {
                    ProgressView()
                } else {
                    signInButton
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                viewModel.appeared()
            }
        }
    }
}

private extension SignInView {
    var gitImage: some View {
        Image("github-1")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300, height: 200, alignment: .center)
    }

    var gitLabel: some View {
        Text("Find Github Repo")
            .font(.largeTitle)
            .bold()
            .padding(.bottom, 40)
    }

    var signInButton: some View {
        Button(
            action: { viewModel.signInTapped() },
            label: {
                Text("Sign In")
                    .font(Font.system(size: 24).weight(.semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 50)
                    .padding(.vertical, 8)
            }
        )
        .background(.black)
        .cornerRadius(10)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
