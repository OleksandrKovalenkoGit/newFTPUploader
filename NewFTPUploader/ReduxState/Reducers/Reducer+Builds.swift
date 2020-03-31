//
//  Reducer+Builds.swift
//  NewFTPUploader
//
//  Created by Golos on 06.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Foundation

extension Reducer where State == AppState, Action == AppAction {
    static func reduceBuilds(with action: BuildAction, state: BuildsState) -> BuildsState {
        var state = state
        
        switch action {
        case .loading:
            state.apiError = nil
            state.isLoading = true
            
        case let .updateBuilds(data):
            state.apiError = nil
            state.builds = data
            state.isLoading = false
            
        case let .buildError(error):
            state.isLoading = false
            state.apiError = error.localizedDescription
            
        case .stopLoading:
            state.apiError = nil
            state.isLoading = false
        }
        return state
    }
}
