//
//  Reducer.swift
//  NewFTPUploader
//
//  Created by Golos on 03.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Foundation
import Combine

struct Reducer<State, Action> {
    let reduce: (inout State, Action) -> Void
}

extension Reducer where State == AppState, Action == AppAction {
    static var appReducer: Reducer {
        return Reducer { state, action in
            switch action {
            case let .project(action):
                state.projects = reduceProject(with: action, state: state.projects)
            case let .build(action):
                state.builds = reduceBuilds(with: action, state: state.builds)
            case let .auth(action):
                state.auth = reduceAuth(with: action, state: state.auth)
            case let .general(action):
                state.general = reduceGeneral(with: action, state: state.general)
            }
        }
    }
}
