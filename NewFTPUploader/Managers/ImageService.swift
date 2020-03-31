//
//  ImageService.swift
//  NewFTPUploader
//
//  Created by Golos on 04.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Combine
import Kingfisher

protocol DownloaderSourceProtocol {
    func retrieveImage(with resource: URL, completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)?)
}

// MARK: DownloaderSourceProtocol
extension KingfisherManager: DownloaderSourceProtocol {
    func retrieveImage(with resource: URL, completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)?) {
        retrieveImage(with: resource, options: nil, completionHandler: completionHandler)
    }
}
protocol ImageServiceProtocol {
    func downloadImage(with url: URL) -> AnyPublisher<UIImage?, Never>
}

struct ImageService {
    private let loaderSource: DownloaderSourceProtocol

    init(loaderSource: DownloaderSourceProtocol = KingfisherManager.shared) {
        self.loaderSource = loaderSource
    }
}

// MARK: ImageServiceProtocol
extension ImageService: ImageServiceProtocol {
    func downloadImage(with url: URL) -> AnyPublisher<UIImage?, Never> {
        return Future { completion in
            self.loaderSource.retrieveImage(with: url) {
                switch $0 {
                case let .success(result):
                    completion(.success(result.image))
                case .failure:
                    completion(.success(nil))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
