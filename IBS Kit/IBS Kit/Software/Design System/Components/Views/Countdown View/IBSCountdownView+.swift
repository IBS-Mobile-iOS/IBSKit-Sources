//
//  IBSCountdownView+.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSDesignRedrawable

@available(iOS 13.0, *)
extension IBSCountdownView: IBSDesignRedrawable {

    // MARK: - Public methods

    ///
    ///
    ///
    public func redraw() {
        layoutIfNeeded()
    }
}
