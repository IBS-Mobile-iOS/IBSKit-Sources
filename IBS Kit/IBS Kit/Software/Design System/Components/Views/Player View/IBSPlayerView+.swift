//
//  IBSPlayerView+.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSDesignRedrawable

extension IBSPlayerView: IBSDesignRedrawable {

    // MARK: - Public methods

    ///
    ///
    ///
    public func redraw() {
        layoutIfNeeded()
    }
}
