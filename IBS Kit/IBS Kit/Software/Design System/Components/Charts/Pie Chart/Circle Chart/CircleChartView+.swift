//
//  CircleChartView+.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSDesignRedrawable

extension CircleChartView: IBSDesignRedrawable {
    
    // MARK: - Public methods

    ///
    /// A method that redraws a custom view.
    ///
    /// This method must be called every time it is necessary to redraw a view conforming to the IBSDesignRedrawable protocol.
    ///
    /// - authors: Dmitry Novikov
    ///
    /// - bug: None
    ///
    func redraw() {
        setNeedsDisplay()
    }
}
