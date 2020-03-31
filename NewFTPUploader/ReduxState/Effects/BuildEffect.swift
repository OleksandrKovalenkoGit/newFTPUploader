//
//  BuildEffect.swift
//  NewFTPUploader
//
//  Created by Golos on 05.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Combine

struct BuildEffect: Effect {
    let projectId: Int
    @Injectable var apiManager: APIManagerProtocol

    func mapToAction() -> AnyPublisher<AppAction, Never> {
        return apiManager
            .perform(request: .builds(projectId: projectId))
            .tryMap { .build(.updateBuilds([self.projectId: $0])) }
            .catch { Just(.build(.buildError($0))) }
            .eraseToAnyPublisher()
    }
}
