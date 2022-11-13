//
//  IBSStack.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSStack

///
///
///
@available(iOS 13.0, *)
@frozen
public struct IBSStack<Element: Equatable>: IBSStackable {
    
    // MARK: - Public typealiases
    
    ///
    ///
    ///
    public typealias ElementType = Element
    
    
    
    // MARK: - Private properties
    
    fileprivate var items: [ElementType] = []
    
    
    
    // MARK: - Public methods
    
    ///
    ///
    ///
    public mutating func push(_ element: ElementType) {
        items.append(element)
    }
    
    ///
    ///
    ///
    @discardableResult
    public mutating func pop() -> ElementType {
        items.removeLast()
    }
    
    ///
    ///
    ///
    public func peek() -> ElementType? {
        items.last
    }
    
    ///
    ///
    ///
    public mutating func dropAll() {
        items.removeAll()
    }
}



// MARK: - Equatable

@available(iOS 13.0, *)
extension IBSStack: Equatable {
    
    // MARK: - Public methods
    
    ///
    ///
    ///
    public static func == (lhs: IBSStack<ElementType>, rhs: IBSStack<ElementType>) -> Bool {
        lhs.items == rhs.items
    }
}
