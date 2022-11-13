//
//  IBSPieChart.Segment.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import UIKit



// MARK: - IBSPieChart.Segment

extension IBSPieChart {
    
    ///
    ///
    ///
    public struct Segment {

        ///
        ///
        ///
        public var style: SegmentStyle

        ///
        ///
        ///
        public var value: CGFloat

        ///
        ///
        ///
        public var color: UIColor

        ///
        ///
        ///
        public init(style: SegmentStyle = .filled,
                    value: Int,
                    color: UIColor = .clear) {
            self.style = style
            self.value = CGFloat(value)
            self.color = color
        }

        ///
        ///
        ///
        public init(style: SegmentStyle = .filled,
                    value: Float,
                    color: UIColor = .clear) {
            self.style = style
            self.value = CGFloat(value)
            self.color = color
        }
    }
}
