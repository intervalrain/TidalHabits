# TidalHabits 專案結構說明

## 目錄結構總覽

```
TidalHabits/
├── src/                              # 原始碼 (將移動 Swift 檔案至此)
│   ├── App/                          # 應用程式進入點
│   │   ├── TidalHabitsApp.swift     # App 主體
│   │   ├── ContentView.swift        # 根視圖
│   │   └── AppDelegate.swift        # App 生命週期 (如需要)
│   │
│   ├── Core/                         # 核心共用模組
│   │   ├── Domain/                  # DDD 基礎建構
│   │   │   ├── Entity.swift        # Entity 基礎協定
│   │   │   ├── ValueObject.swift   # Value Object 基礎協定
│   │   │   ├── AggregateRoot.swift # Aggregate Root 基礎
│   │   │   ├── DomainEvent.swift   # 領域事件
│   │   │   └── Result.swift        # Result 型別
│   │   │
│   │   ├── Extensions/              # Swift 擴充功能
│   │   │   ├── Date+Extensions.swift
│   │   │   ├── String+Extensions.swift
│   │   │   ├── TimeInterval+Extensions.swift
│   │   │   └── View+Extensions.swift
│   │   │
│   │   └── Utilities/               # 工具類別
│   │       ├── Logger.swift
│   │       ├── DateFormatter.swift
│   │       └── Validators.swift
│   │
│   ├── Feature/                     # 功能模組 (Feature-based)
│   │   │
│   │   ├── CheckIn/                 # 番茄鐘功能
│   │   │   ├── Application/
│   │   │   │   ├── Commands/
│   │   │   │   │   ├── StartPomodoroCommand.swift
│   │   │   │   │   ├── CompletePomodoroCommand.swift
│   │   │   │   │   ├── TerminatePomodoroCommand.swift
│   │   │   │   │   └── ExtendPomodoroCommand.swift
│   │   │   │   ├── Queries/
│   │   │   │   │   ├── GetActivePomodoroQuery.swift
│   │   │   │   │   └── GetPomodoroHistoryQuery.swift
│   │   │   │   ├── Handlers/
│   │   │   │   │   ├── StartPomodoroCommandHandler.swift
│   │   │   │   │   └── ...
│   │   │   │   └── DTOs/
│   │   │   │       └── PomodoroDTO.swift
│   │   │   │
│   │   │   ├── Domain/
│   │   │   │   ├── Entities/
│   │   │   │   │   └── PomodoroSession.swift
│   │   │   │   ├── ValueObjects/
│   │   │   │   │   └── SessionExtension.swift
│   │   │   │   ├── Services/
│   │   │   │   │   └── PomodoroTimer.swift
│   │   │   │   ├── Repositories/
│   │   │   │   │   └── IPomodoroSessionRepository.swift
│   │   │   │   └── Errors/
│   │   │   │       └── PomodoroError.swift
│   │   │   │
│   │   │   ├── Infrastructure/
│   │   │   │   ├── Repositories/
│   │   │   │   │   └── PomodoroSessionRepository.swift
│   │   │   │   ├── DataSources/
│   │   │   │   │   └── CoreDataPomodoroDataSource.swift
│   │   │   │   └── Services/
│   │   │   │       ├── ScreenLockService.swift
│   │   │   │       ├── NotificationService.swift
│   │   │   │       └── TimerService.swift
│   │   │   │
│   │   │   └── Presentation/
│   │   │       ├── Views/
│   │   │       │   ├── PomodoroView.swift
│   │   │       │   ├── PomodoroCompletionView.swift
│   │   │       │   ├── PomodoroTerminationDialog.swift
│   │   │       │   └── PomodoroExtensionSheet.swift
│   │   │       └── ViewModels/
│   │   │           └── PomodoroViewModel.swift
│   │   │
│   │   ├── Habit/                   # 習慣管理
│   │   │   ├── Application/
│   │   │   │   ├── Commands/
│   │   │   │   │   ├── CreateHabitCommand.swift
│   │   │   │   │   ├── UpdateHabitCommand.swift
│   │   │   │   │   ├── DeleteHabitCommand.swift
│   │   │   │   │   └── AddHabitReminderCommand.swift
│   │   │   │   ├── Queries/
│   │   │   │   │   ├── GetAllHabitsQuery.swift
│   │   │   │   │   └── GetHabitByIdQuery.swift
│   │   │   │   ├── Handlers/
│   │   │   │   └── DTOs/
│   │   │   │       └── HabitDTO.swift
│   │   │   │
│   │   │   ├── Domain/
│   │   │   │   ├── Entities/
│   │   │   │   │   └── Habit.swift
│   │   │   │   ├── ValueObjects/
│   │   │   │   │   └── HabitReminder.swift
│   │   │   │   ├── Repositories/
│   │   │   │   │   └── IHabitRepository.swift
│   │   │   │   └── Errors/
│   │   │   │       └── HabitError.swift
│   │   │   │
│   │   │   ├── Infrastructure/
│   │   │   │   ├── Repositories/
│   │   │   │   │   └── HabitRepository.swift
│   │   │   │   └── DataSources/
│   │   │   │       └── CoreDataHabitDataSource.swift
│   │   │   │
│   │   │   └── Presentation/
│   │   │       ├── Views/
│   │   │       │   ├── HabitListView.swift
│   │   │       │   ├── HabitFormView.swift
│   │   │       │   ├── HabitDetailView.swift
│   │   │       │   └── HabitReminderView.swift
│   │   │       └── ViewModels/
│   │   │           └── HabitListViewModel.swift
│   │   │
│   │   ├── Statistic/               # 統計分析
│   │   │   ├── Application/
│   │   │   ├── Domain/
│   │   │   ├── Infrastructure/
│   │   │   └── Presentation/
│   │   │
│   │   ├── Reward/                  # 獎勵系統
│   │   │   ├── Application/
│   │   │   ├── Domain/
│   │   │   ├── Infrastructure/
│   │   │   └── Presentation/
│   │   │
│   │   └── User/                    # 使用者管理
│   │       ├── Application/
│   │       ├── Domain/
│   │       ├── Infrastructure/
│   │       └── Presentation/
│   │
│   └── Shared/                      # 共用元件
│       ├── Component/               # 可重用 UI 元件
│       │   ├── Buttons/
│       │   │   ├── PrimaryButton.swift
│       │   │   └── SecondaryButton.swift
│       │   ├── Cards/
│       │   │   ├── StatCard.swift
│       │   │   └── HabitCard.swift
│       │   ├── Charts/
│       │   │   └── CustomProgressRing.swift
│       │   └── Common/
│       │       ├── LoadingView.swift
│       │       └── EmptyStateView.swift
│       │
│       ├── Localization/            # 多語系資源
│       │   ├── Localizable.strings (Base)
│       │   ├── zh-Hant.lproj/
│       │   │   └── Localizable.strings
│       │   ├── zh-Hans.lproj/
│       │   │   └── Localizable.strings
│       │   ├── en.lproj/
│       │   │   └── Localizable.strings
│       │   ├── ja.lproj/
│       │   │   └── Localizable.strings
│       │   └── ko.lproj/
│       │       └── Localizable.strings
│       │
│       ├── Navigation/              # 導航邏輯
│       │   ├── Router.swift
│       │   ├── TabBarView.swift
│       │   └── NavigationCoordinator.swift
│       │
│       └── Theme/                   # 主題與樣式
│           ├── Colors.swift
│           ├── Fonts.swift
│           ├── Spacing.swift
│           └── Styles.swift
│
├── test/                            # 測試檔案
│   ├── Unit/                        # 單元測試
│   │   ├── Domain/
│   │   │   ├── Habit/
│   │   │   │   ├── HabitTests.swift
│   │   │   │   └── HabitReminderTests.swift
│   │   │   └── CheckIn/
│   │   │       ├── PomodoroSessionTests.swift
│   │   │       └── PomodoroTimerTests.swift
│   │   │
│   │   ├── Application/
│   │   │   ├── Habit/
│   │   │   │   ├── CreateHabitCommandHandlerTests.swift
│   │   │   │   └── GetAllHabitsQueryHandlerTests.swift
│   │   │   └── CheckIn/
│   │   │       ├── StartPomodoroCommandHandlerTests.swift
│   │   │       └── CompletePomodoroCommandHandlerTests.swift
│   │   │
│   │   └── Presentation/
│   │       ├── HabitListViewModelTests.swift
│   │       └── PomodoroViewModelTests.swift
│   │
│   ├── Integration/                 # 整合測試
│   │   ├── Repositories/
│   │   │   ├── HabitRepositoryTests.swift
│   │   │   └── PomodoroSessionRepositoryTests.swift
│   │   └── EndToEnd/
│   │       ├── CreateHabitFlowTests.swift
│   │       └── CompletePomodoroFlowTests.swift
│   │
│   └── UI/                          # UI 測試
│       ├── HabitManagementUITests.swift
│       ├── PomodoroFlowUITests.swift
│       └── StatisticsUITests.swift
│
├── docs/                            # 文件
│   ├── architecture.md              # 架構設計
│   ├── development-standards.md     # 開發規範
│   ├── project-structure.md         # 本文件
│   └── features/                    # 功能規格
│       ├── overview.md
│       ├── habit/
│       │   └── spec.md
│       ├── checkin/
│       │   └── spec.md
│       ├── statistics/
│       │   └── spec.md
│       ├── calendar/
│       │   └── spec.md
│       ├── home/
│       │   └── spec.md
│       ├── settings/
│       │   └── spec.md
│       └── reward/
│           └── spec.md
│
├── scripts/                         # 建置與工具腳本
│   ├── setup.sh                    # 環境設定腳本
│   ├── test.sh                     # 測試腳本
│   ├── lint.sh                     # Lint 腳本
│   └── generate_localization.sh    # 多語系檔案生成
│
├── TidalHabits/                    # Xcode 專案目錄
│   ├── TidalHabits/                # 主要目標
│   │   ├── Assets.xcassets        # 資源檔案
│   │   ├── Preview Content/       # 預覽資源
│   │   └── TidalHabits.xcdatamodeld/ # CoreData 模型
│   │
│   ├── TidalHabitsTests/          # Xcode 測試目標
│   ├── TidalHabitsUITests/        # Xcode UI 測試目標
│   └── TidalHabits.xcodeproj/     # Xcode 專案檔
│
├── .gitignore                      # Git 忽略檔案
├── .swiftlint.yml                  # SwiftLint 配置 (可選)
├── README.md                       # 專案說明
├── CHANGELOG.md                    # 版本更新記錄
└── LICENSE                         # 授權

```

## 結構說明

### src/ 目錄

#### App/
應用程式進入點,包含 `@main` 的 App 結構與根視圖。

#### Core/
核心共用模組,包含:
- **Domain/**: DDD 基礎建構 (Entity, Value Object, Aggregate Root)
- **Extensions/**: Swift 標準庫擴充
- **Utilities/**: 工具類別 (Logger, Validator 等)

#### Feature/
功能模組,每個模組遵循 Clean Architecture 四層結構:

1. **Application/**: CQRS 實作
   - Commands/: 寫入操作
   - Queries/: 讀取操作
   - Handlers/: 處理器
   - DTOs/: 資料傳輸物件

2. **Domain/**: 領域模型
   - Entities/: 實體
   - ValueObjects/: 值物件
   - Services/: 領域服務
   - Repositories/: 倉儲介面
   - Errors/: 領域錯誤

3. **Infrastructure/**: 技術實作
   - Repositories/: 倉儲實作
   - DataSources/: 資料來源 (CoreData, API)
   - Services/: 外部服務整合

4. **Presentation/**: UI 層
   - Views/: SwiftUI 視圖
   - ViewModels/: 視圖模型 (MVVM)

#### Shared/
共用元件,跨 Feature 使用:
- **Component/**: 可重用 UI 元件
- **Localization/**: 多語系資源檔
- **Navigation/**: 導航與路由
- **Theme/**: 主題、顏色、字體

### test/ 目錄

依測試類型分類:
- **Unit/**: 單元測試 (Domain, Application, Presentation)
- **Integration/**: 整合測試 (Repository, EndToEnd)
- **UI/**: UI 測試 (使用 XCUITest)

### docs/ 目錄

專案文件:
- **architecture.md**: Clean Architecture 詳細說明
- **development-standards.md**: 開發規範與流程
- **features/**: 各功能模組的詳細規格

### scripts/ 目錄

自動化腳本:
- 環境設定
- 測試執行
- 程式碼檢查
- 建置發布

## 檔案命名慣例

### Entity
- `Habit.swift`
- `PomodoroSession.swift`

### Value Object
- `HabitReminder.swift`
- `SessionExtension.swift`

### Command/Query
- `CreateHabitCommand.swift`
- `GetAllHabitsQuery.swift`

### Handler
- `CreateHabitCommandHandler.swift`
- `GetAllHabitsQueryHandler.swift`

### Repository
- Interface: `IHabitRepository.swift`
- Implementation: `HabitRepository.swift`

### ViewModel
- `HabitListViewModel.swift`
- `PomodoroViewModel.swift`

### View
- `HabitListView.swift`
- `PomodoroView.swift`

## 依賴方向

```
Presentation → Application → Domain ← Infrastructure
                                ↑
                             Shared
```

- **Domain**: 不依賴任何其他層
- **Application**: 只依賴 Domain
- **Infrastructure**: 依賴 Domain (實作介面)
- **Presentation**: 依賴 Application 和 Domain
- **Shared**: 可被所有層使用,但不依賴 Feature

## 模組獨立性

每個 Feature 模組應:
- 高內聚: 相關功能在同一模組內
- 低耦合: 模組間透過明確介面溝通
- 可獨立測試: 每個模組有自己的測試
- 可替換: 替換實作不影響其他模組

## 資料流

### 寫入流程 (Command)
```
View → ViewModel → CommandHandler → Domain Service → Repository → DataSource
```

### 讀取流程 (Query)
```
View ← ViewModel ← QueryHandler ← Repository ← DataSource
```

## 下一步

1. 將現有的 Swift 檔案移至對應的 `src/` 目錄
2. 在 Xcode 中調整檔案參考路徑
3. 開始實作第一個 Feature (建議從 Habit 開始)
4. 遵循 TDD 流程: 定義規格 → 測試 → 實作 → Review → Commit
