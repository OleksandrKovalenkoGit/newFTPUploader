//
//  AppState.swift
//  NewFTPUploader
//
//  Created by Golos on 31.03.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Foundation

struct AppState {
    var projects: ProjectsState
    var builds: BuildsState
    var auth: AuthState
    var general: GeneralState
}

struct GeneralState {
    var isLandscape = false
}

struct ProjectsState {
    var projects = [ProjectModel]()
    var isLoading = false
    var isInfoShown = false
    var apiError: String?
}

struct BuildsState {
    var builds = [Int: [BuildModel]]()
    var isLoading = false
    var apiError: String?
}

struct AuthState: Builder {
    var pushToken: String?
    var userName: String?
    var token: String?
    var loginError: String?
    var passwordError: String?
    var apiError: String?
    var isLoading = false
}
