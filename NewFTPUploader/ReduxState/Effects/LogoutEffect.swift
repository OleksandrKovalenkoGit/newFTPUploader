//
//  LogoutEffect.swift
//  NewFTPUploader
//
//  Created by Golos on 12.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Foundation
import Combine

struct LogoutEffect: Effect {
    @Injectable var apiManager: APIManagerProtocol
    @Injectable var authManager: AuthManagerProtocol
    
    func mapToAction() -> AnyPublisher<AppAction, Never> {
        apiManager
            .perform(request: .logout)
            .replaceError(with: LogoutModel(message: nil))
            .map { _ in
                self.authManager.removeAll()
                return .auth(.logout)
            }
            .eraseToAnyPublisher()
    }
}
