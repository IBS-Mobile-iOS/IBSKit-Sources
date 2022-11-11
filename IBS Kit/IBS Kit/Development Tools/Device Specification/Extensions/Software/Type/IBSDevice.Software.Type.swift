//
//  IBSDevice.Software.Type.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSDevice.Software.Type

extension IBSDevice.Software {
    
    ///
    /// An enumeration that describes a list of application types.
    ///
    public enum `Type`: String, CaseIterable {
        case iOS = "iOS native app"
    }
}
