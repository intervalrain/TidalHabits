# Phase 3: Pomodoro Feature - 番茄鐘功能

實作番茄鐘計時功能，包含計時器、獎勵計算、延長機制等。

**目標**: 完成番茄鐘核心功能，與 Habits Feature 整合。

**預估時間**: 4-5 天

**前置條件**: Phase 1 和 Phase 2 已完成

---

## Stage 3.1: Pomodoro Domain Layer

建立番茄鐘的領域模型。

### Checklist

#### Value Objects
- [ ] SessionDuration (TidalHabits/Features/Pomodoro/Domain/ValueObjects/SessionDuration.swift)
  - 依賴: Core/Domain/Common/ValueObject
- [ ] SessionExtension (TidalHabits/Features/Pomodoro/Domain/ValueObjects/SessionExtension.swift)
  - 依賴: Core/Domain/Common/ValueObject
- [ ] SessionStatus (TidalHabits/Features/Pomodoro/Domain/ValueObjects/SessionStatus.swift)
  - 依賴: Core/Domain/Common/ValueObject (Enum)

#### Domain Events
- [ ] PomodoroSessionStartedEvent (TidalHabits/Features/Pomodoro/Domain/Events/PomodoroSessionStartedEvent.swift)
  - 依賴: Core/Domain/Common/IDomainEvent
- [ ] PomodoroSessionCompletedEvent (TidalHabits/Features/Pomodoro/Domain/Events/PomodoroSessionCompletedEvent.swift)
  - 依賴: Core/Domain/Common/IDomainEvent
- [ ] PomodoroSessionExtendedEvent (TidalHabits/Features/Pomodoro/Domain/Events/PomodoroSessionExtendedEvent.swift)
  - 依賴: Core/Domain/Common/IDomainEvent
- [ ] PomodoroSessionTerminatedEvent (TidalHabits/Features/Pomodoro/Domain/Events/PomodoroSessionTerminatedEvent.swift)
  - 依賴: Core/Domain/Common/IDomainEvent

#### Entities
- [ ] PomodoroSession (TidalHabits/Features/Pomodoro/Domain/Entities/PomodoroSession.swift)
  - 依賴: Core/Domain/Common/AggregateRoot
  - 依賴: SessionDuration, SessionExtension, SessionStatus
  - 依賴: Domain Events
  - 依賴: Habits/Domain/Entities/Habit (關聯)

#### Domain Services
- [ ] PomodoroRewardCalculator (TidalHabits/Features/Pomodoro/Domain/Services/PomodoroRewardCalculator.swift)
  - 依賴: PomodoroSession
- [ ] PomodoroTimerService (TidalHabits/Features/Pomodoro/Domain/Services/PomodoroTimerService.swift)
  - 依賴: PomodoroSession

#### Repository Interface
- [ ] IPomodoroRepository (TidalHabits/Features/Pomodoro/Domain/Repositories/IPomodoroRepository.swift)
  - 依賴: Core/Domain/Interfaces/IRepository
  - 依賴: PomodoroSession

---

## Stage 3.2: Pomodoro Application Layer - Commands

實作番茄鐘的寫入操作。

### Checklist

#### Start Pomodoro
- [ ] StartPomodoroCommand (TidalHabits/Features/Pomodoro/Application/Commands/StartPomodoro/StartPomodoroCommand.swift)
  - 依賴: Core/Application/Common/ICommand
- [ ] StartPomodoroCommandHandler (TidalHabits/Features/Pomodoro/Application/Commands/StartPomodoro/StartPomodoroCommandHandler.swift)
  - 依賴: Core/Application/Common/ICommandHandler
  - 依賴: StartPomodoroCommand, IPomodoroRepository, IUnitOfWork
  - 依賴: PomodoroSession, Habits/Domain/Repositories/IHabitRepository

#### Complete Pomodoro
- [ ] CompletePomodoroCommand (TidalHabits/Features/Pomodoro/Application/Commands/CompletePomodoro/CompletePomodoroCommand.swift)
  - 依賴: Core/Application/Common/ICommand
- [ ] CompletePomodoroCommandHandler (TidalHabits/Features/Pomodoro/Application/Commands/CompletePomodoro/CompletePomodoroCommandHandler.swift)
  - 依賴: Core/Application/Common/ICommandHandler
  - 依賴: CompletePomodoroCommand, IPomodoroRepository, IUnitOfWork
  - 依賴: PomodoroRewardCalculator

#### Extend Pomodoro
- [ ] ExtendPomodoroCommand (TidalHabits/Features/Pomodoro/Application/Commands/ExtendPomodoro/ExtendPomodoroCommand.swift)
  - 依賴: Core/Application/Common/ICommand
- [ ] ExtendPomodoroCommandHandler (TidalHabits/Features/Pomodoro/Application/Commands/ExtendPomodoro/ExtendPomodoroCommandHandler.swift)
  - 依賴: Core/Application/Common/ICommandHandler
  - 依賴: ExtendPomodoroCommand, IPomodoroRepository, IUnitOfWork

#### Terminate Pomodoro
- [ ] TerminatePomodoroCommand (TidalHabits/Features/Pomodoro/Application/Commands/TerminatePomodoro/TerminatePomodoroCommand.swift)
  - 依賴: Core/Application/Common/ICommand
- [ ] TerminatePomodoroCommandHandler (TidalHabits/Features/Pomodoro/Application/Commands/TerminatePomodoro/TerminatePomodoroCommandHandler.swift)
  - 依賴: Core/Application/Common/ICommandHandler
  - 依賴: TerminatePomodoroCommand, IPomodoroRepository, IUnitOfWork

---

## Stage 3.3: Pomodoro Application Layer - Queries

實作番茄鐘的讀取操作。

### Checklist

#### DTOs
- [ ] PomodoroSessionDto (TidalHabits/Features/Pomodoro/Application/DTOs/PomodoroSessionDto.swift)
- [ ] ActiveSessionDto (TidalHabits/Features/Pomodoro/Application/DTOs/ActiveSessionDto.swift)
- [ ] SessionHistoryDto (TidalHabits/Features/Pomodoro/Application/DTOs/SessionHistoryDto.swift)

#### Get Active Session
- [ ] GetActiveSessionQuery (TidalHabits/Features/Pomodoro/Application/Queries/GetActiveSession/GetActiveSessionQuery.swift)
  - 依賴: Core/Application/Common/IQuery
- [ ] GetActiveSessionQueryHandler (TidalHabits/Features/Pomodoro/Application/Queries/GetActiveSession/GetActiveSessionQueryHandler.swift)
  - 依賴: Core/Application/Common/IQueryHandler
  - 依賴: GetActiveSessionQuery, IPomodoroRepository
  - 依賴: ActiveSessionDto

#### Get Session History
- [ ] GetSessionHistoryQuery (TidalHabits/Features/Pomodoro/Application/Queries/GetSessionHistory/GetSessionHistoryQuery.swift)
  - 依賴: Core/Application/Common/IQuery
- [ ] GetSessionHistoryQueryHandler (TidalHabits/Features/Pomodoro/Application/Queries/GetSessionHistory/GetSessionHistoryQueryHandler.swift)
  - 依賴: Core/Application/Common/IQueryHandler
  - 依賴: GetSessionHistoryQuery, IPomodoroRepository
  - 依賴: SessionHistoryDto

#### Get Session By Id
- [ ] GetSessionByIdQuery (TidalHabits/Features/Pomodoro/Application/Queries/GetSessionById/GetSessionByIdQuery.swift)
  - 依賴: Core/Application/Common/IQuery
- [ ] GetSessionByIdQueryHandler (TidalHabits/Features/Pomodoro/Application/Queries/GetSessionById/GetSessionByIdQueryHandler.swift)
  - 依賴: Core/Application/Common/IQueryHandler
  - 依賴: GetSessionByIdQuery, IPomodoroRepository
  - 依賴: PomodoroSessionDto

---

## Stage 3.4: Pomodoro Infrastructure Layer

實作 Repository 和 CoreData 配置。

### Checklist

#### CoreData Configuration
- [ ] PomodoroSessionEntity.xcdatamodel (TidalHabits/TidalHabits.xcdatamodeld/PomodoroSessionEntity.xcdatamodel)
  - CoreData Entity 定義
- [ ] PomodoroConfiguration (TidalHabits/Features/Pomodoro/Infrastructure/Configurations/PomodoroConfiguration.swift)
  - 依賴: PomodoroSessionEntity

#### Repository Implementation
- [ ] PomodoroRepository (TidalHabits/Features/Pomodoro/Infrastructure/Repositories/PomodoroRepository.swift)
  - 依賴: Core/Infrastructure/Persistence/BaseRepository
  - 依賴: IPomodoroRepository, PomodoroSession
  - 依賴: AppDbContext

---

## Stage 3.5: Pomodoro Presentation Layer

實作番茄鐘的 UI 層。

### Checklist

#### ViewModels
- [ ] PomodoroTimerViewModel (TidalHabits/Features/Pomodoro/Presentation/ViewModels/PomodoroTimerViewModel.swift)
  - 依賴: StartPomodoroCommandHandler, CompletePomodoroCommandHandler
  - 依賴: ExtendPomodoroCommandHandler, TerminatePomodoroCommandHandler
  - 依賴: GetActiveSessionQueryHandler
  - 依賴: ActiveSessionDto
- [ ] SessionHistoryViewModel (TidalHabits/Features/Pomodoro/Presentation/ViewModels/SessionHistoryViewModel.swift)
  - 依賴: GetSessionHistoryQueryHandler
  - 依賴: SessionHistoryDto

#### Views
- [ ] PomodoroTimerView (TidalHabits/Features/Pomodoro/Presentation/Views/PomodoroTimerView.swift)
  - 依賴: PomodoroTimerViewModel
- [ ] SessionHistoryView (TidalHabits/Features/Pomodoro/Presentation/Views/SessionHistoryView.swift)
  - 依賴: SessionHistoryViewModel
- [ ] HabitSelectionView (TidalHabits/Features/Pomodoro/Presentation/Views/HabitSelectionView.swift)
  - 依賴: Habits/Application/Queries (GetActiveHabitsQuery)

#### Components
- [ ] TimerCircleView (TidalHabits/Features/Pomodoro/Presentation/Views/Components/TimerCircleView.swift)
- [ ] TimerControlsView (TidalHabits/Features/Pomodoro/Presentation/Views/Components/TimerControlsView.swift)
- [ ] SessionSummaryView (TidalHabits/Features/Pomodoro/Presentation/Views/Components/SessionSummaryView.swift)

---

## Stage 3.6: 測試

為 Pomodoro Feature 建立完整測試。

### Checklist

#### Domain Tests
- [ ] PomodoroSessionTests (TidalHabitsTests/Unit/Features/Pomodoro/Domain/Entities/PomodoroSessionTests.swift)
- [ ] PomodoroRewardCalculatorTests (TidalHabitsTests/Unit/Features/Pomodoro/Domain/Services/PomodoroRewardCalculatorTests.swift)
- [ ] SessionDurationTests (TidalHabitsTests/Unit/Features/Pomodoro/Domain/ValueObjects/SessionDurationTests.swift)

#### Application Tests - Commands
- [ ] StartPomodoroCommandHandlerTests (TidalHabitsTests/Unit/Features/Pomodoro/Application/Commands/StartPomodoroCommandHandlerTests.swift)
- [ ] CompletePomodoroCommandHandlerTests (TidalHabitsTests/Unit/Features/Pomodoro/Application/Commands/CompletePomodoroCommandHandlerTests.swift)
- [ ] ExtendPomodoroCommandHandlerTests (TidalHabitsTests/Unit/Features/Pomodoro/Application/Commands/ExtendPomodoroCommandHandlerTests.swift)

#### Application Tests - Queries
- [ ] GetActiveSessionQueryHandlerTests (TidalHabitsTests/Unit/Features/Pomodoro/Application/Queries/GetActiveSessionQueryHandlerTests.swift)
- [ ] GetSessionHistoryQueryHandlerTests (TidalHabitsTests/Unit/Features/Pomodoro/Application/Queries/GetSessionHistoryQueryHandlerTests.swift)

#### Infrastructure Tests
- [ ] PomodoroRepositoryTests (TidalHabitsTests/Integration/Features/Pomodoro/Infrastructure/PomodoroRepositoryTests.swift)

#### Presentation Tests
- [ ] PomodoroTimerViewModelTests (TidalHabitsTests/Unit/Features/Pomodoro/Presentation/ViewModels/PomodoroTimerViewModelTests.swift)

#### UI Tests
- [ ] PomodoroTimerUITests (TidalHabitsUITests/Features/Pomodoro/PomodoroTimerUITests.swift)

---

## 完成標準

- [ ] 所有 Pomodoro Feature 檔案已建立
- [ ] 所有檔案編譯無錯誤
- [ ] Domain 層單元測試覆蓋率 ≥ 90%
- [ ] Application 層單元測試覆蓋率 ≥ 80%
- [ ] Presentation 層單元測試覆蓋率 ≥ 60%
- [ ] 所有測試通過
- [ ] UI 功能正常運作（計時、延長、終止）
- [ ] 與 Habits Feature 整合正常
- [ ] SwiftLint 檢查通過
- [ ] 程式碼已 Code Review
- [ ] 文件已更新

---

## 下一步

完成 Phase 3 後，進入 **Phase 4: Rewards Feature** - 獎勵系統
