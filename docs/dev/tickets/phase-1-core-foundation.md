# Phase 1: Core Foundation - 核心基礎建設 (Updated)

基於 amantinband/clean-architecture 的設計，建立完整的 Swift Clean Architecture 基礎設施。

**參考**: [amantinband/clean-architecture](https://github.com/amantinband/clean-architecture)

**目標**: 完成 Core 層的所有基礎建構，為 Feature 開發做準備。

**預估時間**: 3-4 天

---

## ✅ Stage 1.1: Domain 基礎 (已完成)

### Checklist

- [x] Entity (TidalHabits/Core/Domain/Common/Entity.swift)
  - Base class for all entities
  - Equality based on ID
- [x] ValueObject (TidalHabits/Core/Domain/Common/ValueObject.swift)
  - Generic base class for value objects
  - Immutable with validation support
- [x] DomainException (TidalHabits/Core/Domain/Exceptions/DomainException.swift)
  - Domain layer exception types
- [x] IDomainEvent (TidalHabits/Core/Domain/Common/IDomainEvent.swift)
  - Marker protocol for domain events
  - Similar to .NET's IDomainEvent: INotification
- [x] AggregateRoot (TidalHabits/Core/Domain/Common/AggregateRoot.swift)
  - Inherits from Entity
  - Manages domain events
  - Provides raiseDomainEvent() and clearDomainEvents()

---

## ✅ Stage 1.2: Domain 介面層 (已完成)

### Checklist

- [x] IRepository (TidalHabits/Core/Domain/Interfaces/IRepository.swift)
  - Generic repository interface
  - CRUD operations with async/await
- [x] IUnitOfWork (TidalHabits/Core/Domain/Interfaces/IUnitOfWork.swift)
  - Transaction management interface

---

## ✅ Stage 1.3: Application CQRS 基礎 (已完成)

### Checklist

- [x] ICommand (TidalHabits/Core/Application/Common/ICommand.swift)
  - Marker protocol for commands
- [x] ICommandHandler (TidalHabits/Core/Application/Common/ICommandHandler.swift)
  - Handler protocol for commands
- [x] IQuery (TidalHabits/Core/Application/Common/IQuery.swift)
  - Marker protocol for queries
- [x] IQueryHandler (TidalHabits/Core/Application/Common/IQueryHandler.swift)
  - Handler protocol for queries
- [x] Result (TidalHabits/Core/Application/Common/Result.swift)
  - Result<TValue, TError> enum
  - Similar to Swift's built-in Result but customized
- [x] ApplicationException (TidalHabits/Core/Application/Common/ApplicationException.swift)
  - Application layer exceptions

---

## Stage 1.4: Infrastructure 持久化層

基於 amantinband 的 AppDbContext 設計，實作 CoreData 封裝。

### Checklist

#### CoreData Context
- [ ] AppDbContext (TidalHabits/Core/Infrastructure/Persistence/AppDbContext.swift)
  - 封裝 CoreData PersistentContainer
  - 依賴: Persistence.swift (現有的 CoreData stack)
  - 提供 viewContext 和 backgroundContext
  - **重點**: 在 saveAsync 時處理 Domain Events
  - 實作 popDomainEvents() 機制

#### Repository 實作
- [ ] BaseRepository (TidalHabits/Core/Infrastructure/Persistence/BaseRepository.swift)
  - 依賴: IRepository, AppDbContext, Entity
  - Generic CRUD 實作
  - 使用 NSFetchRequest 和 NSManagedObject

#### Unit of Work 實作
- [ ] UnitOfWork (TidalHabits/Core/Infrastructure/Persistence/UnitOfWork.swift)
  - 依賴: IUnitOfWork, AppDbContext
  - saveChangesAsync() 實作
  - **重點**: 觸發 Domain Events 處理

#### Domain Event 處理
- [ ] DomainEventDispatcher (TidalHabits/Core/Infrastructure/Events/DomainEventDispatcher.swift)
  - 收集並分發 Domain Events
  - 類似 amantinband 的 EventualConsistencyMiddleware
  - 在 saveChangesAsync 後觸發

---

## Stage 1.5: Application Behaviors (Optional but Recommended)

參考 amantinband 的 Behaviors pattern，實作 pipeline behaviors。

### Checklist

#### Pipeline Behavior Protocol
- [ ] IPipelineBehavior (TidalHabits/Core/Application/Behaviors/IPipelineBehavior.swift)
  - 類似 MediatR's IPipelineBehavior
  - 提供 handleAsync 方法

#### Validation Behavior
- [ ] ValidationBehavior (TidalHabits/Core/Application/Behaviors/ValidationBehavior.swift)
  - 自動執行 Command/Query 驗證
  - 在 Handler 執行前驗證

#### Logging Behavior (Optional)
- [ ] LoggingBehavior (TidalHabits/Core/Application/Behaviors/LoggingBehavior.swift)
  - 記錄 Command/Query 執行
  - 效能監控

---

## Stage 1.6: Shared 工具類別

### Checklist

#### Extensions
- [ ] Date+Extensions (TidalHabits/Core/Shared/Extensions/Date+Extensions.swift)
  - startOfDay, endOfDay, etc.
- [ ] String+Extensions (TidalHabits/Core/Shared/Extensions/String+Extensions.swift)
  - isValidEmail, trim, etc.
- [ ] Collection+Extensions (TidalHabits/Core/Shared/Extensions/Collection+Extensions.swift)
  - safe subscript, etc.
- [ ] UUID+Extensions (TidalHabits/Core/Shared/Extensions/UUID+Extensions.swift)
  - Utility methods

#### Utilities
- [ ] Logger (TidalHabits/Core/Shared/Utilities/Logger.swift)
  - Centralized logging
  - OSLog wrapper
- [ ] Validator (TidalHabits/Core/Shared/Utilities/Validator.swift)
  - Common validation rules
  - Email, length, range validation

---

## Stage 1.7: 單元測試

### Checklist

#### Domain Tests
- [ ] EntityTests (TidalHabitsTests/Unit/Core/Domain/EntityTests.swift)
  - Test Entity equality
- [ ] ValueObjectTests (TidalHabitsTests/Unit/Core/Domain/ValueObjectTests.swift)
  - Test ValueObject validation and equality
- [ ] AggregateRootTests (TidalHabitsTests/Unit/Core/Domain/AggregateRootTests.swift)
  - Test domain event raising and clearing
  - Test popDomainEvents

#### Application Tests
- [ ] ResultTests (TidalHabitsTests/Unit/Core/Application/ResultTests.swift)
  - Test Result<T, Error> pattern

#### Infrastructure Tests
- [ ] AppDbContextTests (TidalHabitsTests/Integration/Core/Infrastructure/AppDbContextTests.swift)
  - Test CoreData operations
  - Test domain event collection
- [ ] BaseRepositoryTests (TidalHabitsTests/Integration/Core/Infrastructure/BaseRepositoryTests.swift)
  - Test CRUD operations
- [ ] UnitOfWorkTests (TidalHabitsTests/Integration/Core/Infrastructure/UnitOfWorkTests.swift)
  - Test transaction management
  - Test domain event dispatching

#### Behavior Tests (if implemented)
- [ ] ValidationBehaviorTests (TidalHabitsTests/Unit/Core/Application/ValidationBehaviorTests.swift)

---

## 關鍵設計決策 (Based on amantinband)

### 1. Entity & AggregateRoot
```swift
// Entity is a base class (not protocol)
class Entity: Equatable {
    let id: UUID
}

// AggregateRoot manages domain events
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

### 2. Domain Events
```swift
// IDomainEvent is a marker protocol
protocol IDomainEvent {
    var occurredOn: Date { get }
}

// Concrete event example
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
```

### 3. AppDbContext with Event Handling
```swift
class AppDbContext {
    private let container: NSPersistentContainer

    func saveChangesAsync() async throws {
        // 1. Collect domain events from tracked entities
        let events = collectDomainEvents()

        // 2. Save to CoreData
        try await context.perform {
            try context.save()
        }

        // 3. Dispatch domain events
        await dispatchDomainEvents(events)
    }

    private func collectDomainEvents() -> [IDomainEvent] {
        // Iterate through changed objects
        // If object is AggregateRoot, pop its domain events
    }
}
```

### 4. CQRS with Result Type
```swift
// Command returns Result
struct CreateHabitCommand: ICommand {
    typealias TResult = Result<UUID, Error>
    let name: String
}

// Handler
class CreateHabitCommandHandler: ICommandHandler {
    func handleAsync(_ command: CreateHabitCommand) async throws -> UUID {
        // Can throw or return Result<UUID, Error>
    }
}
```

---

## 完成標準

- [ ] 所有 Core 層檔案已建立
- [ ] 所有檔案編譯無錯誤
- [ ] Domain Events 機制正常運作
- [ ] Unit of Work 正確觸發 Domain Events
- [ ] 單元測試覆蓋率 ≥ 80%
- [ ] 所有測試通過
- [ ] SwiftLint 檢查通過
- [ ] 程式碼已 Code Review
- [ ] 文件已更新

---

## 依賴關係圖

```
Stage 1.1 (Domain 基礎) ✅
├── Entity
├── ValueObject
├── DomainException
├── IDomainEvent
└── AggregateRoot (依賴 Entity)

Stage 1.2 (Domain 介面) ✅
├── IRepository (依賴 Entity)
└── IUnitOfWork

Stage 1.3 (Application CQRS) ✅
├── ICommand
├── ICommandHandler (依賴 ICommand)
├── IQuery
├── IQueryHandler (依賴 IQuery)
├── Result
└── ApplicationException

Stage 1.4 (Infrastructure) ⏳
├── AppDbContext
├── BaseRepository (依賴 IRepository, AppDbContext, Entity)
├── UnitOfWork (依賴 IUnitOfWork, AppDbContext)
└── DomainEventDispatcher

Stage 1.5 (Behaviors) ⏳
├── IPipelineBehavior
├── ValidationBehavior
└── LoggingBehavior (optional)

Stage 1.6 (Shared) ⏳
├── Extensions (獨立)
└── Utilities (獨立)

Stage 1.7 (Tests) ⏳
└── 所有測試 (依賴前面的實作)
```

---

## 與 amantinband/clean-architecture 的對應

| Swift (TidalHabits) | .NET (amantinband) |
|---------------------|---------------------|
| Entity.swift | Entity.cs |
| AggregateRoot.swift | AggregateRoot.cs |
| ValueObject.swift | ValueObject.cs |
| IDomainEvent | IDomainEvent: INotification |
| ICommand/IQuery | IAuthorizeableRequest<T> |
| ICommandHandler/IQueryHandler | IRequestHandler<TRequest, TResponse> |
| AppDbContext | ApplicationDbContext: DbContext |
| DomainEventDispatcher | EventualConsistencyMiddleware |
| Result<T, Error> | ErrorOr<T> |

---

## 下一步

完成 Phase 1 後，進入 **Phase 2: Habits Feature** 實作第一個功能模組。

Phase 2 將展示如何使用 Phase 1 建立的基礎設施來實作完整的 Feature。
