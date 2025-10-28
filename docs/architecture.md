# TidalHabits 架構設計文件

## 概述

TidalHabits 是一個自律習慣養成 iOS App，採用 Clean Architecture + CQRS 模式，以 feature-based 方式組織程式碼。

## 專案結構

```
TidalHabits/
├── src/                    # 原始碼
├── test/                   # 測試檔案
├── docs/                   # 文件
├── scripts/                # 建置與工具腳本
├── README.md
├── .gitignore
└── TidalHabits/           # Xcode 專案目錄
```

## src/ 目錄結構

```
src/
├── App/                    # 應用程式進入點
│   ├── TidalHabitsApp.swift
│   └── ContentView.swift
│
├── Core/                   # 核心共用模組
│   ├── Domain/            # DDD 基礎物件
│   │   ├── Entity.swift
│   │   ├── ValueObject.swift
│   │   ├── AggregateRoot.swift
│   │   └── DomainEvent.swift
│   ├── Extensions/        # Swift 擴充功能
│   └── Utilities/         # 工具類別
│
├── Feature/               # 功能模組 (Feature-based)
│   ├── CheckIn/          # 簽到/番茄鐘功能
│   │   ├── Application/  # CQRS Commands & Queries
│   │   ├── Domain/       # 領域模型
│   │   ├── Infrastructure/ # 資料存取、外部服務
│   │   └── Presentation/ # SwiftUI Views & ViewModels
│   │
│   ├── User/             # 使用者管理
│   │   ├── Application/
│   │   ├── Domain/
│   │   ├── Infrastructure/
│   │   └── Presentation/
│   │
│   ├── Habit/            # 習慣管理
│   │   ├── Application/
│   │   ├── Domain/
│   │   ├── Infrastructure/
│   │   └── Presentation/
│   │
│   ├── Statistic/        # 統計分析
│   │   ├── Application/
│   │   ├── Domain/
│   │   ├── Infrastructure/
│   │   └── Presentation/
│   │
│   └── Reward/           # 獎勵系統
│       ├── Application/
│       ├── Domain/
│       ├── Infrastructure/
│       └── Presentation/
│
└── Shared/               # 共用元件
    ├── Component/        # 可重用 UI 元件
    ├── Localization/     # 多語系資源
    ├── Navigation/       # 導航邏輯
    └── Theme/           # 主題與樣式
```

## Clean Architecture 分層說明

### 1. Presentation Layer (Presentation/)
- **責任**: 使用者介面與使用者互動
- **技術**: SwiftUI Views, ViewModels (MVVM)
- **範例檔案**:
  - `HabitListView.swift` - SwiftUI View
  - `HabitListViewModel.swift` - ViewModel
  - `HabitDetailView.swift`

### 2. Application Layer (Application/)
- **責任**: 應用程式業務流程、CQRS 實作
- **包含**:
  - Commands: 改變狀態的操作 (CreateHabitCommand, StartPomodoroCommand)
  - Queries: 查詢資料的操作 (GetHabitsQuery, GetStatisticsQuery)
  - Command/Query Handlers
  - DTOs (Data Transfer Objects)
- **範例檔案**:
  - `Commands/CreateHabitCommand.swift`
  - `Queries/GetHabitsQuery.swift`
  - `Handlers/CreateHabitCommandHandler.swift`

### 3. Domain Layer (Domain/)
- **責任**: 核心業務邏輯與規則
- **包含**:
  - Entities (實體)
  - Value Objects (值物件)
  - Aggregate Roots (聚合根)
  - Domain Services (領域服務)
  - Repository Interfaces (倉儲介面)
  - Domain Events (領域事件)
- **範例檔案**:
  - `Entities/Habit.swift`
  - `ValueObjects/PomodoroSession.swift`
  - `Repositories/IHabitRepository.swift`
  - `Services/HabitRewardCalculator.swift`

### 4. Infrastructure Layer (Infrastructure/)
- **責任**: 技術實作細節
- **包含**:
  - Repository 實作
  - Data Sources (CoreData, UserDefaults, API)
  - 外部服務整合
  - Persistence
- **範例檔案**:
  - `Repositories/HabitRepository.swift`
  - `DataSources/CoreDataHabitDataSource.swift`
  - `Persistence/PersistenceController.swift`

## CQRS 模式

### Command (寫入操作)
```swift
// Application/Commands/CreateHabitCommand.swift
struct CreateHabitCommand {
    let name: String
    let duration: TimeInterval
    let starsReward: Int
    let icon: String
}

// Application/Handlers/CreateHabitCommandHandler.swift
class CreateHabitCommandHandler {
    func handle(_ command: CreateHabitCommand) async throws -> UUID {
        // 業務邏輯處理
    }
}
```

### Query (讀取操作)
```swift
// Application/Queries/GetHabitsQuery.swift
struct GetHabitsQuery {
    let userId: UUID
}

// Application/Handlers/GetHabitsQueryHandler.swift
class GetHabitsQueryHandler {
    func handle(_ query: GetHabitsQuery) async throws -> [HabitDTO] {
        // 查詢邏輯
    }
}
```

## 依賴方向規則

```
Presentation → Application → Domain ← Infrastructure
```

- **Domain Layer** 不依賴任何其他層 (最核心)
- **Application Layer** 只依賴 Domain
- **Infrastructure Layer** 依賴 Domain (實作 Repository 介面)
- **Presentation Layer** 依賴 Application 和 Domain

## 命名慣例

### 檔案命名
- **Entity**: `Habit.swift`, `User.swift`
- **Value Object**: `PomodoroSession.swift`, `RewardPoints.swift`
- **Command**: `CreateHabitCommand.swift`
- **Query**: `GetHabitsQuery.swift`
- **Handler**: `CreateHabitCommandHandler.swift`
- **Repository Interface**: `IHabitRepository.swift`
- **Repository Implementation**: `HabitRepository.swift`
- **ViewModel**: `HabitListViewModel.swift`
- **View**: `HabitListView.swift`

### Swift 慣例
- **Protocol**: 以 `I` 開頭 (如 `IHabitRepository`) 或使用 `Protocol` 後綴
- **Class/Struct**: PascalCase
- **Variables/Functions**: camelCase
- **Constants**: camelCase 或 UPPER_SNAKE_CASE (全域常數)

## 資料流範例

### 建立新習慣的流程

```
User Action (View)
    ↓
ViewModel 呼叫 Command
    ↓
CreateHabitCommandHandler
    ↓
Domain Service 驗證業務規則
    ↓
Repository 儲存
    ↓
Infrastructure 持久化 (CoreData)
    ↓
Domain Event 發送 (可選)
    ↓
ViewModel 更新狀態
    ↓
View 重新渲染
```

## 測試策略

### 單元測試
- **Domain Layer**: 測試業務邏輯、實體行為
- **Application Layer**: 測試 Command/Query Handler
- **ViewModel**: 測試 Presentation 邏輯

### 整合測試
- **Repository**: 測試資料存取層
- **End-to-End**: 完整功能流程測試

### 測試目錄結構
```
test/
├── Unit/
│   ├── Domain/
│   ├── Application/
│   └── Presentation/
├── Integration/
└── E2E/
```

## 依賴注入

使用 Swift 的 Dependency Injection:
- Protocol-oriented programming
- Constructor injection
- Environment Objects (SwiftUI)

```swift
// 範例
class HabitListViewModel: ObservableObject {
    private let getHabitsQueryHandler: IGetHabitsQueryHandler

    init(getHabitsQueryHandler: IGetHabitsQueryHandler) {
        self.getHabitsQueryHandler = getHabitsQueryHandler
    }
}
```

## 優點總結

1. **關注點分離**: 每層職責清晰
2. **可測試性**: 易於撰寫單元測試
3. **可維護性**: 修改影響範圍小
4. **可擴展性**: 新增功能不影響現有程式碼
5. **團隊協作**: 不同團隊成員可平行開發不同 Feature
6. **技術獨立**: 易於替換技術實作 (如從 CoreData 換到 Realm)
