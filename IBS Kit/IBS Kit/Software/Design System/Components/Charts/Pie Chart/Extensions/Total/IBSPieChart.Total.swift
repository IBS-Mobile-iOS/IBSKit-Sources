//
//  IBSPieChart.Total.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import UIKit



// MARK: - IBSPieChart.Total

extension IBSPieChart {
    
    ///
    ///
    ///
    public struct Total {

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
        public var offset: CGFloat

        ///
        ///
        ///
        public init(value: Int,
                    color: UIColor = .clear,
                    offset: CGFloat = 0.0) {
            self.value = CGFloat(value)
            self.color = color
            self.offset = offset
        }

        ///
        ///
        ///
        public init(value: Float,
                    color: UIColor = .clear,
                    offset: CGFloat = 0.0) {
            self.value = CGFloat(value)
            self.color = color
            self.offset = offset
        }
    }
}
