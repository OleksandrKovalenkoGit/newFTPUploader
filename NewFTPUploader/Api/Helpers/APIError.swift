//
//  APIError.swift
//  NewFTPUploader
//
//  Created by Golos on 03.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Foundation

enum APIError: Error {
    case apiError(String)
    case wrongURLSettings
    case badInternetConnection
    case custom(Error)
    
    init(error: URLError) {
        if error.code == .notConnectedToInternet {
            self = .badInternetConnection
        } else {
            self = .custom(error)
        }
    }
}

// MARK: LocalizedError
extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .apiError(value):
            return value
        case let .custom(value):
            return value.localizedDescription
        case .wrongURLSettings:
            return NSLocalizedString("Settings error", comment: "")
        case .badInternetConnection:
            return NSLocalizedString("Internet connection error", comment: "")
        }
    }
}
