//
//  JsonEncoder.swift
//  NewFTPUploader
//
//  Created by Golos on 03.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Foundation

protocol APIEncoderProtocol {
    func encode(parameters: [String: Any]) -> Data?
}

public struct FormDataAPIEncoder {
    let queryHelper: QueryHelperProtocol
    
    public init(queryHelper: QueryHelperProtocol) {
        self.queryHelper = queryHelper
    }
}

// MARK: APIEncoderProtocol
extension FormDataAPIEncoder: APIEncoderProtocol {
    public func encode(parameters: [String: Any]) -> Data? {
        return queryHelper.encode("", with: parameters)?.absoluteString.dropFirst().data(using: .utf8)
    }
}
