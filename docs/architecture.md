# TidalHabits 架構設計文件 (Hybrid Architecture)

## 概述

TidalHabits 採用 **Hybrid 架構模式**，結合 Xcode 標準專案結構與 Clean Architecture + CQRS 設計。此架構設計讓專案能夠：
- ✅ 與 Xcode/Sweetpad 完全相容
- ✅ 採用 Clean Architecture + CQRS 模式
- ✅ 使用 .NET 風格的命名與組織慣例
- ✅ 保持高可維護性、可測試性與可擴展性

## 專案結構

```
TidalHabits/                          # Xcode 標準專案目錄
├── TidalHabitsApp.swift             # App Entry Point
├── ContentView.swift                 # Root View
├── Persistence.swift                 # CoreData Stack
│
├── Core/                             # 核心基礎設施 (Shared Kernel)
│   ├── Domain/
│   │   ├── Common/
│   │   │   ├── Entity.swift         # Base Entity (IEntity)
│   │   │   ├── ValueObject.swift    # Base Value Object
│   │   │   ├── AggregateRoot.swift  # Base Aggregate Root
│   │   │   └── DomainEvent.swift    # IDomainEvent
│   │   ├── Exceptions/
│   │   │   └── DomainException.swift
│   │   └── Interfaces/
│   │       ├── IRepository.swift    # Generic Repository Interface
│   │       └── IUnitOfWork.swift    # Unit of Work Pattern
│   │
│   ├── Application/
│   │   ├── Common/
│   │   │   ├── ICommand.swift       # Command Interface
│   │   │   ├── IQuery.swift         # Query Interface
│   │   │   ├── ICommandHandler.swift
│   │   │   ├── IQueryHandler.swift
│   │   │   └── Result.swift         # Result<T, Error>
│   │   ├── Behaviours/              # Pipeline Behaviours
│   │   │   ├── ValidationBehaviour.swift
│   │   │   └── LoggingBehaviour.swift
│   │   └── Exceptions/
│   │       └── ApplicationException.swift
│   │
│   ├── Infrastructure/
│   │   ├── Persistence/
│   │   │   ├── AppDbContext.swift   # CoreData Context
│   │   │   ├── BaseRepository.swift # Generic Repository Implementation
│   │   │   └── UnitOfWork.swift
│   │   └── Services/
│   │       └── DateTimeService.swift
│   │
│   └── Shared/                       # Cross-cutting concerns
│       ├── Extensions/
│       │   ├── Date+Extensions.swift
│       │   ├── String+Extensions.swift
│       │   └── Collection+Extensions.swift
│       └── Utilities/
│           ├── Logger.swift
│           └── Validator.swift
│
├── Features/                         # 功能模組 (Vertical Slices)
│   │
│   ├── Habits/                      # Habit Feature
│   │   ├── Domain/
│   │   │   ├── Entities/
│   │   │   │   └── Habit.swift
│   │   │   ├── ValueObjects/
│   │   │   │   ├── HabitName.swift
│   │   │   │   └── HabitIcon.swift
│   │   │   ├── Events/
│   │   │   │   └── HabitCreatedEvent.swift
│   │   │   └── Specifications/
│   │   │       └── ActiveHabitSpec.swift
│   │   │
│   │   ├── Application/
│   │   │   ├── Commands/
│   │   │   │   ├── CreateHabit/
│   │   │   │   │   ├── CreateHabitCommand.swift
│   │   │   │   │   ├── CreateHabitCommandHandler.swift
│   │   │   │   │   └── CreateHabitCommandValidator.swift
│   │   │   │   ├── UpdateHabit/
│   │   │   │   │   ├── UpdateHabitCommand.swift
│   │   │   │   │   └── UpdateHabitCommandHandler.swift
│   │   │   │   └── DeleteHabit/
│   │   │   │       ├── DeleteHabitCommand.swift
│   │   │   │       └── DeleteHabitCommandHandler.swift
│   │   │   │
│   │   │   ├── Queries/
│   │   │   │   ├── GetHabits/
│   │   │   │   │   ├── GetHabitsQuery.swift
│   │   │   │   │   └── GetHabitsQueryHandler.swift
│   │   │   │   └── GetHabitById/
│   │   │   │       ├── GetHabitByIdQuery.swift
│   │   │   │       └── GetHabitByIdQueryHandler.swift
│   │   │   │
│   │   │   └── DTOs/
│   │   │       ├── HabitDto.swift
│   │   │       └── HabitListItemDto.swift
│   │   │
│   │   ├── Infrastructure/
│   │   │   ├── Repositories/
│   │   │   │   └── HabitRepository.swift
│   │   │   └── Configurations/
│   │   │       └── HabitConfiguration.swift
│   │   │
│   │   └── Presentation/
│   │       ├── ViewModels/
│   │       │   ├── HabitListViewModel.swift
│   │       │   └── HabitDetailViewModel.swift
│   │       └── Views/
│   │           ├── HabitListView.swift
│   │           ├── HabitDetailView.swift
│   │           └── Components/
│   │               └── HabitCardView.swift
│   │
│   ├── Pomodoro/                    # Pomodoro Feature
│   │   ├── Domain/
│   │   ├── Application/
│   │   ├── Infrastructure/
│   │   └── Presentation/
│   │
│   ├── Statistics/                  # Statistics Feature
│   │   ├── Domain/
│   │   ├── Application/
│   │   ├── Infrastructure/
│   │   └── Presentation/
│   │
│   └── Rewards/                     # Rewards Feature
│       ├── Domain/
│       ├── Application/
│       ├── Infrastructure/
│       └── Presentation/
│
└── Shared/                          # 共用 UI 元件 (不屬於 Core)
    ├── Components/
    │   ├── Buttons/
    │   ├── Cards/
    │   └── Inputs/
    ├── Styles/
    │   └── AppTheme.swift
    └── Localization/
        └── Localizable.strings
```

## Clean Architecture 分層說明

### 1. Core Layer - 核心基礎設施

Core 層提供整個應用程式的基礎建構，不依賴任何 Feature。

#### Core/Domain
- **責任**: 定義 DDD 基礎抽象與介面
- **包含**:
  - `IEntity` - Entity 基礎協定
  - `ValueObject` - Value Object 基礎類別
  - `AggregateRoot` - Aggregate Root 基礎類別
  - `IDomainEvent` - 領域事件介面
  - `IRepository<T>` - Repository 泛型介面
  - `IUnitOfWork` - Unit of Work 介面

#### Core/Application
- **責任**: 定義 CQRS 模式基礎介面
- **包含**:
  - `ICommand` / `ICommandHandler` - Command 模式
  - `IQuery` / `IQueryHandler` - Query 模式
  - `Result<T, Error>` - Result 型別
  - Pipeline Behaviours (Validation, Logging)

#### Core/Infrastructure
- **責任**: 提供技術基礎設施實作
- **包含**:
  - `AppDbContext` - CoreData Context 封裝
  - `BaseRepository<T>` - Repository 泛型實作
  - `UnitOfWork` - Unit of Work 實作
  - 共用服務 (DateTimeService, etc.)

#### Core/Shared
- **責任**: Cross-cutting concerns
- **包含**: Extensions, Utilities, Logger

---

### 2. Features Layer - 功能模組 (Vertical Slices)

每個 Feature 是一個獨立的垂直切片，包含完整的四層架構。

#### Feature/Domain
- **責任**: Feature 的核心業務邏輯與規則
- **包含**:
  - **Entities**: 實體 (如 `Habit.swift`)
  - **ValueObjects**: 值物件 (如 `HabitName.swift`)
  - **Events**: 領域事件 (如 `HabitCreatedEvent.swift`)
  - **Specifications**: 領域規格模式

範例:
```swift
// Features/Habits/Domain/Entities/Habit.swift
class Habit: AggregateRoot {
    private(set) var name: HabitName
    private(set) var iconId: HabitIcon

    static func create(name: String, iconId: String) throws -> Habit {
        // Domain logic
    }
}
```

#### Feature/Application
- **責任**: 應用程式業務流程、CQRS 實作
- **組織方式**: Vertical Slices (每個 Command/Query 一個資料夾)
- **包含**:
  - **Commands/**: 寫入操作 (CreateHabit/, UpdateHabit/)
  - **Queries/**: 讀取操作 (GetHabits/, GetHabitById/)
  - **DTOs/**: 資料傳輸物件

範例:
```swift
// Features/Habits/Application/Commands/CreateHabit/CreateHabitCommand.swift
struct CreateHabitCommand: ICommand {
    typealias TResult = UUID
    let name: String
    let iconId: String
}

// Features/Habits/Application/Commands/CreateHabit/CreateHabitCommandHandler.swift
class CreateHabitCommandHandler: ICommandHandler {
    func handleAsync(_ command: CreateHabitCommand) async throws -> UUID {
        // Implementation
    }
}
```

#### Feature/Infrastructure
- **責任**: Feature 的技術實作細節
- **包含**:
  - **Repositories/**: Repository 實作
  - **Configurations/**: CoreData Entity 設定

範例:
```swift
// Features/Habits/Infrastructure/Repositories/HabitRepository.swift
class HabitRepository: BaseRepository<Habit>, IHabitRepository {
    // Feature-specific repository methods
}
```

#### Feature/Presentation
- **責任**: 使用者介面與互動
- **包含**:
  - **ViewModels/**: MVVM ViewModels
  - **Views/**: SwiftUI Views
  - **Components/**: View 專用元件

範例:
```swift
// Features/Habits/Presentation/ViewModels/HabitListViewModel.swift
@MainActor
class HabitListViewModel: ObservableObject {
    @Published var habits: [HabitDto] = []

    private let getHabitsQueryHandler: any IQueryHandler

    func loadHabitsAsync() async {
        // Load habits via Query
    }
}
```

---

### 3. Shared Layer - 共用 UI 元件

Shared 層提供可重用的 UI 元件，不包含業務邏輯。

- **Components/**: 共用 UI 元件 (Button, Card, Input)
- **Styles/**: 主題與樣式
- **Localization/**: 多語系資源

---

## CQRS 模式

### Command (寫入操作)

Commands 負責改變系統狀態，遵循 Command Pattern。

```swift
// 1. 定義 Command
struct CreateHabitCommand: ICommand {
    typealias TResult = UUID

    let name: String
    let iconId: String
    let defaultDuration: TimeInterval
    let starsReward: Int
}

// 2. 實作 CommandHandler
class CreateHabitCommandHandler: ICommandHandler {
    typealias TCommand = CreateHabitCommand
    typealias TResult = UUID

    private let repository: IHabitRepository
    private let unitOfWork: IUnitOfWork

    func handleAsync(_ command: TCommand) async throws -> TResult {
        // 1. Create Domain Entity
        let habit = try Habit.create(
            name: command.name,
            iconId: command.iconId,
            defaultDuration: command.defaultDuration,
            starsReward: command.starsReward
        )

        // 2. Save via Repository
        try await repository.addAsync(habit)

        // 3. Commit changes
        try await unitOfWork.saveChangesAsync()

        return habit.id
    }
}

// 3. 在 ViewModel 中使用
class HabitListViewModel {
    func createHabitAsync(name: String) async {
        let command = CreateHabitCommand(
            name: name,
            iconId: "default",
            defaultDuration: 1500,
            starsReward: 1
        )

        let habitId = try await commandHandler.handleAsync(command)
    }
}
```

### Query (讀取操作)

Queries 負責讀取資料，不改變系統狀態。

```swift
// 1. 定義 Query
struct GetHabitsQuery: IQuery {
    typealias TResult = [HabitDto]

    let userId: UUID?
    let isActive: Bool?
}

// 2. 實作 QueryHandler
class GetHabitsQueryHandler: IQueryHandler {
    typealias TQuery = GetHabitsQuery
    typealias TResult = [HabitDto]

    private let repository: IHabitRepository

    func handleAsync(_ query: TQuery) async throws -> [HabitDto] {
        let habits = try await repository.getAllAsync()

        // Filter by query parameters
        var filtered = habits
        if let isActive = query.isActive {
            filtered = filtered.filter { $0.isActive == isActive }
        }

        // Map to DTOs
        return filtered.map { HabitDto(from: $0) }
    }
}

// 3. 在 ViewModel 中使用
class HabitListViewModel {
    func loadHabitsAsync() async {
        let query = GetHabitsQuery(userId: nil, isActive: true)
        habits = try await queryHandler.handleAsync(query)
    }
}
```

---

## 依賴方向規則

```
Presentation (Views/ViewModels)
       ↓
Application (Commands/Queries/Handlers)
       ↓
Domain (Entities/ValueObjects/Interfaces) ← Infrastructure (Repositories/DataSources)
       ↑
     Core (共用基礎設施)
```

### 依賴原則

1. **Core** 不依賴任何 Feature
2. **Domain** 完全獨立，不依賴任何其他層
3. **Application** 只依賴 Domain 和 Core
4. **Infrastructure** 依賴 Domain (實作 Repository 介面)
5. **Presentation** 依賴 Application 和 Domain
6. **Shared** 僅用於 UI 元件，不包含業務邏輯

---

## 命名慣例 (.NET Style)

### Protocol (Interface) 命名

使用 `I` 前綴，遵循 .NET Interface 命名慣例。

```swift
protocol IEntity {
    var id: UUID { get }
}

protocol IRepository {
    associatedtype TEntity: IEntity
    func getByIdAsync(id: UUID) async throws -> TEntity?
}

protocol ICommand {
    associatedtype TResult
}

protocol ICommandHandler {
    associatedtype TCommand: ICommand
    func handleAsync(_ command: TCommand) async throws -> TCommand.TResult
}
```

### Class/Struct 命名

- **Entity**: `Habit`, `User`, `PomodoroSession`
- **Value Object**: `HabitName`, `HabitIcon`, `EmailAddress`
- **Command**: `CreateHabitCommand`, `UpdateHabitCommand`
- **Query**: `GetHabitsQuery`, `GetHabitByIdQuery`
- **Handler**: `CreateHabitCommandHandler`, `GetHabitsQueryHandler`
- **Repository**: `HabitRepository`, `UserRepository`
- **DTO**: `HabitDto`, `HabitListItemDto`
- **ViewModel**: `HabitListViewModel`, `HabitDetailViewModel`
- **View**: `HabitListView`, `HabitDetailView`

### Method 命名

使用 `Async` 後綴表示非同步方法（類似 .NET `Task<T>`）。

```swift
// Repository methods
func getByIdAsync(id: UUID) async throws -> Habit?
func getAllAsync() async throws -> [Habit]
func addAsync(_ entity: Habit) async throws
func updateAsync(_ entity: Habit) async throws
func deleteAsync(_ entity: Habit) async throws

// Handler methods
func handleAsync(_ command: CreateHabitCommand) async throws -> UUID
func handleAsync(_ query: GetHabitsQuery) async throws -> [HabitDto]
```

---

## Repository Pattern

### Generic Repository Interface

```swift
// Core/Domain/Interfaces/IRepository.swift
protocol IRepository {
    associatedtype TEntity: IEntity

    func getByIdAsync(id: UUID) async throws -> TEntity?
    func getAllAsync() async throws -> [TEntity]
    func addAsync(_ entity: TEntity) async throws
    func updateAsync(_ entity: TEntity) async throws
    func deleteAsync(_ entity: TEntity) async throws
}
```

### Base Repository Implementation

```swift
// Core/Infrastructure/Persistence/BaseRepository.swift
class BaseRepository<TEntity: IEntity>: IRepository {
    private let context: AppDbContext

    init(context: AppDbContext) {
        self.context = context
    }

    func getByIdAsync(id: UUID) async throws -> TEntity? {
        // Generic CoreData fetch implementation
    }

    func getAllAsync() async throws -> [TEntity] {
        // Generic CoreData fetch all implementation
    }

    // ... other methods
}
```

### Feature-Specific Repository

```swift
// Features/Habits/Domain/Repositories/IHabitRepository.swift
protocol IHabitRepository: IRepository where TEntity == Habit {
    func getActiveHabitsAsync() async throws -> [Habit]
    func getHabitsByUserAsync(userId: UUID) async throws -> [Habit]
}

// Features/Habits/Infrastructure/Repositories/HabitRepository.swift
class HabitRepository: BaseRepository<Habit>, IHabitRepository {
    func getActiveHabitsAsync() async throws -> [Habit] {
        // Feature-specific query
    }
}
```

---

## Unit of Work Pattern

```swift
// Core/Domain/Interfaces/IUnitOfWork.swift
protocol IUnitOfWork {
    func saveChangesAsync() async throws
    func rollback()
}

// Core/Infrastructure/Persistence/UnitOfWork.swift
class UnitOfWork: IUnitOfWork {
    private let context: AppDbContext

    func saveChangesAsync() async throws {
        try await context.save()
    }

    func rollback() {
        context.rollback()
    }
}
```

---

## Result Pattern

使用 `Result<T, Error>` 處理成功/失敗情況。

```swift
// Core/Application/Common/Result.swift
enum Result<TValue, TError: Error> {
    case success(TValue)
    case failure(TError)

    var isSuccess: Bool {
        if case .success = self { return true }
        return false
    }

    var isFailure: Bool {
        !isSuccess
    }

    var value: TValue? {
        if case .success(let value) = self { return value }
        return nil
    }

    var error: TError? {
        if case .failure(let error) = self { return error }
        return nil
    }
}

// Usage
func createHabitAsync(command: CreateHabitCommand) async -> Result<UUID, Error> {
    do {
        let habitId = try await handler.handleAsync(command)
        return .success(habitId)
    } catch {
        return .failure(error)
    }
}
```

---

## 依賴注入 (Dependency Injection)

### Protocol-Oriented DI

使用 Swift Protocol 和 Constructor Injection。

```swift
// ViewModel 範例
class HabitListViewModel: ObservableObject {
    private let getHabitsQueryHandler: any IQueryHandler<GetHabitsQuery, [HabitDto]>
    private let createHabitCommandHandler: any ICommandHandler<CreateHabitCommand, UUID>

    init(
        getHabitsQueryHandler: any IQueryHandler<GetHabitsQuery, [HabitDto]>,
        createHabitCommandHandler: any ICommandHandler<CreateHabitCommand, UUID>
    ) {
        self.getHabitsQueryHandler = getHabitsQueryHandler
        self.createHabitCommandHandler = createHabitCommandHandler
    }
}
```

### SwiftUI Environment Objects (可選)

```swift
// 在 App 層級注入
@main
struct TidalHabitsApp: App {
    let context = AppDbContext()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, context.container.viewContext)
        }
    }
}
```

---

## 資料流範例

### 完整流程: 建立新習慣

```
1. User taps "Create Habit" button
   ↓
2. HabitFormView captures input
   ↓
3. HabitListViewModel.createHabitAsync()
   ↓
4. Create CreateHabitCommand
   ↓
5. CreateHabitCommandHandler.handleAsync()
   ↓
6. Habit.create() (Domain Entity Factory)
   ↓
7. Validate business rules
   ↓
8. HabitRepository.addAsync()
   ↓
9. UnitOfWork.saveChangesAsync()
   ↓
10. CoreData persists data
   ↓
11. Domain Event: HabitCreatedEvent
   ↓
12. ViewModel updates @Published properties
   ↓
13. SwiftUI View re-renders
```

---

## 測試策略

### 單元測試 (Unit Tests)

- **Domain Layer**: 測試業務邏輯、Entity 行為
- **Application Layer**: 測試 Command/Query Handlers
- **ViewModel**: 測試 Presentation 邏輯

```swift
// test/Unit/Domain/Entities/HabitTests.swift
class HabitTests: XCTestCase {
    func testCreateHabit_WithValidData_ShouldSucceed() throws {
        // Arrange
        let name = "Morning Run"

        // Act
        let habit = try Habit.create(name: name, iconId: "run", defaultDuration: 1800, starsReward: 2)

        // Assert
        XCTAssertEqual(habit.name.value, name)
        XCTAssertTrue(habit.isActive)
    }
}
```

### 整合測試 (Integration Tests)

- **Repository**: 測試 CoreData 整合
- **End-to-End**: 測試完整 Command/Query 流程

```swift
// test/Integration/Repositories/HabitRepositoryTests.swift
class HabitRepositoryTests: XCTestCase {
    func testAddAsync_ShouldPersistHabit() async throws {
        // Arrange
        let context = AppDbContext(inMemory: true)
        let repository = HabitRepository(context: context)
        let habit = try Habit.create(name: "Test", iconId: "test", defaultDuration: 1500, starsReward: 1)

        // Act
        try await repository.addAsync(habit)

        // Assert
        let retrieved = try await repository.getByIdAsync(id: habit.id)
        XCTAssertNotNil(retrieved)
    }
}
```

### UI 測試 (UI Tests)

- 測試使用者流程與互動

---

## 與 .NET Clean Architecture 對應

| iOS/Swift | .NET |
|-----------|------|
| `Core/Domain/Common/Entity.swift` | `Domain/Common/BaseEntity.cs` |
| `Core/Application/Common/ICommand.swift` | `Application/Common/Interfaces/ICommand.cs` |
| `Core/Infrastructure/Persistence/AppDbContext.swift` | `Infrastructure/Persistence/ApplicationDbContext.cs` |
| `Features/Habits/Application/Commands/CreateHabit/` | `Features/Habits/Commands/CreateHabit/` |
| `Features/Habits/Application/Queries/GetHabits/` | `Features/Habits/Queries/GetHabits/` |
| `Features/Habits/Domain/Entities/Habit.swift` | `Domain/Entities/Habit.cs` |
| `Features/Habits/Infrastructure/Repositories/` | `Infrastructure/Repositories/` |
| `Features/Habits/Presentation/ViewModels/` | `WebUI/ViewModels/` or `Controllers/` |

### 主要差異

1. **UI Framework**:
   - .NET: ASP.NET Core MVC/Razor/Blazor
   - iOS: SwiftUI

2. **ORM**:
   - .NET: Entity Framework Core
   - iOS: CoreData

3. **DI Container**:
   - .NET: Built-in Microsoft.Extensions.DependencyInjection
   - iOS: Manual DI (Protocol + Constructor Injection)

4. **非同步模式**:
   - .NET: `async/await` with `Task<T>`
   - iOS: `async/await` with Swift Concurrency

---

## 優點總結

### 架構優勢

✅ **關注點分離**: Clean Architecture 四層分離
✅ **高可測試性**: Protocol-oriented + DI
✅ **高可維護性**: Feature-based 模組化
✅ **技術獨立**: 易於替換 Infrastructure 層實作
✅ **團隊協作**: 不同 Feature 可平行開發

### .NET Developer 友好

✅ **熟悉的命名**: ICommand, IQuery, Handler, Dto
✅ **熟悉的模式**: CQRS, Repository, Unit of Work
✅ **熟悉的組織**: Vertical Slices
✅ **熟悉的流程**: Command → Handler → Repository → UnitOfWork

### Xcode/Sweetpad 相容

✅ **標準專案結構**: 所有檔案在 `TidalHabits/` 下
✅ **原生建置系統**: 使用 Xcode 標準建置
✅ **測試整合**: 支援 XCTest
✅ **開發工具**: 完全相容 Sweetpad

---

## 實作步驟建議

### Phase 1: Core 基礎建設
1. ✅ 建立資料夾結構
2. 實作 `Core/Domain/Common/` (Entity, ValueObject, AggregateRoot)
3. 實作 `Core/Application/Common/` (ICommand, IQuery, Handlers)
4. 實作 `Core/Infrastructure/Persistence/` (AppDbContext, BaseRepository)

### Phase 2: 第一個 Feature (Habits)
5. 實作 Habit Domain (Entity, ValueObjects, Events)
6. 實作 Habit Application (Commands, Queries, Handlers, DTOs)
7. 實作 Habit Infrastructure (Repository, Configurations)
8. 實作 Habit Presentation (Views, ViewModels)
9. 撰寫測試 (Unit, Integration, UI)

### Phase 3: 其他 Features
10. 依照相同模式實作 Pomodoro Feature
11. 實作 Statistics Feature
12. 實作 Rewards Feature

---

## 參考資源

- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [CQRS Pattern by Martin Fowler](https://martinfowler.com/bliki/CQRS.html)
- [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [CoreData Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreData/)

---

**TidalHabits Hybrid Architecture - 結合 Xcode 標準與 Clean Architecture 的最佳實踐** 🏗️

_Updated: 2025-10-29_
