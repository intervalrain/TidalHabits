# Phase 5: Statistics Feature - 統計分析功能

實作統計分析功能，包含多維度數據統計、視覺化圖表、趨勢分析等。

**目標**: 完成統計分析功能，整合所有 Features 的數據。

**預估時間**: 4-5 天

**前置條件**: Phase 1, 2, 3, 4 已完成

---

## Stage 5.1: Statistics Domain Layer

建立統計分析的領域模型。

### Checklist

#### Value Objects
- [ ] DateRange (TidalHabits/Features/Statistics/Domain/ValueObjects/DateRange.swift)
  - 依賴: Core/Domain/Common/ValueObject
- [ ] CompletionRate (TidalHabits/Features/Statistics/Domain/ValueObjects/CompletionRate.swift)
  - 依賴: Core/Domain/Common/ValueObject
- [ ] StreakCount (TidalHabits/Features/Statistics/Domain/ValueObjects/StreakCount.swift)
  - 依賴: Core/Domain/Common/ValueObject

#### Entities
- [ ] HabitStatistics (TidalHabits/Features/Statistics/Domain/Entities/HabitStatistics.swift)
  - 依賴: Core/Domain/Common/Entity
  - 依賴: Habits/Domain/Entities/Habit
  - 依賴: CompletionRate, StreakCount
- [ ] PeriodStatistics (TidalHabits/Features/Statistics/Domain/Entities/PeriodStatistics.swift)
  - 依賴: Core/Domain/Common/Entity
  - 依賴: DateRange

#### Domain Services
- [ ] StatisticsCalculationService (TidalHabits/Features/Statistics/Domain/Services/StatisticsCalculationService.swift)
  - 依賴: Pomodoro/Domain/Entities/PomodoroSession
  - 依賴: Habits/Domain/Entities/Habit
- [ ] StreakCalculationService (TidalHabits/Features/Statistics/Domain/Services/StreakCalculationService.swift)
  - 依賴: Pomodoro/Domain/Entities/PomodoroSession
- [ ] TrendAnalysisService (TidalHabits/Features/Statistics/Domain/Services/TrendAnalysisService.swift)
  - 依賴: HabitStatistics

#### Repository Interface
- [ ] IStatisticsRepository (TidalHabits/Features/Statistics/Domain/Repositories/IStatisticsRepository.swift)
  - 依賴: Core/Domain/Interfaces/IRepository
  - 依賴: HabitStatistics

---

## Stage 5.2: Statistics Application Layer - Queries

統計功能主要是讀取操作，以 Queries 為主。

### Checklist

#### DTOs
- [ ] HabitStatisticsDto (TidalHabits/Features/Statistics/Application/DTOs/HabitStatisticsDto.swift)
- [ ] OverallStatisticsDto (TidalHabits/Features/Statistics/Application/DTOs/OverallStatisticsDto.swift)
- [ ] DailyStatisticsDto (TidalHabits/Features/Statistics/Application/DTOs/DailyStatisticsDto.swift)
- [ ] WeeklyStatisticsDto (TidalHabits/Features/Statistics/Application/DTOs/WeeklyStatisticsDto.swift)
- [ ] MonthlyStatisticsDto (TidalHabits/Features/Statistics/Application/DTOs/MonthlyStatisticsDto.swift)
- [ ] TrendDataDto (TidalHabits/Features/Statistics/Application/DTOs/TrendDataDto.swift)

#### Get Overall Statistics
- [ ] GetOverallStatisticsQuery (TidalHabits/Features/Statistics/Application/Queries/GetOverallStatistics/GetOverallStatisticsQuery.swift)
  - 依賴: Core/Application/Common/IQuery
- [ ] GetOverallStatisticsQueryHandler (TidalHabits/Features/Statistics/Application/Queries/GetOverallStatistics/GetOverallStatisticsQueryHandler.swift)
  - 依賴: Core/Application/Common/IQueryHandler
  - 依賴: GetOverallStatisticsQuery
  - 依賴: Pomodoro/Domain/Repositories/IPomodoroRepository
  - 依賴: Rewards/Domain/Repositories/IUserStarsAccountRepository
  - 依賴: StatisticsCalculationService

#### Get Habit Statistics
- [ ] GetHabitStatisticsQuery (TidalHabits/Features/Statistics/Application/Queries/GetHabitStatistics/GetHabitStatisticsQuery.swift)
  - 依賴: Core/Application/Common/IQuery
- [ ] GetHabitStatisticsQueryHandler (TidalHabits/Features/Statistics/Application/Queries/GetHabitStatistics/GetHabitStatisticsQueryHandler.swift)
  - 依賴: Core/Application/Common/IQueryHandler
  - 依賴: GetHabitStatisticsQuery, IStatisticsRepository
  - 依賴: HabitStatisticsDto

#### Get Daily Statistics
- [ ] GetDailyStatisticsQuery (TidalHabits/Features/Statistics/Application/Queries/GetDailyStatistics/GetDailyStatisticsQuery.swift)
  - 依賴: Core/Application/Common/IQuery
- [ ] GetDailyStatisticsQueryHandler (TidalHabits/Features/Statistics/Application/Queries/GetDailyStatistics/GetDailyStatisticsQueryHandler.swift)
  - 依賴: Core/Application/Common/IQueryHandler
  - 依賴: GetDailyStatisticsQuery
  - 依賴: Pomodoro/Domain/Repositories/IPomodoroRepository
  - 依賴: StatisticsCalculationService

#### Get Weekly Statistics
- [ ] GetWeeklyStatisticsQuery (TidalHabits/Features/Statistics/Application/Queries/GetWeeklyStatistics/GetWeeklyStatisticsQuery.swift)
  - 依賴: Core/Application/Common/IQuery
- [ ] GetWeeklyStatisticsQueryHandler (TidalHabits/Features/Statistics/Application/Queries/GetWeeklyStatistics/GetWeeklyStatisticsQueryHandler.swift)
  - 依賴: Core/Application/Common/IQueryHandler
  - 依賴: GetWeeklyStatisticsQuery
  - 依賴: Pomodoro/Domain/Repositories/IPomodoroRepository
  - 依賴: WeeklyStatisticsDto

#### Get Monthly Statistics
- [ ] GetMonthlyStatisticsQuery (TidalHabits/Features/Statistics/Application/Queries/GetMonthlyStatistics/GetMonthlyStatisticsQuery.swift)
  - 依賴: Core/Application/Common/IQuery
- [ ] GetMonthlyStatisticsQueryHandler (TidalHabits/Features/Statistics/Application/Queries/GetMonthlyStatistics/GetMonthlyStatisticsQueryHandler.swift)
  - 依賴: Core/Application/Common/IQueryHandler
  - 依賴: GetMonthlyStatisticsQuery
  - 依賴: Pomodoro/Domain/Repositories/IPomodoroRepository
  - 依賴: MonthlyStatisticsDto

#### Get Trend Data
- [ ] GetTrendDataQuery (TidalHabits/Features/Statistics/Application/Queries/GetTrendData/GetTrendDataQuery.swift)
  - 依賴: Core/Application/Common/IQuery
- [ ] GetTrendDataQueryHandler (TidalHabits/Features/Statistics/Application/Queries/GetTrendData/GetTrendDataQueryHandler.swift)
  - 依賴: Core/Application/Common/IQueryHandler
  - 依賴: GetTrendDataQuery, IStatisticsRepository
  - 依賴: TrendAnalysisService
  - 依賴: TrendDataDto

---

## Stage 5.3: Statistics Infrastructure Layer

實作 Repository 和數據聚合邏輯。

### Checklist

#### Repository Implementation
- [ ] StatisticsRepository (TidalHabits/Features/Statistics/Infrastructure/Repositories/StatisticsRepository.swift)
  - 依賴: IStatisticsRepository
  - 依賴: AppDbContext
  - 依賴: Pomodoro/Infrastructure/Repositories/PomodoroRepository
  - 依賴: Habits/Infrastructure/Repositories/HabitRepository

#### Data Aggregation Services
- [ ] StatisticsAggregationService (TidalHabits/Features/Statistics/Infrastructure/Services/StatisticsAggregationService.swift)
  - 依賴: AppDbContext
  - 聚合多個 Features 的數據

---

## Stage 5.4: Statistics Presentation Layer

實作統計分析的 UI 層（含圖表）。

### Checklist

#### ViewModels
- [ ] OverallStatisticsViewModel (TidalHabits/Features/Statistics/Presentation/ViewModels/OverallStatisticsViewModel.swift)
  - 依賴: GetOverallStatisticsQueryHandler
  - 依賴: OverallStatisticsDto
- [ ] HabitStatisticsViewModel (TidalHabits/Features/Statistics/Presentation/ViewModels/HabitStatisticsViewModel.swift)
  - 依賴: GetHabitStatisticsQueryHandler
  - 依賴: HabitStatisticsDto
- [ ] TrendViewModel (TidalHabits/Features/Statistics/Presentation/ViewModels/TrendViewModel.swift)
  - 依賴: GetTrendDataQueryHandler
  - 依賴: TrendDataDto
- [ ] PeriodStatisticsViewModel (TidalHabits/Features/Statistics/Presentation/ViewModels/PeriodStatisticsViewModel.swift)
  - 依賴: GetDailyStatisticsQueryHandler, GetWeeklyStatisticsQueryHandler, GetMonthlyStatisticsQueryHandler

#### Views
- [ ] OverallStatisticsView (TidalHabits/Features/Statistics/Presentation/Views/OverallStatisticsView.swift)
  - 依賴: OverallStatisticsViewModel
- [ ] HabitStatisticsView (TidalHabits/Features/Statistics/Presentation/Views/HabitStatisticsView.swift)
  - 依賴: HabitStatisticsViewModel
- [ ] TrendChartView (TidalHabits/Features/Statistics/Presentation/Views/TrendChartView.swift)
  - 依賴: TrendViewModel
  - 使用 Swift Charts
- [ ] PeriodStatisticsView (TidalHabits/Features/Statistics/Presentation/Views/PeriodStatisticsView.swift)
  - 依賴: PeriodStatisticsViewModel

#### Components
- [ ] StatisticCardView (TidalHabits/Features/Statistics/Presentation/Views/Components/StatisticCardView.swift)
- [ ] CompletionRateChartView (TidalHabits/Features/Statistics/Presentation/Views/Components/CompletionRateChartView.swift)
  - 使用 Swift Charts
- [ ] StreakDisplayView (TidalHabits/Features/Statistics/Presentation/Views/Components/StreakDisplayView.swift)
- [ ] TimeDistributionChartView (TidalHabits/Features/Statistics/Presentation/Views/Components/TimeDistributionChartView.swift)
  - 使用 Swift Charts
- [ ] HeatMapView (TidalHabits/Features/Statistics/Presentation/Views/Components/HeatMapView.swift)
  - GitHub 風格熱度圖

---

## Stage 5.5: 測試

為 Statistics Feature 建立完整測試。

### Checklist

#### Domain Tests
- [ ] StatisticsCalculationServiceTests (TidalHabitsTests/Unit/Features/Statistics/Domain/Services/StatisticsCalculationServiceTests.swift)
- [ ] StreakCalculationServiceTests (TidalHabitsTests/Unit/Features/Statistics/Domain/Services/StreakCalculationServiceTests.swift)
- [ ] TrendAnalysisServiceTests (TidalHabitsTests/Unit/Features/Statistics/Domain/Services/TrendAnalysisServiceTests.swift)

#### Application Tests - Queries
- [ ] GetOverallStatisticsQueryHandlerTests (TidalHabitsTests/Unit/Features/Statistics/Application/Queries/GetOverallStatisticsQueryHandlerTests.swift)
- [ ] GetHabitStatisticsQueryHandlerTests (TidalHabitsTests/Unit/Features/Statistics/Application/Queries/GetHabitStatisticsQueryHandlerTests.swift)
- [ ] GetTrendDataQueryHandlerTests (TidalHabitsTests/Unit/Features/Statistics/Application/Queries/GetTrendDataQueryHandlerTests.swift)

#### Infrastructure Tests
- [ ] StatisticsRepositoryTests (TidalHabitsTests/Integration/Features/Statistics/Infrastructure/StatisticsRepositoryTests.swift)
- [ ] StatisticsAggregationServiceTests (TidalHabitsTests/Integration/Features/Statistics/Infrastructure/StatisticsAggregationServiceTests.swift)

#### Presentation Tests
- [ ] OverallStatisticsViewModelTests (TidalHabitsTests/Unit/Features/Statistics/Presentation/ViewModels/OverallStatisticsViewModelTests.swift)
- [ ] TrendViewModelTests (TidalHabitsTests/Unit/Features/Statistics/Presentation/ViewModels/TrendViewModelTests.swift)

#### UI Tests
- [ ] StatisticsViewUITests (TidalHabitsUITests/Features/Statistics/StatisticsViewUITests.swift)

---

## 完成標準

- [ ] 所有 Statistics Feature 檔案已建立
- [ ] 所有檔案編譯無錯誤
- [ ] Domain 層單元測試覆蓋率 ≥ 90%
- [ ] Application 層單元測試覆蓋率 ≥ 80%
- [ ] Presentation 層單元測試覆蓋率 ≥ 60%
- [ ] 所有測試通過
- [ ] 圖表正常顯示
- [ ] 數據計算正確
- [ ] 與所有 Features 整合正常
- [ ] SwiftLint 檢查通過
- [ ] 程式碼已 Code Review
- [ ] 文件已更新

---

## 下一步

完成 Phase 5 後，進入 **Phase 6: Shared UI Components** - 共用 UI 元件庫
