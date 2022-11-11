//
//  IBSDevice.Hardware.Network.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSDevice.Hardware.Network

extension IBSDevice.Hardware {

    ///
    /// A structure describing the availability of sensors in the Network section.
    ///
    public struct Network {
        public var cellular: SensorAvailability
        public var wifi: SensorAvailability
    }
}
