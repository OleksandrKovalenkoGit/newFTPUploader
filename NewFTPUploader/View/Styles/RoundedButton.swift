//
//  RoundedButton.swift
//  NewFTPUploader
//
//  Created by Golos on 27.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Foundation
import SwiftUI

struct RoundedButton: ButtonStyle {
    let size: CGSize
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .frame(width: size.width, height: size.height)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        Button("test", action: {})
            .buttonStyle(
                RoundedButton(size: CGSize(width: 75, height: 35))
        )
    }
}
