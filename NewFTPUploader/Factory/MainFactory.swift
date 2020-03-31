//
//  MainFactory.swift
//  NewFTPUploader
//
//  Created by Golos on 04.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import UIKit
import SwiftUI

protocol FactoryProtocol {
    var buildController: UIViewController { get }
}

struct MainFactory<State, Action> {
    let store: Store<State, Action>
}

// MARK: FactoryProtocol
extension MainFactory: FactoryProtocol {
    var buildController: UIViewController {
        let mainView = MainView()
            .environmentObject(store)
        
        return UIHostingController(rootView: mainView)
    }
}
