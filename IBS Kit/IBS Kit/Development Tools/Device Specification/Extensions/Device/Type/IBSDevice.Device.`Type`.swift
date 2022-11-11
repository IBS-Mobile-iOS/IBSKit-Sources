//
//  IBSDevice.Device.`Type`.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSDevice.Device.`Type`

extension IBSDevice.Device {

    ///
    /// An enumeration representing a list of device types.
    ///
    public enum `Type`: String, CaseIterable {
        case iPod = "iPod"
        case iPhone = "iPhone"
        case iPad = "iPad"
        case unknown = "Unknown device type"
    }
}
