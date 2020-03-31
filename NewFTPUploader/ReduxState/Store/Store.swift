//
//  Store.swift
//  NewFTPUploader
//
//  Created by Golos on 31.03.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Foundation
import Combine

final class Store<State, Action>: ObservableObject {
    @Published private(set) var state: State
    private let reducer: Reducer<State, Action>
    private var cancellables = Set<AnyCancellable>()

    init(initialState: State, reducer: Reducer<State, Action>) {
        self.state = initialState
        self.reducer = reducer
    }
    
    func send(_ action: Action) {
        reducer.reduce(&state, action)
    }
    
    func send<E: Effect>(_ effect: E) where E.Action == Action {
        effect
            .mapToAction()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: send)
            .store(in: &cancellables)
    }
}
