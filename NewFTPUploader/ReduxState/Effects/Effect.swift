//
//  Effect.swift
//  NewFTPUploader
//
//  Created by Golos on 05.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Combine

protocol Effect {
    associatedtype Action
    func mapToAction() -> AnyPublisher<Action, Never>
}
