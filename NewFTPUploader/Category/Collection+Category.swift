//
//  Collection+Category.swift
//  NewFTPUploader
//
//  Created by Golos on 01.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Foundation

extension Collection {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    func element(at index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
