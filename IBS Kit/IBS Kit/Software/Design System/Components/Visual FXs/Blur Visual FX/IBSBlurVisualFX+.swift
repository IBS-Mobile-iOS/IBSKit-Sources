//
//  IBSBlurVisualFX+.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSDesignRedrawable

@available(iOS 13.0, *)
extension IBSBlurVisualFX: IBSDesignRedrawable {
    
    // MARK: - Public methods
    
    ///
    ///
    ///
    public func redraw() {
        layoutIfNeeded()
    }
}
