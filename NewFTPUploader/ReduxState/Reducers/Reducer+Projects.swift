//
//  Reducer+Projects.swift
//  NewFTPUploader
//
//  Created by Golos on 06.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Foundation

extension Reducer where State == AppState, Action == AppAction {
    static func reduceProject(with action: ProjectAction, state: ProjectsState) -> ProjectsState {
        var state = state
        
        switch action {
        case .loading:
            state.apiError = nil
            state.isLoading = true
            
        case let .updateProjects(data):
            state.projects = data
            state.isLoading = false
            state.apiError = nil

        case let .projectError(error):
            state.apiError = error?.localizedDescription
            state.isLoading = false
            
        case .showInfo:
            state.isInfoShown = true
            
        case .hideInfo:
            state.isInfoShown = false
        }
        return state
    }
}
