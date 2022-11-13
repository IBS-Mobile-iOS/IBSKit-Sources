//
//  IBSLineProgressBar+.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSDesignRedrawble

extension IBSLineProgressBar: IBSDesignRedrawable {
    
    // MARK: - Public methods
    
    ///
    ///
    ///
    func redraw() {
        layoutIfNeeded()
    }
}
