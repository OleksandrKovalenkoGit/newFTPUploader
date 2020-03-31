//
//  ProtocolStorage.swift
//  NewFTPUploader
//
//  Created by Golos on 13.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import UIKit

protocol UrlControllerProtocol {
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completionHandler completion: ((Bool) -> Void)?)
}

// MARK: UrlControllerProtocol
extension UIApplication: UrlControllerProtocol {}

public protocol KeychainProtocol {
    func get(_ key: String) -> String?
    @discardableResult func set(value: String, forKey key: String) -> Bool
    @discardableResult func clear() -> Bool
}

public protocol DefaultsProtocol {
    func set(_ value: Any?, forKey defaultName: String)
    func value(forKey defaultName: String) -> Any?
    func removeAll()
}

// MARK: DefaultsProtocol
extension UserDefaults: DefaultsProtocol {
    public func removeAll() {
        dictionaryRepresentation().keys.forEach {
            removeObject(forKey: $0)
        }
    }
}

protocol CookieStorageProtocol {
    var cookies: [HTTPCookie]? { get }
    func deleteCookie(_ cookie: HTTPCookie)
    func setCookie(_ cookie: HTTPCookie)
}

// MARK: CookieStorageProtocol
extension HTTPCookieStorage: CookieStorageProtocol {}

protocol DateFormatterProtocol {
    func string(from date: Date) -> String
}

// MARK: DateFormatterProtocol
extension DateFormatter: DateFormatterProtocol {}

protocol NotificationCenterProtocol {
    func publisher(for name: Notification.Name, object: AnyObject?) -> NotificationCenter.Publisher
}

extension NotificationCenter: NotificationCenterProtocol {}
