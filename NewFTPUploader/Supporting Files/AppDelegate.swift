//
//  AppDelegate.swift
//  NewFTPUploader
//
//  Created by Golos on 31.03.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import UIKit
import KeychainSwift

// MARK: KeychainProtocol
extension KeychainSwift: KeychainProtocol {
    @discardableResult public func set(value: String, forKey key: String) -> Bool {
        return set(value, forKey: key)
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let container = ServiceLocator.shared
    
    lazy var notificationManager: NotificationManagerProtocol = NotificationManager(store: store)
    lazy var orientationManager = OrientationManager(store: store)
    
    let authManager: AuthManagerProtocol = AuthManager(cookieStorage: HTTPCookieStorage.shared,
                                                       keychain: KeychainSwift(),
                                                       defaults: UserDefaults.standard)
    
    lazy var store = Store(initialState: AppState(projects: .init(),
                                                  builds: .init(),
                                                  auth: AuthState()
                                                    .set(\.token, to: authManager.token)
                                                    .set(\.userName, to: authManager.userName),
                                                  general: .init()),
                           reducer: .appReducer)
    
    let dateFormatter: DateFormatterProtocol = DateFormatter()
        .set(\.timeStyle, to: .short)
        .set(\.dateStyle, to: .medium)
        .set(\.doesRelativeDateFormatting, to: true)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureStatusBar()
        registerDependecies()
        
        orientationManager.subscribeToOrientationChanges()
        authManager.restoreCookies()
        
        notificationManager.setup(for: application)
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        notificationManager.register(token: deviceToken)
    }
    
    func configureStatusBar() {
        let newAppearance = UINavigationBarAppearance()
        newAppearance.configureWithOpaqueBackground()

        UINavigationBar.appearance().standardAppearance = newAppearance
    }
    
    func registerDependecies() {
        container.register(holdMode: .hold) { ImageService() as ImageServiceProtocol }
        container.register { UIApplication.shared as UrlControllerProtocol }
        container.register { [weak self] in self?.authManager }
        container.register { [weak self] in self?.dateFormatter }
        container.register { NotificationCenter.default as NotificationCenterProtocol }
        container.register { UIDevice.current as DeviceProtocol }
        container.register { DeviceInfoManager(bundle: Bundle.main) as DeviceInfoManagerProtocol }
        container.register(type: FactoryProtocol.self) { [weak self] in
            guard let store = self?.store else { return nil }
            return MainFactory(store: store)
        }
        container.register(holdMode: .hold) {
            APIManager(apiProvider: URLSession.shared,
                       queryHelper: QueryHelper(),
                       encoder: FormDataAPIEncoder(queryHelper: QueryHelper()),
                       decoder: JSONDecoder(),
                       token: { [weak self] in self?.authManager.token },
                       baseUrl: "http://m.itcraftlab.com/") as APIManagerProtocol }
    }
}
