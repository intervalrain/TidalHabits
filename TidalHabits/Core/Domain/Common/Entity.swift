//
//  Entity.swift
//  TidalHabits
//
//  Created on 2025-10-29
//  Copyright © 2025 TidalHabits. All rights reserved.
//

import Foundation

/// Base class for all entities in the domain layer.
/// Entities have a unique identifier and their equality is based on their ID.
///
/// Reference: amantinband/clean-architecture
class Entity: Equatable {
    let id: UUID

    init(id: UUID) {
        self.id = id
    }

    static func == (lhs: Entity, rhs: Entity) -> Bool {
        return lhs.id == rhs.id
    }
}