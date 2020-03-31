//
//  ProjectEffect.swift
//  NewFTPUploader
//
//  Created by Golos on 05.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Combine

struct ProjectEffect: Effect {
    @Injectable var apiManager: APIManagerProtocol
    
    func mapToAction() -> AnyPublisher<AppAction, Never> {
        return apiManager
            .perform(request: .project)
            .tryMap { .project(.updateProjects($0.projects)) }
            .catch { Just(.project(.projectError($0))) }
            .eraseToAnyPublisher()
    }
}
