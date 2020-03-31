//
//  Reducer+General.swift
//  NewFTPUploader
//
//  Created by Golos on 12.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Foundation

extension Reducer where State == AppState, Action == AppAction {
    static func reduceGeneral(with action: GeneralAction, state: GeneralState) -> GeneralState {
        switch action {
        case let .changeLandscape(value):
            return GeneralState(isLandscape: value)
        }
    }
}
