//
//  IDomainEvent.swift
//  TidalHabits
//
//  Created on 2025-10-29
//  Copyright © 2025 TidalHabits. All rights reserved.
//

import Foundation

/// Marker protocol for domain events.
/// Domain events represent something that happened in the domain.
///
/// Reference: amantinband/clean-architecture
/// In .NET, this inherits from MediatR's INotification.
/// In Swift, we use a simple marker protocol.
protocol IDomainEvent {
    var occurredOn: Date { get }
}