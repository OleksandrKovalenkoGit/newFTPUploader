//
//  PushEffect.swift
//  NewFTPUploader
//
//  Created by Golos on 26.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Foundation
import Combine

struct PushEffect: Effect {
    let token: String
    @Injectable var apiManager: APIManagerProtocol
    
    func mapToAction() -> AnyPublisher<AppAction, Never> {
        return apiManager
            .perform(request: .pushDevice(token: token))
            .replaceError(with: EmptyModel())
            .map { _ in .auth(.pushToken(nil)) }
            .eraseToAnyPublisher()
    }
}
