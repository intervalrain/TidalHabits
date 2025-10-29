# TidalHabits Clean Architecture 實作指南

基於 **amantinband/clean-architecture** 設計的 Swift 實作指南。

**參考專案**: [amantinband/clean-architecture](https://github.com/amantinband/clean-architecture)

---

## 核心設計原則

### 1. Domain Layer

#### Entity & AggregateRoot
- **Entity** 使用 **base class**（非 protocol）
- **AggregateRoot** 繼承 Entity，管理 Domain Events
- Entity 相等性基於 ID

```swift
class Entity: Equatable {
    let id: UUID

    init(id: UUID) {
        self.id = id
    }

    static func == (lhs: Entity, rhs: Entity) -> Bool {
        return lhs.id == rhs.id
    }
}

class AggregateRoot: Entity {
    private var _domainEvents: [IDomainEvent] = []

    func raiseDomainEvent(_ event: IDomainEvent) {
        _domainEvents.append(event)
    }

    func popDomainEvents() -> [IDomainEvent] {
        let events = _domainEvents
        _domainEvents.removeAll()
        return events
    }
}
```

#### ValueObject
- Generic base class 支援任何 Equatable 型別
- 提供驗證機制
- Immutable by design (使用 `let`)

```swift
class ValueObject<T: Equatable>: Equatable {
    let value: T

    init(_ value: T) throws {
        try Self.validate(value)
        self.value = value
    }

    class func validate(_ value: T) throws {
        // Override in subclasses
    }

    static func == (lhs: ValueObject<T>, rhs: ValueObject<T>) -> Bool {
        return lhs.value == rhs.value
    }
}

// Example usage
class HabitName: ValueObject<String> {
    override class func validate(_ value: String) throws {
        guard !value.isEmpty else {
            throw DomainException.validationFailed("Habit name cannot be empty")
        }
        guard value.count <= 50 else {
            throw DomainException.validationFailed("Habit name too long")
        }
    }
}
```

#### Domain Events
- **IDomainEvent** 是 marker protocol
- 每個 event 包含 `occurredOn` 時間戳
- Events 由 AggregateRoot 管理

```swift
protocol IDomainEvent {
    var occurredOn: Date { get }
}

struct HabitCreatedEvent: IDomainEvent {
    let occurredOn: Date
    let habitId: UUID
    let name: String

    init(habitId: UUID, name: String) {
        self.occurredOn = Date()
        self.habitId = habitId
        self.name = name
    }
}

// Usage in Aggregate
class Habit: AggregateRoot {
    static func create(name: String, iconId: String) throws -> Habit {
        let habit = Habit(id: UUID(), ...)
        habit.raiseDomainEvent(HabitCreatedEvent(habitId: habit.id, name: name))
        return habit
    }
}
```

---

### 2. Application Layer

#### CQRS Pattern
- Commands 和 Queries 使用 marker protocols
- Handlers 處理業務邏輯
- 使用 Swift's Result type 或直接 throws

```swift
// Command
protocol ICommand {
    associatedtype TResult
}

struct CreateHabitCommand: ICommand {
    typealias TResult = UUID
    let name: String
    let iconId: String
}

// Command Handler
protocol ICommandHandler {
    associatedtype TCommand: ICommand
    associatedtype TResult

    func handleAsync(_ command: TCommand) async throws -> TResult
}

class CreateHabitCommandHandler: ICommandHandler {
    typealias TCommand = CreateHabitCommand
    typealias TResult = UUID

    private let repository: IHabitRepository
    private let unitOfWork: IUnitOfWork

    func handleAsync(_ command: TCommand) async throws -> UUID {
        // 1. Create domain entity
        let habit = try Habit.create(name: command.name, iconId: command.iconId)

        // 2. Save via repository
        try await repository.addAsync(habit)

        // 3. Commit (this triggers domain events)
        try await unitOfWork.saveChangesAsync()

        return habit.id
    }
}
```

#### Result Type
- Swift 內建的 Result 或自訂版本
- 提供 type-safe error handling

```swift
enum Result<TValue, TError: Error> {
    case success(TValue)
    case failure(TError)

    var isSuccess: Bool {
        if case .success = self { return true }
        return false
    }

    var value: TValue? {
        if case .success(let value) = self { return value }
        return nil
    }
}

// Usage
func createHabitAsync(command: CreateHabitCommand) async -> Result<UUID, Error> {
    do {
        let id = try await handler.handleAsync(command)
        return .success(id)
    } catch {
        return .failure(error)
    }
}
```

#### DTOs (Data Transfer Objects)
- 用於跨層傳輸資料
- Immutable structs
- 使用 `Dto` 後綴命名

```swift
struct HabitDto {
    let id: UUID
    let name: String
    let iconId: String
    let defaultDuration: TimeInterval
    let starsReward: Int
    let isActive: Bool

    init(from habit: Habit) {
        self.id = habit.id
        self.name = habit.name.value  // from ValueObject
        self.iconId = habit.iconId.value
        self.defaultDuration = habit.defaultDuration
        self.starsReward = habit.starsReward
        self.isActive = habit.isActive
    }
}
```

---

### 3. Infrastructure Layer

#### AppDbContext
- 封裝 CoreData 的 PersistentContainer
- **關鍵**: 在 save 時處理 Domain Events

```swift
class AppDbContext {
    private let container: NSPersistentContainer

    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    func saveChangesAsync() async throws {
        // 1. Collect domain events from changed objects
        let events = collectDomainEventsFromContext()

        // 2. Save to CoreData
        try await viewContext.perform {
            guard viewContext.hasChanges else { return }
            try viewContext.save()
        }

        // 3. Dispatch domain events
        await dispatchDomainEvents(events)
    }

    private func collectDomainEventsFromContext() -> [IDomainEvent] {
        var events: [IDomainEvent] = []

        // Iterate through inserted/updated objects
        for object in viewContext.insertedObjects.union(viewContext.updatedObjects) {
            // If object can be mapped to AggregateRoot, pop its events
            if let aggregate = mapToAggregate(object) {
                events.append(contentsOf: aggregate.popDomainEvents())
            }
        }

        return events
    }
}
```

#### BaseRepository
- Generic CRUD 實作
- 使用 CoreData NSFetchRequest

```swift
class BaseRepository<TEntity: Entity>: IRepository {
    typealias TEntity = TEntity

    private let context: AppDbContext

    init(context: AppDbContext) {
        self.context = context
    }

    func getByIdAsync(id: UUID) async throws -> TEntity? {
        // NSFetchRequest implementation
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        return try await context.viewContext.perform {
            let results = try fetchRequest.execute()
            return results.first.map { mapToDomainEntity($0) }
        }
    }

    func addAsync(_ entity: TEntity) async throws {
        // Map domain entity to NSManagedObject
        let managedObject = mapToManagedObject(entity)
        context.viewContext.insert(managedObject)
    }
}
```

#### UnitOfWork
- 管理 transaction
- 觸發 domain events

```swift
protocol IUnitOfWork {
    func saveChangesAsync() async throws
}

class UnitOfWork: IUnitOfWork {
    private let context: AppDbContext

    init(context: AppDbContext) {
        self.context = context
    }

    func saveChangesAsync() async throws {
        try await context.saveChangesAsync()
    }
}
```

---

### 4. Presentation Layer

#### ViewModels
- 使用 @MainActor
- 依賴 Handlers (Command/Query)
- ObservableObject for SwiftUI

```swift
@MainActor
class HabitListViewModel: ObservableObject {
    @Published var habits: [HabitDto] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let getHabitsQueryHandler: any IQueryHandler<GetHabitsQuery, [HabitDto]>
    private let createHabitCommandHandler: any ICommandHandler<CreateHabitCommand, UUID>

    init(
        getHabitsQueryHandler: any IQueryHandler<GetHabitsQuery, [HabitDto]>,
        createHabitCommandHandler: any ICommandHandler<CreateHabitCommand, UUID>
    ) {
        self.getHabitsQueryHandler = getHabitsQueryHandler
        self.createHabitCommandHandler = createHabitCommandHandler
    }

    func loadHabitsAsync() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let query = GetHabitsQuery()
            habits = try await getHabitsQueryHandler.handleAsync(query)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func createHabitAsync(name: String, iconId: String) async {
        let command = CreateHabitCommand(name: name, iconId: iconId)

        do {
            _ = try await createHabitCommandHandler.handleAsync(command)
            await loadHabitsAsync()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
```

---

## 資料流範例

### 完整流程: 建立新習慣

```
1. User Action
   └─> HabitFormView: User submits form

2. ViewModel
   └─> HabitListViewModel.createHabitAsync()
       └─> Create CreateHabitCommand

3. Command Handler
   └─> CreateHabitCommandHandler.handleAsync()
       ├─> Habit.create() (Domain Entity Factory)
       │   └─> Raises HabitCreatedEvent
       ├─> HabitRepository.addAsync()
       └─> UnitOfWork.saveChangesAsync()

4. Infrastructure
   └─> AppDbContext.saveChangesAsync()
       ├─> Collect domain events from Habit aggregate
       ├─> Save to CoreData
       └─> Dispatch HabitCreatedEvent

5. Event Handlers (if any)
   └─> Handle HabitCreatedEvent
       └─> e.g., send analytics, update cache

6. ViewModel Updates
   └─> Reload habits list
       └─> SwiftUI View re-renders
```

---

## 命名慣例

### .NET Style Convention

| 項目 | 命名規則 | 範例 |
|------|---------|------|
| Protocol (Interface) | `I` 前綴 | `IRepository`, `ICommand`, `IUnitOfWork` |
| Entity | PascalCase | `Habit`, `User`, `PomodoroSession` |
| Value Object | PascalCase | `HabitName`, `EmailAddress`, `Duration` |
| Command | `Command` 後綴 | `CreateHabitCommand`, `UpdateHabitCommand` |
| Query | `Query` 後綴 | `GetHabitsQuery`, `GetHabitByIdQuery` |
| Handler | `Handler` 後綴 | `CreateHabitCommandHandler`, `GetHabitsQueryHandler` |
| DTO | `Dto` 後綴 | `HabitDto`, `HabitListItemDto` |
| Async Method | `Async` 後綴 | `getByIdAsync`, `saveChangesAsync`, `handleAsync` |
| Domain Event | `Event` 後綴 | `HabitCreatedEvent`, `HabitUpdatedEvent` |

---

## 依賴注入

### Protocol-Oriented DI

```swift
// Composition Root (e.g., in App or SceneDelegate)
class DependencyContainer {
    let context: AppDbContext
    let unitOfWork: IUnitOfWork

    init() {
        self.context = AppDbContext()
        self.unitOfWork = UnitOfWork(context: context)
    }

    func makeHabitListViewModel() -> HabitListViewModel {
        let habitRepository = HabitRepository(context: context)
        let getHabitsQueryHandler = GetHabitsQueryHandler(repository: habitRepository)
        let createHabitCommandHandler = CreateHabitCommandHandler(
            repository: habitRepository,
            unitOfWork: unitOfWork
        )

        return HabitListViewModel(
            getHabitsQueryHandler: getHabitsQueryHandler,
            createHabitCommandHandler: createHabitCommandHandler
        )
    }
}
```

---

## 測試策略

### Unit Tests
```swift
class CreateHabitCommandHandlerTests: XCTestCase {
    func testHandleAsync_WithValidCommand_ShouldCreateHabit() async throws {
        // Arrange
        let mockRepository = MockHabitRepository()
        let mockUnitOfWork = MockUnitOfWork()
        let handler = CreateHabitCommandHandler(
            repository: mockRepository,
            unitOfWork: mockUnitOfWork
        )
        let command = CreateHabitCommand(name: "Morning Run", iconId: "run")

        // Act
        let habitId = try await handler.handleAsync(command)

        // Assert
        XCTAssertEqual(mockRepository.addedEntities.count, 1)
        XCTAssertTrue(mockUnitOfWork.saveChangesCalled)
    }
}
```

---

## 與 amantinband/clean-architecture 的對應

| Swift (TidalHabits) | .NET (amantinband) |
|---------------------|---------------------|
| Entity.swift | Entity.cs |
| AggregateRoot.swift | AggregateRoot.cs |
| ValueObject<T> | ValueObject |
| IDomainEvent | IDomainEvent : INotification |
| ICommand/IQuery | IAuthorizeableRequest<T> |
| ICommandHandler | IRequestHandler<TRequest, TResponse> |
| AppDbContext | ApplicationDbContext : DbContext |
| DomainEventDispatcher | EventualConsistencyMiddleware |
| Result<T, Error> | ErrorOr<T> |
| BaseRepository<T> | EfRepository<T> |
| UnitOfWork | UnitOfWork pattern in DbContext |

---

## 關鍵差異

### .NET vs Swift

1. **ORM**: Entity Framework Core vs CoreData
2. **DI**: Built-in DI Container vs Manual Protocol-based DI
3. **Mediator**: MediatR vs Custom implementation
4. **Events**: INotification (MediatR) vs Custom dispatching
5. **Async**: Task<T> vs Swift Concurrency (async/await)

---

**參考資源**:
- [amantinband/clean-architecture](https://github.com/amantinband/clean-architecture)
- [amantinband/error-or](https://github.com/amantinband/error-or)
- Swift Result Type: [Swift Evolution SE-0235](https://github.com/apple/swift-evolution/blob/main/proposals/0235-add-result.md)

**最後更新**: 2025-10-29
