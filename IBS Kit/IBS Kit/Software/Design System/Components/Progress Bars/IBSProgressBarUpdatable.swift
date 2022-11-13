//
//  IBSProgressBarUpdatable.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSProgressBarUpdatable

///
///
///
@available(iOS 13.0, *)
public protocol IBSProgressBarUpdatable: AnyObject {
    
    // MARK: - Public methods
    
    ///
    ///
    ///
    func update(progress: Float, with status: IBSProgressBarSyncStatus) -> Void
    
    ///
    ///
    ///
    func update(progress: Double, with status: IBSProgressBarSyncStatus) -> Void
}
