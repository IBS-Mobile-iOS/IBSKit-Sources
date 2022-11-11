//
//  IBSDevice.OperatingSystem.Version.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSDevice.OperatingSystem.Version

extension IBSDevice.OperatingSystem {

    ///
    /// A structure representing the version of the operating system.
    ///
    public struct Version {
        public var major: UInt16
        public var minor: UInt16
        public var patch: UInt16
    }
}
