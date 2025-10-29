# Phase 2: Habits Feature - 習慣管理功能

實作第一個完整的 Feature，包含 Domain、Application、Infrastructure 和 Presentation 四層。

**目標**: 完成習慣管理的核心功能，建立 Feature 開發的標準模式。

**預估時間**: 4-5 天

**前置條件**: Phase 1 已完成

---

## Stage 2.1: Habits Domain Layer

建立習慣管理的領域模型。

### Checklist

#### Value Objects
- [ ] HabitName (TidalHabits/Features/Habits/Domain/ValueObjects/HabitName.swift)
  - 依賴: Core/Domain/Common/ValueObject
- [ ] HabitIcon (TidalHabits/Features/Habits/Domain/ValueObjects/HabitIcon.swift)
  - 依賴: Core/Domain/Common/ValueObject
- [ ] HabitDuration (TidalHabits/Features/Habits/Domain/ValueObjects/HabitDuration.swift)
  - 依賴: Core/Domain/Common/ValueObject
- [ ] StarsReward (TidalHabits/Features/Habits/Domain/ValueObjects/StarsReward.swift)
  - 依賴: Core/Domain/Common/ValueObject

#### Domain Events
- [ ] HabitCreatedEvent (TidalHabits/Features/Habits/Domain/Events/HabitCreatedEvent.swift)
  - 依賴: Core/Domain/Common/IDomainEvent
- [ ] HabitUpdatedEvent (TidalHabits/Features/Habits/Domain/Events/HabitUpdatedEvent.swift)
  - 依賴: Core/Domain/Common/IDomainEvent
- [ ] HabitDeletedEvent (TidalHabits/Features/Habits/Domain/Events/HabitDeletedEvent.swift)
  - 依賴: Core/Domain/Common/IDomainEvent
- [ ] HabitDeactivatedEvent (TidalHabits/Features/Habits/Domain/Events/HabitDeactivatedEvent.swift)
  - 依賴: Core/Domain/Common/IDomainEvent

#### Entities
- [ ] Habit (TidalHabits/Features/Habits/Domain/Entities/Habit.swift)
  - 依賴: Core/Domain/Common/AggregateRoot
  - 依賴: HabitName, HabitIcon, HabitDuration, StarsReward
  - 依賴: HabitCreatedEvent, HabitUpdatedEvent, etc.

#### Repository Interface
- [ ] IHabitRepository (TidalHabits/Features/Habits/Domain/Repositories/IHabitRepository.swift)
  - 依賴: Core/Domain/Interfaces/IRepository
  - 依賴: Habit

#### Specifications (Optional)
- [ ] ActiveHabitSpec (TidalHabits/Features/Habits/Domain/Specifications/ActiveHabitSpec.swift)
  - 依賴: Habit

---

## Stage 2.2: Habits Application Layer - Commands

實作寫入操作的 Commands 和 Handlers。

### Checklist

#### Create Habit
- [ ] CreateHabitCommand (TidalHabits/Features/Habits/Application/Commands/CreateHabit/CreateHabitCommand.swift)
  - 依賴: Core/Application/Common/ICommand
- [ ] CreateHabitCommandValidator (TidalHabits/Features/Habits/Application/Commands/CreateHabit/CreateHabitCommandValidator.swift)
  - 依賴: CreateHabitCommand
- [ ] CreateHabitCommandHandler (TidalHabits/Features/Habits/Application/Commands/CreateHabit/CreateHabitCommandHandler.swift)
  - 依賴: Core/Application/Common/ICommandHandler
  - 依賴: CreateHabitCommand, IHabitRepository, IUnitOfWork
  - 依賴: Habit (Domain Entity)

#### Update Habit
- [ ] UpdateHabitCommand (TidalHabits/Features/Habits/Application/Commands/UpdateHabit/UpdateHabitCommand.swift)
  - 依賴: Core/Application/Common/ICommand
- [ ] UpdateHabitCommandValidator (TidalHabits/Features/Habits/Application/Commands/UpdateHabit/UpdateHabitCommandValidator.swift)
  - 依賴: UpdateHabitCommand
- [ ] UpdateHabitCommandHandler (TidalHabits/Features/Habits/Application/Commands/UpdateHabit/UpdateHabitCommandHandler.swift)
  - 依賴: Core/Application/Common/ICommandHandler
  - 依賴: UpdateHabitCommand, IHabitRepository, IUnitOfWork

#### Delete Habit
- [ ] DeleteHabitCommand (TidalHabits/Features/Habits/Application/Commands/DeleteHabit/DeleteHabitCommand.swift)
  - 依賴: Core/Application/Common/ICommand
- [ ] DeleteHabitCommandHandler (TidalHabits/Features/Habits/Application/Commands/DeleteHabit/DeleteHabitCommandHandler.swift)
  - 依賴: Core/Application/Common/ICommandHandler
  - 依賴: DeleteHabitCommand, IHabitRepository, IUnitOfWork

#### Toggle Habit Active Status
- [ ] ToggleHabitActiveCommand (TidalHabits/Features/Habits/Application/Commands/ToggleHabitActive/ToggleHabitActiveCommand.swift)
  - 依賴: Core/Application/Common/ICommand
- [ ] ToggleHabitActiveCommandHandler (TidalHabits/Features/Habits/Application/Commands/ToggleHabitActive/ToggleHabitActiveCommandHandler.swift)
  - 依賴: Core/Application/Common/ICommandHandler
  - 依賴: ToggleHabitActiveCommand, IHabitRepository, IUnitOfWork

---

## Stage 2.3: Habits Application Layer - Queries

實作讀取操作的 Queries 和 Handlers。

### Checklist

#### DTOs
- [ ] HabitDto (TidalHabits/Features/Habits/Application/DTOs/HabitDto.swift)
- [ ] HabitListItemDto (TidalHabits/Features/Habits/Application/DTOs/HabitListItemDto.swift)
- [ ] HabitDetailDto (TidalHabits/Features/Habits/Application/DTOs/HabitDetailDto.swift)

#### Get All Habits
- [ ] GetHabitsQuery (TidalHabits/Features/Habits/Application/Queries/GetHabits/GetHabitsQuery.swift)
  - 依賴: Core/Application/Common/IQuery
- [ ] GetHabitsQueryHandler (TidalHabits/Features/Habits/Application/Queries/GetHabits/GetHabitsQueryHandler.swift)
  - 依賴: Core/Application/Common/IQueryHandler
  - 依賴: GetHabitsQuery, IHabitRepository
  - 依賴: HabitListItemDto

#### Get Habit By Id
- [ ] GetHabitByIdQuery (TidalHabits/Features/Habits/Application/Queries/GetHabitById/GetHabitByIdQuery.swift)
  - 依賴: Core/Application/Common/IQuery
- [ ] GetHabitByIdQueryHandler (TidalHabits/Features/Habits/Application/Queries/GetHabitById/GetHabitByIdQueryHandler.swift)
  - 依賴: Core/Application/Common/IQueryHandler
  - 依賴: GetHabitByIdQuery, IHabitRepository
  - 依賴: HabitDetailDto

#### Get Active Habits
- [ ] GetActiveHabitsQuery (TidalHabits/Features/Habits/Application/Queries/GetActiveHabits/GetActiveHabitsQuery.swift)
  - 依賴: Core/Application/Common/IQuery
- [ ] GetActiveHabitsQueryHandler (TidalHabits/Features/Habits/Application/Queries/GetActiveHabits/GetActiveHabitsQueryHandler.swift)
  - 依賴: Core/Application/Common/IQueryHandler
  - 依賴: GetActiveHabitsQuery, IHabitRepository
  - 依賴: HabitListItemDto

---

## Stage 2.4: Habits Infrastructure Layer

實作 Repository 和 CoreData 配置。

### Checklist

#### CoreData Configuration
- [ ] HabitEntity.xcdatamodel (TidalHabits/TidalHabits.xcdatamodeld/HabitEntity.xcdatamodel)
  - CoreData Entity 定義
- [ ] HabitConfiguration (TidalHabits/Features/Habits/Infrastructure/Configurations/HabitConfiguration.swift)
  - 依賴: HabitEntity

#### Repository Implementation
- [ ] HabitRepository (TidalHabits/Features/Habits/Infrastructure/Repositories/HabitRepository.swift)
  - 依賴: Core/Infrastructure/Persistence/BaseRepository
  - 依賴: IHabitRepository, Habit
  - 依賴: AppDbContext

---

## Stage 2.5: Habits Presentation Layer

實作 UI 層（SwiftUI Views 和 ViewModels）。

### Checklist

#### ViewModels
- [ ] HabitListViewModel (TidalHabits/Features/Habits/Presentation/ViewModels/HabitListViewModel.swift)
  - 依賴: GetHabitsQueryHandler, DeleteHabitCommandHandler
  - 依賴: HabitListItemDto
- [ ] HabitDetailViewModel (TidalHabits/Features/Habits/Presentation/ViewModels/HabitDetailViewModel.swift)
  - 依賴: GetHabitByIdQueryHandler, UpdateHabitCommandHandler
  - 依賴: HabitDetailDto
- [ ] HabitFormViewModel (TidalHabits/Features/Habits/Presentation/ViewModels/HabitFormViewModel.swift)
  - 依賴: CreateHabitCommandHandler, UpdateHabitCommandHandler

#### Views
- [ ] HabitListView (TidalHabits/Features/Habits/Presentation/Views/HabitListView.swift)
  - 依賴: HabitListViewModel
- [ ] HabitDetailView (TidalHabits/Features/Habits/Presentation/Views/HabitDetailView.swift)
  - 依賴: HabitDetailViewModel
- [ ] HabitFormView (TidalHabits/Features/Habits/Presentation/Views/HabitFormView.swift)
  - 依賴: HabitFormViewModel

#### Components
- [ ] HabitCardView (TidalHabits/Features/Habits/Presentation/Views/Components/HabitCardView.swift)
  - 依賴: HabitListItemDto
- [ ] HabitIconPicker (TidalHabits/Features/Habits/Presentation/Views/Components/HabitIconPicker.swift)
- [ ] HabitDurationPicker (TidalHabits/Features/Habits/Presentation/Views/Components/HabitDurationPicker.swift)

---

## Stage 2.6: 測試

為 Habits Feature 建立完整測試。

### Checklist

#### Domain Tests
- [ ] HabitTests (TidalHabitsTests/Unit/Features/Habits/Domain/Entities/HabitTests.swift)
- [ ] HabitNameTests (TidalHabitsTests/Unit/Features/Habits/Domain/ValueObjects/HabitNameTests.swift)
- [ ] HabitIconTests (TidalHabitsTests/Unit/Features/Habits/Domain/ValueObjects/HabitIconTests.swift)

#### Application Tests - Commands
- [ ] CreateHabitCommandHandlerTests (TidalHabitsTests/Unit/Features/Habits/Application/Commands/CreateHabitCommandHandlerTests.swift)
- [ ] UpdateHabitCommandHandlerTests (TidalHabitsTests/Unit/Features/Habits/Application/Commands/UpdateHabitCommandHandlerTests.swift)
- [ ] DeleteHabitCommandHandlerTests (TidalHabitsTests/Unit/Features/Habits/Application/Commands/DeleteHabitCommandHandlerTests.swift)

#### Application Tests - Queries
- [ ] GetHabitsQueryHandlerTests (TidalHabitsTests/Unit/Features/Habits/Application/Queries/GetHabitsQueryHandlerTests.swift)
- [ ] GetHabitByIdQueryHandlerTests (TidalHabitsTests/Unit/Features/Habits/Application/Queries/GetHabitByIdQueryHandlerTests.swift)

#### Infrastructure Tests
- [ ] HabitRepositoryTests (TidalHabitsTests/Integration/Features/Habits/Infrastructure/HabitRepositoryTests.swift)

#### Presentation Tests
- [ ] HabitListViewModelTests (TidalHabitsTests/Unit/Features/Habits/Presentation/ViewModels/HabitListViewModelTests.swift)
- [ ] HabitDetailViewModelTests (TidalHabitsTests/Unit/Features/Habits/Presentation/ViewModels/HabitDetailViewModelTests.swift)

#### UI Tests
- [ ] HabitListUITests (TidalHabitsUITests/Features/Habits/HabitListUITests.swift)
- [ ] HabitFormUITests (TidalHabitsUITests/Features/Habits/HabitFormUITests.swift)

---

## 完成標準

- [ ] 所有 Habits Feature 檔案已建立
- [ ] 所有檔案編譯無錯誤
- [ ] Domain 層單元測試覆蓋率 ≥ 90%
- [ ] Application 層單元測試覆蓋率 ≥ 80%
- [ ] Presentation 層單元測試覆蓋率 ≥ 60%
- [ ] 所有測試通過
- [ ] UI 功能正常運作
- [ ] SwiftLint 檢查通過
- [ ] 程式碼已 Code Review
- [ ] 文件已更新

---

## 依賴關係圖

```
Stage 2.1 (Domain)
├── Value Objects (獨立)
├── Domain Events (依賴 IDomainEvent)
├── Habit Entity (依賴 AggregateRoot, Value Objects, Domain Events)
├── IHabitRepository (依賴 IRepository, Habit)
└── Specifications (依賴 Habit)

Stage 2.2 (Commands)
├── Commands (依賴 ICommand)
├── Validators (依賴 Commands)
└── Command Handlers (依賴 ICommandHandler, Commands, IHabitRepository, Habit)

Stage 2.3 (Queries)
├── DTOs (獨立)
├── Queries (依賴 IQuery)
└── Query Handlers (依賴 IQueryHandler, Queries, IHabitRepository, DTOs)

Stage 2.4 (Infrastructure)
├── CoreData Configuration
└── HabitRepository (依賴 BaseRepository, IHabitRepository, Habit, AppDbContext)

Stage 2.5 (Presentation)
├── ViewModels (依賴 Handlers, DTOs)
├── Views (依賴 ViewModels)
└── Components (依賴 DTOs)

Stage 2.6 (Tests)
└── 所有測試 (依賴前面的實作)
```

---

## 下一步

完成 Phase 2 後，可以選擇：
- **Phase 3: Pomodoro Feature** - 番茄鐘功能
- **Phase 4: Statistics Feature** - 統計分析
- **Phase 5: Rewards Feature** - 獎勵系統

建議順序: Pomodoro → Rewards → Statistics
