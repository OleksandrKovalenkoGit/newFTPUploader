//
//  LoaderView.swift
//  NewFTPUploader
//
//  Created by Golos on 05.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.1).edgesIgnoringSafeArea(.all)
            Spinner(isAnimating: true, style: .large)
        }
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
