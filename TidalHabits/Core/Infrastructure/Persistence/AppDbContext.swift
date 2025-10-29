//
//  AppDbContext.swift
//  TidalHabits
//
//  Created on 2025-10-29
//  Copyright © 2025 TidalHabits. All rights reserved.
//

import CoreData
import Foundation

/// Application database context that wraps CoreData and handles domain events.
///
/// Reference: amantinband/clean-architecture ApplicationDbContext
/// Key features:
/// - Encapsulates CoreData NSPersistentContainer
/// - Collects domain events from AggregateRoots before save
/// - Dispatches domain events after successful save
class AppDbContext {
    private let persistenceController: PersistenceController

    /// Main view context for UI operations
    var viewContext: NSManagedObjectContext {
        return persistenceController.container.viewContext
    }

    /// Background context for heavy operations
    var backgroundContext: NSManagedObjectContext {
        return persistenceController.container.newBackgroundContext()
    }

    /// Domain event dispatcher (will be injected)
    private var eventDispatcher: DomainEventDispatcher?

    init(persistenceController: PersistenceController = .shared) {
        self.persistenceController = persistenceController
    }

    /// Set the event dispatcher
    func setEventDispatcher(_ dispatcher: DomainEventDispatcher) {
        self.eventDispatcher = dispatcher
    }

    /// Save changes to the context and dispatch domain events
    /// Similar to ApplicationDbContext.SaveChangesAsync in .NET
    func saveChangesAsync() async throws {
        // 1. Collect domain events from tracked entities
        let events = await collectDomainEvents()

        // 2. Save to CoreData
        try await viewContext.perform {
            guard self.viewContext.hasChanges else { return }
            try self.viewContext.save()
        }

        // 3. Dispatch domain events after successful save
        if let dispatcher = eventDispatcher {
            await dispatcher.dispatchEventsAsync(events)
        }
    }

    /// Collect domain events from all changed objects in the context
    /// This method finds AggregateRoots and pops their events
    private func collectDomainEvents() async -> [IDomainEvent] {
        return await viewContext.perform {
            var allEvents: [IDomainEvent] = []

            // Get all changed objects (inserted + updated)
            let changedObjects = self.viewContext.insertedObjects.union(self.viewContext.updatedObjects)

            // For each changed object, check if we can extract domain events
            for object in changedObjects {
                // Note: In real implementation, you would need a way to map
                // NSManagedObject to domain AggregateRoot
                // This could be done through a registry or protocol
                if let events = self.extractDomainEvents(from: object) {
                    allEvents.append(contentsOf: events)
                }
            }

            return allEvents
        }
    }

    /// Extract domain events from a managed object
    /// This is a placeholder - actual implementation depends on your mapping strategy
    private func extractDomainEvents(from object: NSManagedObject) -> [IDomainEvent]? {
        // TODO: Implement mapping from NSManagedObject to AggregateRoot
        // Options:
        // 1. Store a weak reference to domain entity in NSManagedObject
        // 2. Use a registry pattern to track domain entities
        // 3. Reconstruct domain entity from NSManagedObject
        return nil
    }

    /// Rollback changes in the context
    func rollback() {
        viewContext.rollback()
    }
}

// MARK: - Domain Event Dispatcher

/// Dispatches domain events to their handlers
/// Similar to MediatR's IPublisher in .NET
class DomainEventDispatcher {
    // Event handlers will be registered here
    private var handlers: [String: [(IDomainEvent) async throws -> Void]] = [:]

    /// Register a handler for a specific event type
    func registerHandler<TEvent: IDomainEvent>(
        eventType: TEvent.Type,
        handler: @escaping (TEvent) async throws -> Void
    ) {
        let key = String(describing: eventType)
        let wrappedHandler: (IDomainEvent) async throws -> Void = { event in
            if let typedEvent = event as? TEvent {
                try await handler(typedEvent)
            }
        }

        if handlers[key] == nil {
            handlers[key] = []
        }
        handlers[key]?.append(wrappedHandler)
    }

    /// Dispatch all events to their registered handlers
    func dispatchEventsAsync(_ events: [IDomainEvent]) async {
        for event in events {
            let key = String(describing: type(of: event))

            if let eventHandlers = handlers[key] {
                for handler in eventHandlers {
                    do {
                        try await handler(event)
                    } catch {
                        // Log error but continue processing other events
                        print("Error handling domain event \(key): \(error)")
                    }
                }
            }
        }
    }
}