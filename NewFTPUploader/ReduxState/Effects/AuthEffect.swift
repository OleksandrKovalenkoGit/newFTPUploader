//
//  AuthEffect.swift
//  NewFTPUploader
//
//  Created by Golos on 05.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Combine
import Foundation

struct AuthEffect: Effect {
    let login: String
    let password: String
    let pushToken: String?
    @Injectable var apiManager: APIManagerProtocol
    @Injectable var authManager: AuthManagerProtocol
    
    func mapToAction() -> AnyPublisher<AppAction, Never> {
        return apiManager
            .perform(request: .auth(login: login, password: password, deviceToken: pushToken))
            .tryMap {
                self.authManager.store(token: $0.accessToken,
                                       sessionLifetime: $0.sessionLifetime,
                                       userName: self.login)
                return .auth(.saveToken($0.accessToken, $0.sessionLifetime, self.login))
            }
            .catch { Just(.auth(.authError($0))) }
            .eraseToAnyPublisher()
    }
}
