//
//  ImageDownloader.swift
//  NewFTPUploader
//
//  Created by Golos on 04.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    @Injectable var imageService: ImageServiceProtocol
    private var cancellable: AnyCancellable?
    
    deinit {
        cancellable?.cancel()
    }
    
    func load(with url: URL) {
        cancellable = imageService.downloadImage(with: url)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}
