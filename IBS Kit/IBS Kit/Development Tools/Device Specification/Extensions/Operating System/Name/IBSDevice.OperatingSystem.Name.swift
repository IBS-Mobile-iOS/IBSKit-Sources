//
//  IBSDevice.OperatingSystem.Name.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSDevice.OperatingSystem.Name

extension IBSDevice.OperatingSystem {

    ///
    /// An enumeration that represents a list of operating system names.
    ///
    public enum Name: String, CaseIterable {
        case iOS = "iOS"
        case iPadOS = "iPadOS"
        case undefined = "Undefined OS name"
    }
}
