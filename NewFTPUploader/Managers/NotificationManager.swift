//
//  NotificationManager.swift
//  NewFTPUploader
//
//  Created by Golos on 18.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import UIKit
import UserNotifications
import SwiftUI

protocol NotificationManagerProtocol {
    func setup(for application: UIApplication)
    func register(token: Data)
}

class NotificationManager: NSObject {
    private let center: UNUserNotificationCenter
    private let store: Store<AppState, AppAction>
    
    init(center: UNUserNotificationCenter = UNUserNotificationCenter.current(), store: Store<AppState, AppAction>) {
        self.center = center
        self.store = store
    }
}

// MARK: NotificationManagerProtocol
extension NotificationManager: NotificationManagerProtocol {
    
    func setup(for application: UIApplication) {
        center.delegate = self
        center.requestAuthorization(options: [.sound, .alert, .badge]) { isGranted, _ in
            guard isGranted else { return }
            
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
    }
    
    func register(token: Data) {
        let token = token.reduce("") { $0 + String(format: "%02x", $1) }
        store.send(.auth(.pushToken(token)))
    }
}

// MARK: UNUserNotificationCenterDelegate
extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
}
