//
//  ServiceLocator.swift
//  NewFTPUploader
//
//  Created by Golos on 04.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Foundation

protocol ResolverProtocol {
    func resolve<Service>() -> Service?
}

class ServiceLocator {
    enum HoldMode {
        case hold
        case create
    }
    
    private var items = [String: () -> Any?]()
    private var holdedItems = [String: Any?]()
    
    static let shared = ServiceLocator()
    
    func register<Service>(type: Service.Type = Service.self, holdMode: HoldMode = .create, factory: @escaping () -> Service?) {
        let key = "\(Service.self)"
        
        switch holdMode {
        case .create:
            items[key] = factory
        case .hold:
            holdedItems[key] = factory()
        }
    }
}

// MARK: ResolverProtocol
extension ServiceLocator: ResolverProtocol {
    func resolve<Service>() -> Service? {
        let key = "\(Service.self)"
        return holdedItems[key] as? Service ?? items[key]?() as? Service
    }
}
