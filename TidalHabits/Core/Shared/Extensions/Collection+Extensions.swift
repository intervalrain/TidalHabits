//
//  Collection+Extensions.swift
//  TidalHabits
//
//  Created on 2025-10-29
//  Copyright © 2025 TidalHabits. All rights reserved.
//

import Foundation

extension Collection {
    /// Safe subscript that returns nil if index is out of bounds
    /// - Parameter index: The index to access
    /// - Returns: Element at index, or nil if out of bounds
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

    /// Check if collection is not empty
    var isNotEmpty: Bool {
        return !isEmpty
    }
}

extension Array {
    /// Safely remove element at index
    /// - Parameter index: The index to remove
    /// - Returns: The removed element, or nil if index is out of bounds
    @discardableResult
    mutating func safeRemove(at index: Int) -> Element? {
        guard indices.contains(index) else { return nil }
        return remove(at: index)
    }

    /// Chunk array into smaller arrays of specified size
    /// - Parameter size: Size of each chunk
    /// - Returns: Array of chunked arrays
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

extension Array where Element: Equatable {
    /// Remove first occurrence of element
    /// - Parameter element: Element to remove
    /// - Returns: True if element was removed
    @discardableResult
    mutating func removeFirst(_ element: Element) -> Bool {
        if let index = firstIndex(of: element) {
            remove(at: index)
            return true
        }
        return false
    }

    /// Remove all occurrences of element
    /// - Parameter element: Element to remove
    /// - Returns: Number of elements removed
    @discardableResult
    mutating func removeAll(_ element: Element) -> Int {
        let beforeCount = count
        self = filter { $0 != element }
        return beforeCount - count
    }
}
