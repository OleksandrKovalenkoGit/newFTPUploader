//
//  OrientationManager.swift
//  NewFTPUploader
//
//  Created by Golos on 12.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import UIKit
import Combine

protocol DeviceProtocol {
    var systemVersion: String { get }
    var orientation: UIDeviceOrientation { get }
}

extension UIDevice: DeviceProtocol {}

protocol OrientationManagerProtocol {
    func subscribeToOrientationChanges()
}

class OrientationManager {
    @Injectable var notificationCenter: NotificationCenterProtocol
    @Injectable var device: DeviceProtocol
    
    let store: Store<AppState, AppAction>
    
    private var cancellable: AnyCancellable?
    
    init(store: Store<AppState, AppAction>) {
        self.store = store
    }
}

// MARK: OrientationManagerProtocol
extension OrientationManager: OrientationManagerProtocol {
    func subscribeToOrientationChanges() {
        cancellable = notificationCenter
            .publisher(for: UIDevice.orientationDidChangeNotification, object: nil)
            .map { [weak self] _ in self?.device.orientation.isLandscape == true }
            .sink { [weak self] in
                self?.store.send(.general(.changeLandscape($0)))
        }
    }
}
