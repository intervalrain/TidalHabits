//
//  ICommandHandler.swift
//  TidalHabits
//
//  Created on 2025-10-29
//  Copyright © 2025 TidalHabits. All rights reserved.
//

import Foundation

/// Handler protocol for processing commands.
///
/// Reference: amantinband/clean-architecture
/// Similar to .NET MediatR's IRequestHandler<TRequest, TResponse>
protocol ICommandHandler {
    associatedtype TCommand: ICommand
    associatedtype TResult

    func handleAsync(_ command: TCommand) async throws -> TResult
}
