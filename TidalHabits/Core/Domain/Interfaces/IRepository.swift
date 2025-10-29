//
//  IRepository.swift
//  TidalHabits
//
//  Created on 2025-10-29
//  Copyright © 2025 TidalHabits. All rights reserved.
//

import Foundation

/// Generic repository interface for CRUD operations on entities.
///
/// Reference: amantinband/clean-architecture
/// Similar to .NET's IRepository<TEntity> pattern
protocol IRepository {
    associatedtype TEntity: Entity

    func getByIdAsync(id: UUID) async throws -> TEntity?
    func getAllAsync() async throws -> [TEntity]
    func addAsync(_ entity: TEntity) async throws
    func updateAsync(_ entity: TEntity) async throws
    func deleteAsync(_ entity: TEntity) async throws
}
