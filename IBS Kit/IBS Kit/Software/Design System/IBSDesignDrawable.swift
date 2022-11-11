//
//  IBSDesignDrawable.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSDesignDrawable

///
///
///
@available(iOS 13.0, *)
@objc
protocol IBSDesignDrawable: AnyObject {

    // MARK: - Private functions

    @objc
    optional func setupRootView() -> Void

    func setupViews() -> Void

    @objc
    optional func makeLayout() -> Void

    @objc
    optional func computeFrames() -> Void
}
