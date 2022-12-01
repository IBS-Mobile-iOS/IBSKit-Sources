//
//  IBSPadding.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
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
    public var top: CGFloat

    ///
    ///
    ///
    public var left: CGFloat

    ///
    ///
    ///
    public var right: CGFloat

    ///
    ///
    ///
    public var bottom: CGFloat

    ///
    ///
    ///
    public init(top: CGFloat = 0,
         left: CGFloat = 0,
         right: CGFloat = 0,
         bottom: CGFloat = 0) {
        self.top = top
        self.left = left
        self.right = right
        self.bottom = bottom
    }
}
