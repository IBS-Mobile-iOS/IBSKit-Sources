//
//  IBSBorderStyle.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import UIKit



// MARK: - IBSBorderStyle

///
///
///
@available(iOS 13.0, *)
public struct IBSBorderStyle {

    ///
    ///
    ///
    public var color: CGColor

    ///
    ///
    ///
    public var width: CGFloat

    ///
    ///
    ///
    public init(color: UIColor = .clear,
         width: CGFloat = 0) {
        self.color = color.cgColor
        self.width = width
    }
}
