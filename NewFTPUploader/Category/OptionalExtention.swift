//
//  OptionalExtention.swift
//  NewFTPUploader
//
//  Created by Golos on 01.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Foundation

protocol CollectionOrStringish {
    var isEmpty: Bool { get }
    static var emptyValue: Self { get }
}

extension String: CollectionOrStringish {
    public static var emptyValue: String {
        return ""
    }
}

extension Array: CollectionOrStringish {
    static var emptyValue: [Element] {
        return []
    }
}

extension Optional where Wrapped: CollectionOrStringish {
    var nonEmpty: Bool {
        switch self {
        case let .some(value): return !value.isEmpty
        default: return false
        }
    }
    
    var nonEmptyValue: Wrapped? {
        switch self {
        case let .some(value): return value.isEmpty ? nil : value
        default: return nil
        }
    }
    
    var orEmpty: Wrapped {
        switch self {
        case let .some(value): return value
        default: return Wrapped.emptyValue
        }
    }
}
