//
//  IBSDevice.Hardware.SensorAvailability.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSDevice.Hardware.SensorAvailability

extension IBSDevice.Hardware {
    
    ///
    /// An enumeration describing the availability of sensors in the hardware.
    ///
    public enum SensorAvailability: String, CaseIterable {
        case available = "Available"
        case unavailable = "Unavailable"
    }
}
