//
//  InstallEffect.swift
//  NewFTPUploader
//
//  Created by Golos on 05.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Foundation
import Combine

struct InstallEffect: Effect {
    let urlString: String
    @Injectable var urlController: UrlControllerProtocol

    func mapToAction() -> AnyPublisher<AppAction, Never> {
        return Future { completion in
            guard let url = URL(string: self.urlString) else {
                completion(.success(.build(.stopLoading)))
                return
            }
            self.urlController.open(url, options: [:]) { _ in
                completion(.success(.build(.stopLoading)))
            }
        }
        .eraseToAnyPublisher()
    }
}
