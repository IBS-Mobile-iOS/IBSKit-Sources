//
//  IBSCornersStyle.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import CoreGraphics



// MARK: - IBSCornersStyle

///
///
///
@available(iOS 13.0, *)
public struct IBSCornersStyle {

    ///
    ///
    ///
    public enum CornersSet {
        case topLeft
        case top
        case topRight
        case left
        case leftDiagonal
        case right
        case rightDiagonal
        case bottomLeft
        case bottom
        case bottomRight
        case all
    }

    ///
    ///
    ///
    public enum CurveType {
        case continuous
        case circular
    }

    ///
    ///
    ///
    public var set: CornersSet?

    ///
    ///
    ///
    public var curve: CurveType

    ///
    ///
    ///
    public var radius: CGFloat

    ///
    ///
    ///
    public init(set: CornersSet? = nil,
                curve: CurveType = .circular,
                radius: CGFloat = 0) {
        self.set = set
        self.curve = curve
        self.radius = radius
    }
}

