//
//  AggregateRoot.swift
//  TidalHabits
//
//  Created on 2025-10-29
//  Copyright © 2025 TidalHabits. All rights reserved.
//

import Foundation

/// Base class for Aggregate Roots in the domain layer.
/// Aggregate Roots manage domain events and maintain consistency boundaries.
///
/// Reference: amantinband/clean-architecture
class AggregateRoot: Entity {
    private var _domainEvents: [IDomainEvent] = []

    /// Collection of domain events raised by this aggregate
    var domainEvents: [IDomainEvent] {
        return _domainEvents
    }

    /// Raise a domain event
    /// - Parameter event: The domain event to raise
    func raiseDomainEvent(_ event: IDomainEvent) {
        _domainEvents.append(event)
    }

    /// Clear all domain events (typically called after publishing)
    func clearDomainEvents() {
        _domainEvents.removeAll()
    }
}