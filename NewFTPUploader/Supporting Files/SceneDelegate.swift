//
//  SceneDelegate.swift
//  NewFTPUploader
//
//  Created by Golos on 31.03.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var factory: FactoryProtocol? = ServiceLocator.shared.resolve()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = factory?.buildController
        
        self.window = window
        window.makeKeyAndVisible()
    }
}
