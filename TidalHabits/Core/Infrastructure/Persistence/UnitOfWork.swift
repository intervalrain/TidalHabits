//
//  UnitOfWork.swift
//  TidalHabits
//
//  Created on 2025-10-29
//  Copyright © 2025 TidalHabits. All rights reserved.
//

import Foundation

/// Unit of Work implementation that manages transactions.
///
/// Reference: amantinband/clean-architecture
/// Delegates to AppDbContext for save operations and domain event handling
class UnitOfWork: IUnitOfWork {
    private let context: AppDbContext

    /// Initialize Unit of Work with database context
    /// - Parameter context: The application database context
    init(context: AppDbContext) {
        self.context = context
    }

    /// Save all changes to the database
    /// This triggers:
    /// 1. Domain event collection from AggregateRoots
    /// 2. CoreData save operation
    /// 3. Domain event dispatching
    func saveChangesAsync() async throws {
        try await context.saveChangesAsync()
    }
}
