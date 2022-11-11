//
//  IBSDevice.OperatingSystem.`Type`.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSDevice.OperatingSystem.`Type`

extension IBSDevice.OperatingSystem {

    ///
    /// An enumeration that represents a list of operating system types.
    ///
    public enum `Type`: String, CaseIterable {
        case mobile = "Mobile"
        case unknown = "Unknown OS type"
    }
}
