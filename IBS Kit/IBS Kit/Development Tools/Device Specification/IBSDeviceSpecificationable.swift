//
//  IBSDeviceSpecificationable.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSDeviceSpecificationable

///
/// A protocol describing iOS / iPadOS device specifications.
///
@available(iOS 13.0, *)
public protocol IBSDeviceSpecificationable: AnyObject {

    // MARK: - Public properties

    ///
    /// A property that allows you to get information about the current device.
    ///
    var device: IBSDevice.Device { get }

    ///
    /// A property that allows you to get information about the current version of the operating system.
    ///
    var operatingSystem: IBSDevice.OperatingSystem { get }

    ///
    /// A property that allows you to get information about the current device software.
    ///
    var software: IBSDevice.Software { get }

    ///
    /// A property that allows you to get information about the current hardware of the device.
    ///
    var hardware: IBSDevice.Hardware { get }

    ///
    /// A property that allows you to get the full specification of the current device.
    ///
    var specification: IBSDevice.Specification { get }
}
