//
//  BaseRepository.swift
//  TidalHabits
//
//  Created on 2025-10-29
//  Copyright © 2025 TidalHabits. All rights reserved.
//

import CoreData
import Foundation

/// Base repository implementation providing generic CRUD operations.
///
/// Reference: amantinband/clean-architecture
/// This is a generic repository that can be inherited by feature-specific repositories.
///
/// Note: This is a simplified version. In production, you would need:
/// 1. Proper mapping between Domain Entities and NSManagedObjects
/// 2. A registry to track domain entities for event collection
/// 3. More sophisticated query capabilities
class BaseRepository<TEntity: Entity>: IRepository {
    typealias TEntity = TEntity

    protected let context: AppDbContext
    protected let entityName: String

    /// Initialize repository with app context
    /// - Parameters:
    ///   - context: The application database context
    ///   - entityName: CoreData entity name
    init(context: AppDbContext, entityName: String) {
        self.context = context
        self.entityName = entityName
    }

    // MARK: - IRepository Implementation

    func getByIdAsync(id: UUID) async throws -> TEntity? {
        return try await context.viewContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            fetchRequest.fetchLimit = 1

            let results = try fetchRequest.execute()

            guard let managedObject = results.first else {
                return nil
            }

            return try self.mapToDomainEntity(managedObject)
        }
    }

    func getAllAsync() async throws -> [TEntity] {
        return try await context.viewContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entityName)

            let results = try fetchRequest.execute()

            return try results.map { try self.mapToDomainEntity($0) }
        }
    }

    func addAsync(_ entity: TEntity) async throws {
        try await context.viewContext.perform {
            let managedObject = NSEntityDescription.insertNewObject(
                forEntityName: self.entityName,
                into: self.context.viewContext
            )

            try self.mapToManagedObject(entity, managedObject: managedObject)
        }
    }

    func updateAsync(_ entity: TEntity) async throws {
        try await context.viewContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
            fetchRequest.predicate = NSPredicate(format: "id == %@", entity.id as CVarArg)
            fetchRequest.fetchLimit = 1

            let results = try fetchRequest.execute()

            guard let managedObject = results.first else {
                throw ApplicationException.notFound("Entity with id \(entity.id) not found")
            }

            try self.mapToManagedObject(entity, managedObject: managedObject)
        }
    }

    func deleteAsync(_ entity: TEntity) async throws {
        try await context.viewContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
            fetchRequest.predicate = NSPredicate(format: "id == %@", entity.id as CVarArg)
            fetchRequest.fetchLimit = 1

            let results = try fetchRequest.execute()

            guard let managedObject = results.first else {
                throw ApplicationException.notFound("Entity with id \(entity.id) not found")
            }

            self.context.viewContext.delete(managedObject)
        }
    }

    // MARK: - Mapping Methods (To be overridden by subclasses)

    /// Map NSManagedObject to Domain Entity
    /// Override this in subclasses for specific entity mapping
    func mapToDomainEntity(_ managedObject: NSManagedObject) throws -> TEntity {
        fatalError("mapToDomainEntity must be overridden by subclass")
    }

    /// Map Domain Entity to NSManagedObject
    /// Override this in subclasses for specific entity mapping
    func mapToManagedObject(_ entity: TEntity, managedObject: NSManagedObject) throws {
        fatalError("mapToManagedObject must be overridden by subclass")
    }
}

// MARK: - Protected Access Helper

/// Helper protocol to enable protected access pattern
/// In Swift, we can't have true 'protected' access, but we can use this pattern
protocol ProtectedRepositoryAccess {
    associatedtype TEntity: Entity
    var context: AppDbContext { get }
    var entityName: String { get }
}

extension BaseRepository: ProtectedRepositoryAccess {
    var protectedContext: AppDbContext { return context }
    var protectedEntityName: String { return entityName }
}
