//
//  IBSDevice.Device.Model.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSDevice.Device.Model

extension IBSDevice.Device {

    ///
    /// An enumeration representing a list of device models.
    ///
    public enum Model: String, CaseIterable {
        case iPod_touch = "iPod touch"
        case iPhone = "iPhone"
        case iPad = "iPad"
        case unknown = "Unknown device model"
    }
}
