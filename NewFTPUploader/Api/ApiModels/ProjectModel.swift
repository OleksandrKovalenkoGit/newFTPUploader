//
//  ProjectModel.swift
//  NewFTPUploader
//
//  Created by Golos on 01.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import UIKit

struct ProjectContainer: Decodable {
    let projects: [ProjectModel]
    
    init(from decoder: Decoder) throws {
        let array = try? decoder.singleValueContainer().decode([ProjectModel].self)
        let dictionary = try? decoder.singleValueContainer().decode([String: ProjectModel].self)
        
        projects = array ?? dictionary?.values.compactMap { $0 } ?? []
    }
}

struct ProjectModel: Identifiable, Codable {
    let id: Int
    let name: String
}
