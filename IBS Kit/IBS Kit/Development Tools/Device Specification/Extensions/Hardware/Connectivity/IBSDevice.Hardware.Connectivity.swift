//
//  IBSDevice.Hardware.Connectivity.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSDevice.Hardware.Connectivity

extension IBSDevice.Hardware {

    ///
    /// A structure describing the availability of sensors in the Connectivity section.
    ///
    public struct Connectivity {
        public var gps: SensorAvailability
        public var iBeacon: SensorAvailability
        public var bluetooth: SensorAvailability
    }
}
