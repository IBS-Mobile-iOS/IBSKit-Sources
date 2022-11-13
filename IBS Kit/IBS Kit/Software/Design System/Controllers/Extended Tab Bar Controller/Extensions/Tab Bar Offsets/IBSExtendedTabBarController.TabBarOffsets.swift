//
//  IBSExtendedTabBarController.TabBarOffsets.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSExtendedTabBarController.TabBarOffsets

extension IBSExtendedTabBarController {
    
    ///
    ///
    ///
    public struct TabBarOffsets {

        ///
        ///
        ///
        public struct Padding {

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
            init(left: CGFloat = 0,
                 right: CGFloat = 0,
                 bottom: CGFloat = 0) {
                self.left = left
                self.right = right
                self.bottom = bottom
            }
        }

        ///
        ///
        ///
        var padding: Padding

        ///
        ///
        ///
        var spacing: CGFloat

        ///
        ///
        ///
        var height: CGFloat

        ///
        ///
        ///
        init(padding: Padding = .init(),
             spacing: CGFloat = 0,
             height: CGFloat = 0) {
            self.padding = padding
            self.spacing = spacing
            self.height = height
        }
    }
}
