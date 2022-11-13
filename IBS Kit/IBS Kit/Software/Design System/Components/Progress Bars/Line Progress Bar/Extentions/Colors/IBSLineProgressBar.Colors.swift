//
//  IBSLineProgressBar.Colors.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import UIKit



// MARK: - IBSLineProgressBar.Colors

extension IBSLineProgressBar {
    
    ///
    ///
    ///
    public struct Colors {
        
        ///
        ///
        ///
        public var ring: UIColor
        
        ///
        ///
        ///
        public var progress: UIColor


        ///
        ///
        ///
        public init(ring: UIColor = .clear,
                    progress: UIColor = .clear) {
            self.ring = ring
            self.progress = progress
        }
    }
}
