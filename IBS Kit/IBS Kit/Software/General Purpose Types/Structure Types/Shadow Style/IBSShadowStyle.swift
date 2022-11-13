//
//  IBSShadowStyle.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import UIKit



// MARK: - IBSShadowStyle

///
///
///
@available(iOS 13.0, *)
public struct IBSShadowStyle {

    ///
    ///
    ///
    var color: CGColor

    ///
    ///
    ///
    var opacity: Float

    ///
    ///
    ///
    var radius: CGFloat

    ///
    ///
    ///
    var offset: CGSize

    ///
    ///
    ///
    init(color: UIColor = .clear,
         opacity: Float = 0,
         radius: CGFloat = 0,
         offset: CGSize = .init()) {
        self.color = color.cgColor
        self.opacity = opacity
        self.radius = radius
        self.offset = offset
    }
}
