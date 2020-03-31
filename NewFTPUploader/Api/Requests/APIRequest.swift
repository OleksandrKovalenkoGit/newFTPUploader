//
//  APIRequest.swift
//  NewFTPUploader
//
//  Created by Golos on 03.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Foundation

struct APIRequest<T: Decodable> {
    enum HttpMethod: String {
        case post, get, put, delete
    }
    
    let httpMethod: HttpMethod
    let requestName: String
    let postParameters: [String: Any]?
    let getParameters: [String: Any]?
    let isTokenRequired: Bool
    
    init(httpMethod: HttpMethod,
         requestName: String,
         postParameters: [String: Any]? = nil,
         getParameters: [String: Any]? = nil,
         isTokenRequired: Bool = false) {
        self.httpMethod = httpMethod
        self.requestName = requestName
        self.postParameters = postParameters
        self.getParameters = getParameters
        self.isTokenRequired = isTokenRequired
    }
}
