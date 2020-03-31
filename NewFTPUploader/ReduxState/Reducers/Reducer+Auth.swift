//
//  Reducer+Auth.swift
//  NewFTPUploader
//
//  Created by Golos on 06.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Foundation

extension Reducer where State == AppState, Action == AppAction {
    static func reduceAuth(with action: AuthAction, state: AuthState) -> AuthState {
        var authState = state
        
        switch action {
        case let .saveToken(token, _, userName):
            authState.isLoading = false
            authState.token = token
            authState.apiError = nil
            authState.userName = userName
            
        case let .authError(error):
            authState.isLoading = false
            authState.apiError = error.localizedDescription
            
        case .startLoading:
            authState.isLoading = true
            authState.apiError = nil
            
        case .logout:
            authState.pushToken = nil
            authState.token = nil
            authState.userName = nil
            
        case let .pushToken(token):
            authState.pushToken = token
        }
        return authState
    }
}
