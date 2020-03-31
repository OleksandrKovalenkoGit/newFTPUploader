//
//  Injectable.swift
//  NewFTPUploader
//
//  Created by Golos on 11.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Foundation

@propertyWrapper
struct Injectable<Type> {
    var value: Type
    
    init(container: ResolverProtocol = ServiceLocator.shared) {
        self.value = container.resolve()!
    }
    
    var wrappedValue: Type { value }
}
