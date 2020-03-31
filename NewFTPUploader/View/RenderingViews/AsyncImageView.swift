//
//  AsyncImageView.swift
//  NewFTPUploader
//
//  Created by Golos on 04.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import SwiftUI

struct AsyncImageView: View {
    @ObservedObject var loader: ImageLoader
    let url: URL
    let placeholder: UIImage

    init?(url: String, placeholder: UIImage = UIImage(), loader: ImageLoader = ImageLoader()) {
        self.loader = loader
        self.placeholder = placeholder
        
        guard let url = URL(string: url) else { return nil }
        self.url = url
        
        loader.load(with: url)
    }
    
    var body: some View {
        Image(uiImage: loader.image ?? placeholder)
            .resizable()
            .onAppear { self.loader.load(with: self.url) }
            .onDisappear(perform: loader.cancel)
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(url: "")
    }
}
