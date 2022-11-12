//
//  IBSSplitSpaceController.LeftSideInitialState.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 12.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSSplitSpaceController.LeftSideInitialState

extension IBSSplitSpaceController {

    ///
    /// An enumeration describing a list of possible initial states for the left side.
    ///
    public enum LeftSideInitialState: String, CaseIterable {
        case fold = "Fold state"
        case unfold = "Unfold state"
    }
}
