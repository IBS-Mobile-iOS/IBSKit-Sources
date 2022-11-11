//
//  IBSDevice.Specification.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSDevice.Specification

extension IBSDevice {

    ///
    /// A structure describing the full specification of the current device.
    ///
    public struct Specification {

        ///
        /// A property that allows you to get information about the current device.
        ///
        public var device: Device

        ///
        /// A property that allows you to get information about the current version of the operating system.
        ///
        public var operatingSystem: OperatingSystem

        ///
        /// A property that allows you to get information about the current device software.
        ///
        public var software: Software

        ///
        /// A property that allows you to get information about the current hardware of the device.
        ///
        public var hardware: Hardware
    }
}
