//
//  SignInViewModel.swift
//  FindRepo
//
//  Created by Dariia Pavlovska on 14.07.2022.
//

import AuthenticationServices
import SwiftUI

class SignInViewModel: NSObject, ObservableObject {
    
    @Published var userIsLoggedIn = false
    @Published private(set) var isLoading = false

    func signInTapped() {
        guard let signInURL =
                NetworkRequest.RequestType.signIn.networkRequest?.url
        else {
            print("Could not create the sign in URL .")
            return
        }

        let callbackURLScheme = NetworkRequest.callbackURLScheme
        let authenticationSession = ASWebAuthenticationSession(
            url: signInURL,
            callbackURLScheme: callbackURLScheme
        ) { [weak self] callbackURL, error in
                guard
                    error == nil,
                    let callbackURL = callbackURL,
                    let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems,
                    let code = queryItems.first(where: { $0.name == "code" })?.value,
                    let networkRequest = NetworkRequest.RequestType.codeExchange(code: code).networkRequest
                else {
                    print("An error occurred when attempting to sign in.")
                    return
                }

                self?.isLoading = true
                networkRequest.start(responseType: String.self) { result in
                    switch result {
                    case .success:
                        self?.getUser()
                    case .failure(let error):
                        print("Failed to exchange access code for tokens: \(error)")
                        self?.isLoading = false
                    }
                }
            }

        authenticationSession.presentationContextProvider = self
        authenticationSession.prefersEphemeralWebBrowserSession = true

        if !authenticationSession.start() {
            print("Failed to start ASWebAuthenticationSession")
        }
    }

    func appeared() {
        // Try to get the user in case the tokens are already stored on this device
        getUser()
    }

    private func getUser() {
        isLoading = true

        NetworkRequest
            .RequestType
            .getUser
            .networkRequest?
            .start(responseType: User.self) { [weak self] result in
                switch result {
                case .success:
                    self?.userIsLoggedIn = true
                case .failure(let error):
                    print("Failed to get user, or there is no valid/active session: \(error.localizedDescription)")
                }
                self?.isLoading = false
            }
    }
}

extension SignInViewModel: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession)
    -> ASPresentationAnchor {
        ASPresentationAnchor()
    }
}

