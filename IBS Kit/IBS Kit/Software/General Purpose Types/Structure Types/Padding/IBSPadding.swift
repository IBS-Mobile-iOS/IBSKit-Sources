//
//  IBSPadding.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 12.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSPadding

///
///
///
@available(iOS 13.0, *)
public struct IBSPadding {

    ///
    ///
    ///
    var top: CGFloat

    ///
    ///
    ///
    var left: CGFloat

    ///
    ///
    ///
    var right: CGFloat

    ///
    ///
    ///
    var bottom: CGFloat

    ///
    ///
    ///
    init(top: CGFloat = 0,
         left: CGFloat = 0,
         right: CGFloat = 0,
         bottom: CGFloat = 0) {
        self.top = top
        self.left = left
        self.right = right
        self.bottom = bottom
    }
}
