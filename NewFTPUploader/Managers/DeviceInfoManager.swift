//
//  DeviceInfoManager.swift
//  NewFTPUploader
//
//  Created by Golos on 12.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Foundation

protocol BundleProtocol {
    var infoDictionary: [String: Any]? { get }
}

// MARK: BundleProtocol
extension Bundle: BundleProtocol {}

protocol DeviceInfoManagerProtocol {
    var appVersion: String? { get }
}

struct DeviceInfoManager {
    enum Constants {
        static let appVersionBundleKey = "CFBundleShortVersionString"
    }
    
    let bundle: BundleProtocol
    @Injectable var device: DeviceProtocol
}

// MARK: DeviceInfoManagerProtocol
extension DeviceInfoManager: DeviceInfoManagerProtocol {
    var appVersion: String? {
        return bundle.infoDictionary?[Constants.appVersionBundleKey] as? String
    }
}
