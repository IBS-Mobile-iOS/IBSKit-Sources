//
//  IBSCountdownViewDelegate.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSCountdownViewDelegate

///
///
///
@available(iOS 13.0, *)
public protocol IBSCountdownViewDelegate: AnyObject {

    // MARK: - Public methods

    ///
    ///
    ///
    func countdownDidFinished() -> Void
}
