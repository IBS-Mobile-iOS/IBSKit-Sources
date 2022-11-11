//
//  IBSDevice.OperatingSystem.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSDevice.OperatingSystem

extension IBSDevice {

    ///
    /// A structure describing the type, name, and operating system version of the current device.
    ///
    public struct OperatingSystem {

        ///
        /// A property that allows you to get the operating system type of the current device.
        ///
        public var type: `Type`

        ///
        /// A property that allows you to get the operating system name of the current device.
        ///
        public var name: Name

        ///
        /// A property that allows you to get the full name of the operating system of the current device.
        ///
        public var fullname: String

        ///
        /// A property that allows you to get the operating system version of the current device in the major.minor.patch format.
        ///
        public var version: Version
    }
}
