//
//  UserData.swift
//  GitHubRepositories
//
//  Created by Thieu Nguyen on 29/5/19.
//  Copyright © 2019 Mao. All rights reserved.
//

import KeychainSwift

class UserData: TMUserDefaults {
    private static var sharedInstanceVar = UserData()
    private var keychain = KeychainSwift()

    override static func sharedInstance() -> UserData {
        return sharedInstanceVar
    }

    struct ClassConstant {
        static let IS_LOGIN = "isLogin"
        static let USERNAME = "username"
        static let PASSWORD = "password"
        static let RECENT_SEARCHES = "recentSearches"
        static let VALID_USERNAMES = "validUsernames"
    }

    var isLogin: Bool {
        get {
            return getObject(ClassConstant.IS_LOGIN) as? Bool ?? false
        }
        set {
            set(newValue, forKey: ClassConstant.IS_LOGIN)
        }
    }

    var username: String {
        get {
            return getObject(ClassConstant.USERNAME) as? String ?? ""
        }
        set {
            set(newValue, forKey: ClassConstant.USERNAME)
        }
    }

    var password: String {
        get {
            return keychain.get(ClassConstant.PASSWORD) ?? ""
        }
        set {
            keychain.set(newValue, forKey: ClassConstant.PASSWORD)
        }
    }

    var recentSearches: [String] {
        get {
            return getObject(ClassConstant.RECENT_SEARCHES) as? [String] ?? []
        }
        set {
            set(newValue, forKey: ClassConstant.RECENT_SEARCHES)
        }
    }

    var validUsernames: [String] {
        get {
            return getObject(ClassConstant.VALID_USERNAMES) as? [String] ?? []
        }
        set {
            set(newValue, forKey: ClassConstant.VALID_USERNAMES)
        }
    }
}
