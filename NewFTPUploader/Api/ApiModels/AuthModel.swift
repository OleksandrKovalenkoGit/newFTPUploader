//
//  AuthModel.swift
//  NewFTPUploader
//
//  Created by Golos on 03.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Foundation

struct AuthModel: Codable {
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case sessionLifetime = "session_lifetime"
    }
    
    let accessToken: String
    let sessionLifetime: String
}
