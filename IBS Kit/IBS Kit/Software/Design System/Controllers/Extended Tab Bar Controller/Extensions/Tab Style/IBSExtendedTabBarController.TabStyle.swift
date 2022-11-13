//
//  IBSExtendedTabBarController.TabStyle.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import UIKit



// MARK: - IBSExtendedTabBarController.TabStyle

extension IBSExtendedTabBarController {
    
    ///
    ///
    ///
    public struct TabStyle {
        
        ///
        ///
        ///
        var image: UIImage
        
        ///
        ///
        ///
        init(image: UIImage = .init()) {
            self.image = image
        }
    }
}
