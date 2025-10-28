//
//  Entity.swift
//  TidalHabits
//
//  Created on 2025-10-28.
//

import Foundation

/// Base protocol for all Domain Entities
/// Entities have a unique identifier and are compared by their ID
protocol Entity: Identifiable, Equatable where ID == UUID {
    var id: UUID { get }
}

// Default Equatable implementation for Entity
extension Entity {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
