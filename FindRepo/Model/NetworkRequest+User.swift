//
//  NetworkRequest+User.swift
//  FindRepo
//
//  Created by Dariia Pavlovska on 14.07.2022.
//

import Foundation

extension NetworkRequest {

    private static let accessTokenKey = "accessToken"
    private static let refreshTokenKey = "refreshToken"
    private static let usernameKey = "username"

    static var accessToken: String? {
        get {
            UserDefaults.standard.string(forKey: accessTokenKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: accessTokenKey)
        }
    }

    static var refreshToken: String? {
        get {
            UserDefaults.standard.string(forKey: refreshTokenKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: refreshTokenKey)
        }
    }

    static var username: String? {
        get {
            UserDefaults.standard.string(forKey: usernameKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: usernameKey)
        }
    }
}

