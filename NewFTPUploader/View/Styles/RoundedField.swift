//
//  RoundedField.swift
//  NewFTPUploader
//
//  Created by Golos on 27.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Foundation
import SwiftUI

struct RoundedField: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .frame(height: 44)
            .padding(5)
            .addBorder(Color.black, cornerRadius: 10)
            .background(Color.white)
    }
}
