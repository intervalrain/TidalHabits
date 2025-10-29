//
//  ICommand.swift
//  TidalHabits
//
//  Created on 2025-10-29
//  Copyright © 2025 TidalHabits. All rights reserved.
//

import Foundation

/// Marker protocol for commands in CQRS pattern.
/// Commands represent write operations that change system state.
///
/// Reference: amantinband/clean-architecture
/// Similar to .NET MediatR's IRequest<TResponse>
protocol ICommand {
    associatedtype TResult
}
