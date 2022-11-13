//
//  IBSExtendedTabBarController.TabBarStyle.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import UIKit



// MARK: - IBSExtendedTabBarController.TabBarStyle

extension IBSExtendedTabBarController {
    
    ///
    ///
    ///
    public struct TabBarStyle {

        ///
        ///
        ///
        var color: UIColor

        ///
        ///
        ///
        var border: IBSBorderStyle

        ///
        ///
        ///
        var corners: IBSCornersStyle

        ///
        ///
        ///
        var shadow: IBSShadowStyle

        ///
        ///
        ///
        init(color: UIColor = .clear,
             border: IBSBorderStyle = .init(),
             corners: IBSCornersStyle = .init(),
             shadow: IBSShadowStyle = .init()) {
            self.color = color
            self.border = border
            self.corners = corners
            self.shadow = shadow
        }
    }
}
