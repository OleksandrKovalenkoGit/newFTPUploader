//
//  Action.swift
//  NewFTPUploader
//
//  Created by Golos on 31.03.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Combine

enum AppAction {
    case project(ProjectAction)
    case build(BuildAction)
    case auth(AuthAction)
    case general(GeneralAction)
}

enum ProjectAction {
    case loading
    case updateProjects([ProjectModel])
    case projectError(Error?)
    case showInfo
    case hideInfo
}

enum BuildAction {
    case loading
    case stopLoading
    case updateBuilds([Int: [BuildModel]])
    case buildError(Error)
}

enum AuthAction {
    case pushToken(String?)
    case saveToken(String, String, String)
    case authError(Error)
    case startLoading
    case logout
}

enum GeneralAction {
    case changeLandscape(Bool)
}
