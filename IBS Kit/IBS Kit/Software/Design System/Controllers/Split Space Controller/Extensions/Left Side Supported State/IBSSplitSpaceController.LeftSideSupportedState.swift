//
//  IBSSplitSpaceController.LeftSideSupportedState.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 12.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSSplitSpaceController.LeftSideSupportedState

extension IBSSplitSpaceController {

    ///
    /// An enumeration that describes the list of supported states on the left side.
    ///
    public enum LeftSideSupportedState: String, CaseIterable {
        case all = "All states"
        case fold = "Fold state"
        case unfold = "Unfold state"
    }
}
