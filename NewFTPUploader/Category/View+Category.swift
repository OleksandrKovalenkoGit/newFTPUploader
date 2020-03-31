//
//  View+Category.swift
//  NewFTPUploader
//
//  Created by Golos on 02.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import SwiftUI

extension View {
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S: ShapeStyle {
        return overlay(RoundedRectangle(cornerRadius: cornerRadius)
            .strokeBorder(content, lineWidth: width))
    }
}
