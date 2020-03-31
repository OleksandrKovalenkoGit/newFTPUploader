//
//  Builder.swift
//  NewFTPUploader
//
//  Created by Golos on 11.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Foundation

protocol Builder {}

extension Builder {
    func set<T>(_ keyPath: WritableKeyPath<Self, T>, to newValue: T) -> Self {
        var copy = self
        copy[keyPath: keyPath] = newValue
        return copy
    }
}

extension NSObject: Builder {}
