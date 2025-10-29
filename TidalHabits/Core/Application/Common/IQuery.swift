//
//  IQuery.swift
//  TidalHabits
//
//  Created on 2025-10-29
//  Copyright © 2025 TidalHabits. All rights reserved.
//

import Foundation

/// Marker protocol for queries in CQRS pattern.
/// Queries represent read operations that don't change system state.
///
/// Reference: amantinband/clean-architecture
/// Similar to .NET MediatR's IRequest<TResponse>
protocol IQuery {
    associatedtype TResult
}
