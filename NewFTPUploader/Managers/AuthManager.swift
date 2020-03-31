//
//  AuthManager.swift
//  NewFTPUploader
//
//  Created by Golos on 07.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Foundation
import Combine

protocol AuthManagerProtocol {
    var token: String? { get }
    var userName: String? { get }

    func store(token: String, sessionLifetime: String, userName: String)
    func restoreCookies()
    
    func removeAll()
}

struct AuthManager {
    enum Keys {
        static let userToken = "userToken"
        static let cookies = "cookies"
        static let sessionLifetime = "sessionLifetime"
        static let userName = "userName"
    }
    
    let cookieStorage: CookieStorageProtocol
    let keychain: KeychainProtocol
    let defaults: DefaultsProtocol
}

// MARK: AuthManagerProtocol
extension AuthManager: AuthManagerProtocol {
    var token: String? {
        guard let timeInterval = defaults.value(forKey: Keys.sessionLifetime) as? TimeInterval,
            Date(timeIntervalSince1970: timeInterval) >= Date() else {
                removeAll()
                return nil
        }
        return keychain.get(Keys.userToken)
    }
    
    var userName: String? {
        defaults.value(forKey: Keys.userName) as? String
    }

    var cookies: HTTPCookie? {
        let properties = defaults.value(forKey: Keys.cookies) as? [HTTPCookiePropertyKey: Any]
        return HTTPCookie(properties: properties ?? [:])
    }
    
    func store(token: String, sessionLifetime: String, userName: String) {
        keychain.set(value: token, forKey: Keys.userToken)
        defaults.set(cookieStorage.cookies?.first?.properties, forKey: Keys.cookies)
        defaults.set(userName, forKey: Keys.userName)
        
        guard let expiresIn = TimeInterval(sessionLifetime) else { return }
        let expireDate = Date(timeIntervalSinceNow: expiresIn)
        
        defaults.set(expireDate.timeIntervalSince1970, forKey: Keys.sessionLifetime)
    }
    
    func restoreCookies() {
        guard let cookies = cookies else { return }
        cookieStorage.setCookie(cookies)
    }
    
    func removeAll() {
        keychain.clear()
        defaults.removeAll()
        
        guard let storedCookies = cookies else { return }
        cookieStorage.deleteCookie(storedCookies)
    }
}
