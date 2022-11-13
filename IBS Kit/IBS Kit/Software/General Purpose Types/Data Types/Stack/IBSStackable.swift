//
//  IBSStackable.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSStackable

///
///
///
@available(iOS 13.0, *)
public protocol IBSStackable: Any {
    
    // MARK: - Associated generic types
    
    ///
    ///
    ///
    associatedtype ElementType
    
    
    
    // MARK: - Public methods
    
    ///
    ///
    ///
    mutating func push(_ element: ElementType) -> Void
    
    ///
    ///
    ///
    @discardableResult
    mutating func pop() -> ElementType
    
    ///
    ///
    ///
    func peek() -> ElementType?
    
    ///
    ///
    ///
    mutating func dropAll() -> Void
}
