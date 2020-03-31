//
//  BuildModel.swift
//  NewFTPUploader
//
//  Created by Golos on 04.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Foundation

struct BuildModel: Codable {
    enum CodingKeys: String, CodingKey {
        case build, link, platform, image, description
        case createdDate = "created_date"
        case serverType = "server_type"
        case developerName = "developer_name"
    }
    
    let build: String
    let link: String
    let platform: String?
    let createdDate: TimeInterval?
    let image: String?
    let serverType: String?
    let description: String?
    let developerName: String?
}

// MARK: Identifiable
extension BuildModel: Identifiable {
    var id: String {
        build
    }
}
