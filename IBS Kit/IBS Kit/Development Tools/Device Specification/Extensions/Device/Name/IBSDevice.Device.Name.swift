//
//  IBSDevice.Device.Name.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSDevice.Device.Name

extension IBSDevice.Device {

    ///
    /// An enumeration representing a list of device names.
    ///
    public enum Name: String, CaseIterable {

        // iPods
        case iPod_touch_7th_generation = "iPod touch (7th generation)"


        case iPod_touch_undefinedName = "Undefined name of iPod touch"



        // iPhones
        case iPhone_6s = "iPhone 6s"
        case iPhone_6s_Plus = "iPhone 6s Plus"
        case iPhone_SE_1st_generation = "iPhone SE (1st generation)"

        case iPhone_7 = "iPhone 7"
        case iPhone_7_Plus = "iPhone 7 Plus"

        case iPhone_8 = "iPhone 8"
        case iPhone_8_Plus = "iPhone 8 Plus"
        case iPhone_X = "iPhone X"

        case iPhone_XS = "iPhone XS"
        case iPhone_XS_Max = "iPhone XS Max"
        case iPhone_XR = "iPhone XR"

        case iPhone_11 = "iPhone 11"
        case iPhone_11_Pro = "iPhone 11 Pro"
        case iPhone_11_Pro_Max = "iPhone 11 Pro Max"

        case iPhone_SE_2nd_generation = "iPhone SE (2nd generation)"

        case iPhone_12_mini = "iPhone 12 mini"
        case iPhone_12 = "iPhone 12"
        case iPhone_12_Pro = "iPhone 12 Pro"
        case iPhone_12_Pro_Max = "iPhone 12 Pro Max"

        case iPhone_13_mini = "iPhone 13 mini"
        case iPhone_13 = "iPhone 13"
        case iPhone_13_Pro = "iPhone 13 Pro"
        case iPhone_13_Pro_Max = "iPhone 13 Pro Max"

        case iPhone_SE_3rd_generation = "iPhone SE (3rd generation)"

        case iPhone_14 = "iPhone 14"
        case iPhone_14_Plus = "iPhone 14 Plus"
        case iPhone_14_Pro = "iPhone 14 Pro"
        case iPhone_14_Pro_Max = "iPhone 14 Pro Max"


        case iPhone_undefinedName = "Undefined name of iPhone"



        // iPads
        case iPad_mini_4 = "iPad mini 4"

        case iPad_Pro_12_9_1st_generation = "iPad Pro (12.9-inch) (1st generation)"
        case iPad_Pro_9_7 = "iPad Pro (9.7-inch)"

        case iPad_5th_generation = "iPad (5th generation)"

        case iPad_Pro_10_5 = "iPad Pro (10.5-inch)"
        case iPad_Pro_12_9_2nd_generation = "iPad Pro (12.9-inch) (2nd generation)"

        case iPad_6th_generation = "iPad (6th generation)"

        case iPad_Pro_11 = "iPad Pro (11-inch)"
        case iPad_Pro_12_9_3rd_generation = "iPad Pro (12.9-inch) (3rd generation)"

        case iPad_Air_3rd_generation = "iPad Air (3rd generation)"

        case iPad_mini_5th_generation = "iPad mini (5th generation)"

        case iPad_7th_generation = "iPad (7th generation)"

        case iPad_Pro_11_2nd_generation = "iPad Pro (11-inch) (2nd generation)"
        case iPad_Pro_12_9_4th_generation = "iPad Pro (12.9-inch) (4th generation)"

        case iPad_8th_generation = "iPad (8th generation)"

        case iPad_Air_4th_generation = "iPad Air (4th generation)"

        case iPad_Pro_11_3rd_generation = "iPad Pro (11-inch) (3rd generation)"
        case iPad_Pro_12_9_5th_generation = "iPad Pro (12.9-inch) (5th generation)"

        case iPad_9th_generation = "iPad (9th generation)"

        case iPad_mini_6th_generation = "iPad mini (6th generation)"

        case iPad_Air_5th_generation = "iPad Air (5th generation)"

        case iPad_10th_generation = "iPad (10th generation)"

        case iPad_Pro_11_4th_generation = "iPad Pro (11-inch) (4th generation)"
        case iPad_Pro_12_9_6th_generation = "iPad Pro (12.9-inch) (6th generation)"

        case iPad_undefinedName = "Undefined name of iPad"


        
        case undefined = "Undefined device name"
    }
}
