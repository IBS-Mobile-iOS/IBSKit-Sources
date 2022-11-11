//
//  IBSHaptic.FeedbackType.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSHaptic.FeedbackType

extension IBSHaptic {

    ///
    /// An enumeration that describes a list of feedback types.
    ///
    public enum FeedbackType: String, CaseIterable {
        case error = "Error feedback type"
        case warning = "Warning feedback type"
        case success = "Success feedback type"
        case soft = "Soft feedback type"
        case light = "Light feedback type"
        case medium = "Medium feedback type"
        case heavy = "Heavy feedback type"
        case rigid = "Rigid feedback type"
        case selection = "Selection feedback type"
    }
}
