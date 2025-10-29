//
//  IQueryHandler.swift
//  TidalHabits
//
//  Created on 2025-10-29
//  Copyright © 2025 TidalHabits. All rights reserved.
//

import Foundation

/// Handler protocol for processing queries.
///
/// Reference: amantinband/clean-architecture
/// Similar to .NET MediatR's IRequestHandler<TRequest, TResponse>
protocol IQueryHandler {
    associatedtype TQuery: IQuery
    associatedtype TResult

    func handleAsync(_ query: TQuery) async throws -> TResult
}
