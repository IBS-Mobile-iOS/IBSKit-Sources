//
//  IBSPieChart.Pattern.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import CoreGraphics



// MARK: - IBSPieChart.Pattern

extension IBSPieChart {
    
    ///
    ///
    ///
    public struct Pattern {

        ///
        ///
        ///
        public var size: CGFloat

        ///
        ///
        ///
        public var repeatsCount: CGFloat

        ///
        ///
        ///
        public var direction: PatternDirection

        ///
        ///
        ///
        public init(size: CGFloat,
                    repeatsCount: UInt16,
                    direction: PatternDirection = .topSide) {
            self.size = size
            self.repeatsCount = CGFloat(repeatsCount)
            self.direction = direction
        }
    }
}
