//
//  IBSProgressBarSyncStatus.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSProgressBarSyncStatus

///
///
///
@available(iOS 13.0, *)
public enum IBSProgressBarSyncStatus {
    case error
    case required
    case inProgress
    case completed
}
