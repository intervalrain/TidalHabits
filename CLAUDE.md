# TidalHabits - 專案完整指南

> 潮汐般穩定的習慣養成 iOS App 🌊

**最後更新**: 2025-10-28

---

## 目錄

1. [專案概述](#專案概述)
2. [架構設計](#架構設計)
3. [專案結構](#專案結構)
4. [開發規範](#開發規範)
5. [技術棧](#技術棧)
6. [核心功能](#核心功能)
7. [實作指南](#實作指南)
8. [專案優勢](#專案優勢)

---

## 專案概述

### 基本資訊

- **專案名稱**: TidalHabits
- **類型**: iOS 自律習慣養成 App
- **架構**: Clean Architecture + CQRS
- **組織方式**: Feature-based
- **開發方法**: TDD (Test-Driven Development)
- **目標平台**: iOS 16.0+, 未來支援 Apple Watch
- **Repository**: [https://github.com/intervalrain/TidalHabits](https://github.com/intervalrain/TidalHabits)

### 專案願景

TidalHabits 採用 Clean Architecture + CQRS 模式開發，以 feature-based 方式組織程式碼，確保高可維護性、可測試性與可擴展性。透過番茄鐘機制與獎勵系統，幫助使用者建立並維持良好習慣。

### 核心特點

- ✅ **完整的架構設計**: Clean Architecture + CQRS
- ✅ **明確的開發規範**: TDD 流程與品質標準
- ✅ **詳盡的功能規格**: 每個 Feature 都有完整文件
- ✅ **清晰的專案結構**: Feature-based 模組化組織
- ✅ **專業的開發流程**: 規格 → 測試 → 實作 → Review → Commit

---

## 架構設計

### Clean Architecture 分層

TidalHabits 採用經典的 Clean Architecture 四層架構:

```
┌─────────────────────────────────────┐
│        Presentation Layer           │  SwiftUI Views & ViewModels
│    (Views, ViewModels, UI Logic)    │
└─────────────┬───────────────────────┘
              ↓
┌─────────────────────────────────────┐
│        Application Layer            │  CQRS Commands & Queries
│  (Commands, Queries, Handlers, DTOs)│
└─────────────┬───────────────────────┘
              ↓
┌─────────────────────────────────────┐
│          Domain Layer               │  核心業務邏輯 (不依賴外部)
│ (Entities, Value Objects, Services) │
└─────────────┬───────────────────────┘
              ↑
┌─────────────────────────────────────┐
│      Infrastructure Layer           │  技術實作細節
│  (Repositories, DataSources, APIs)  │
└─────────────────────────────────────┘
```

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
  - **Commands**: 改變狀態的操作 (CreateHabitCommand, StartPomodoroCommand)
  - **Queries**: 查詢資料的操作 (GetHabitsQuery, GetStatisticsQuery)
  - **Command/Query Handlers**
  - **DTOs** (Data Transfer Objects)
- **範例檔案**:
  - `Commands/CreateHabitCommand.swift`
  - `Queries/GetHabitsQuery.swift`
  - `Handlers/CreateHabitCommandHandler.swift`

### 3. Domain Layer (Domain/)

- **責任**: 核心業務邏輯與規則
- **包含**:
  - **Entities** (實體)
  - **Value Objects** (值物件)
  - **Aggregate Roots** (聚合根)
  - **Domain Services** (領域服務)
  - **Repository Interfaces** (倉儲介面)
  - **Domain Events** (領域事件)
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

### CQRS 模式

#### Command (寫入操作)

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

#### Query (讀取操作)

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

### 依賴方向規則

```
Presentation → Application → Domain ← Infrastructure
                                ↑
                             Shared
```

- **Domain Layer** 不依賴任何其他層 (最核心)
- **Application Layer** 只依賴 Domain
- **Infrastructure Layer** 依賴 Domain (實作 Repository 介面)
- **Presentation Layer** 依賴 Application 和 Domain
- **Shared** 可被所有層使用，但不依賴 Feature

### 資料流範例

#### 建立新習慣的流程

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

#### 寫入流程 (Command)

```
View → ViewModel → CommandHandler → Domain Service → Repository → DataSource
```

#### 讀取流程 (Query)

```
View ← ViewModel ← QueryHandler ← Repository ← DataSource
```

---

## 專案結構

### 目錄結構總覽

```
TidalHabits/
├── src/                              # 原始碼
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
│   │   ├── CheckIn/                 # 番茄鐘功能
│   │   ├── Habit/                   # 習慣管理
│   │   ├── Statistic/               # 統計分析
│   │   ├── Reward/                  # 獎勵系統
│   │   └── User/                    # 使用者管理
│   │
│   └── Shared/                      # 共用元件
│       ├── Component/               # 可重用 UI 元件
│       ├── Localization/            # 多語系資源
│       ├── Navigation/              # 導航邏輯
│       └── Theme/                   # 主題與樣式
│
├── test/                            # 測試檔案
│   ├── Unit/                        # 單元測試
│   ├── Integration/                 # 整合測試
│   └── UI/                          # UI 測試
│
├── docs/                            # 文件
│   ├── dev/                         # 開發相關文件
│   │   ├── github/                  # GitHub 設定
│   │   ├── notes/                   # 開發筆記
│   │   └── milestones/              # Milestone 規劃
│   └── features/                    # 功能規格
│
├── scripts/                         # 建置與工具腳本
├── TidalHabits/                    # Xcode 專案目錄
├── .github/                        # GitHub 設定
├── README.md
├── CHANGELOG.md
├── LICENSE
└── CLAUDE.md                       # 本文件
```

### Feature 模組結構

每個 Feature 模組遵循 Clean Architecture 四層結構:

```
Feature/Habit/
├── Application/          # CQRS Commands & Queries
│   ├── Commands/        # 寫入操作
│   ├── Queries/         # 讀取操作
│   ├── Handlers/        # 處理器
│   └── DTOs/            # 資料傳輸物件
│
├── Domain/              # 領域模型
│   ├── Entities/        # 實體
│   ├── ValueObjects/    # 值物件
│   ├── Services/        # 領域服務
│   ├── Repositories/    # 倉儲介面
│   └── Errors/          # 領域錯誤
│
├── Infrastructure/      # 技術實作
│   ├── Repositories/    # 倉儲實作
│   ├── DataSources/     # 資料來源 (CoreData, API)
│   └── Services/        # 外部服務整合
│
└── Presentation/        # UI 層
    ├── Views/           # SwiftUI 視圖
    └── ViewModels/      # 視圖模型 (MVVM)
```

### 已建立的 Feature 目錄

- ✅ **CheckIn** - 番茄鐘功能
- ✅ **Habit** - 習慣管理
- ✅ **Statistic** - 統計分析
- ✅ **Reward** - 獎勵系統
- ✅ **User** - 使用者管理

### 檔案命名慣例

#### Entity
- `Habit.swift`
- `PomodoroSession.swift`

#### Value Object
- `HabitReminder.swift`
- `SessionExtension.swift`

#### Command/Query
- `CreateHabitCommand.swift`
- `GetAllHabitsQuery.swift`

#### Handler
- `CreateHabitCommandHandler.swift`
- `GetAllHabitsQueryHandler.swift`

#### Repository
- Interface: `IHabitRepository.swift`
- Implementation: `HabitRepository.swift`

#### ViewModel
- `HabitListViewModel.swift`
- `PomodoroViewModel.swift`

#### View
- `HabitListView.swift`
- `PomodoroView.swift`

### Swift 命名慣例

- **Protocol**: 以 `I` 開頭 (如 `IHabitRepository`) 或使用 `Protocol` 後綴
- **Class/Struct**: PascalCase
- **Variables/Functions**: camelCase
- **Constants**: camelCase 或 UPPER_SNAKE_CASE (全域常數)

### 模組獨立性原則

每個 Feature 模組應:
- **高內聚**: 相關功能在同一模組內
- **低耦合**: 模組間透過明確介面溝通
- **可獨立測試**: 每個模組有自己的測試
- **可替換**: 替換實作不影響其他模組

---

## 開發規範

### TDD 開發流程

本專案採用嚴格的 TDD (Test-Driven Development) 流程:

```
1. 定義規格 (Specification)
   ↓
2. 撰寫測試 (Write Tests)
   ↓
3. 實作功能 (Implementation)
   ↓
4. Code Review
   ↓
   ├─ Passed → 5. Commit
   └─ Failed → 返回步驟 1
```

### 測試策略

#### 測試覆蓋率目標

- **Domain Layer**: ≥ 90%
- **Application Layer**: ≥ 80%
- **Presentation Layer**: ≥ 60%
- **Overall**: ≥ 75%

#### 測試類別

1. **Unit Tests**: 測試單一元件 (Domain, Application, ViewModel)
2. **Integration Tests**: 測試多個元件整合 (Repository, DataSource)
3. **UI Tests**: 測試使用者介面流程

#### 測試目錄結構

```
test/
├── Unit/
│   ├── Domain/          # Domain Layer 單元測試
│   ├── Application/     # Application Layer 單元測試
│   └── Presentation/    # Presentation Layer 單元測試
├── Integration/         # 整合測試
│   ├── Repositories/
│   └── EndToEnd/
└── UI/                  # UI 測試
```

### Commit 訊息規範

採用 Conventional Commits:

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Type**:
- `feat`: 新功能
- `fix`: 錯誤修復
- `docs`: 文件更新
- `test`: 測試相關
- `refactor`: 重構
- `chore`: 雜項

**範例**:
```
feat(habit): add create habit feature

實作建立習慣功能
- 新增 CreateHabitCommand
- 實作 HabitRepository
- 新增 HabitFormView

Closes #123
```

### 程式碼風格

- 遵循 [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- 使用 SwiftLint 檢查程式碼風格
- 所有 public API 必須有文件註解
- 禁止硬編碼字串 (使用多語系系統)

### 依賴注入

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

---

## 技術棧

### 核心技術

- **語言**: Swift 5.9+
- **UI**: SwiftUI
- **架構**: Clean Architecture + CQRS
- **資料**: CoreData (主要資料) + UserDefaults (設定)
- **測試**: XCTest
- **依賴管理**: Swift Package Manager
- **平台**: iOS 16.0+

### 未來整合

- Swift Charts (統計圖表)
- WatchKit (Apple Watch)
- WidgetKit (iOS Widget)
- Siri Shortcuts
- iCloud Sync

---

## 核心功能

### 1. 習慣管理 (Habit)

- CRUD 操作
- 圖示、時長、獎勵設定
- 提醒功能
- 習慣分類

**Domain Model 範例**:
```swift
struct Habit: Entity {
    let id: UUID
    var name: String
    var iconId: String
    var defaultDuration: TimeInterval
    var starsReward: Int
    var reminders: [HabitReminder]
}
```

### 2. 番茄鐘 (CheckIn)

- 螢幕鎖定機制
- 計時與獎勵計算
- 延長與提前終止
- 星星獎勵系統
- 完成記錄追蹤

**CQRS Commands**:
- `StartPomodoroCommand`
- `CompletePomodoroCommand`
- `TerminatePomodoroCommand`
- `ExtendPomodoroCommand`

### 3. 統計分析 (Statistic)

- 多維度數據統計
- 視覺化圖表 (Swift Charts)
- 完成率與連續記錄
- 習慣趨勢分析

### 4. 獎勵系統 (Reward)

- 星星累積
- 自訂獎勵項目
- 兌換機制
- 成就系統

### 5. 行事曆 (Calendar)

- 月曆檢視
- GitHub 風格熱度圖
- 歷史記錄查詢
- 日期篩選

### 6. 設定 (Settings)

- 番茄鐘行為設定
- 延長時間與獎勵配置
- 多語系切換
- 通知管理
- 主題設定

### 多語系支援

完整支援以下語言:
- 🇹🇼 繁體中文 (zh-Hant)
- 🇨🇳 簡體中文 (zh-Hans)
- 🇺🇸 English (en)
- 🇯🇵 日本語 (ja)
- 🇰🇷 한국어 (ko)

所有使用者可見文字必須透過 `Localizable.strings` 處理。

---

## 實作指南

### 建議的實作順序

1. **Core 模組** (DDD 基礎、Extensions、Utilities)
2. **Habit Feature** (習慣是核心，其他功能依賴此)
3. **CheckIn Feature** (番茄鐘核心功能)
4. **Settings & Reward** (設定與獎勵系統)
5. **Home Feature** (首頁總覽)
6. **Statistics Feature** (統計分析)
7. **Calendar Feature** (行事曆與熱度圖)

### 開發路線圖

#### Phase 1 - MVP (v1.0)

- [ ] Core 模組建立
- [ ] Habit Feature 實作
- [ ] CheckIn Feature 實作
- [ ] Settings & Reward 實作
- [ ] Home Feature 實作
- [ ] 基礎 UI 與導航
- [ ] 多語系資源

#### Phase 2 - Enhancement (v1.1)

- [ ] Statistics Feature 實作
- [ ] Calendar Feature 實作
- [ ] 進階圖表
- [ ] Widget 支援
- [ ] Siri Shortcuts

#### Phase 3 - Watch Integration (v2.0)

- [ ] Apple Watch App
- [ ] 同步機制
- [ ] Watch Complications
- [ ] 獨立計時功能

#### Phase 4 - Advanced Features (v2.x)

- [ ] 習慣分類與標籤
- [ ] Focus Mode 整合
- [ ] iCloud 同步
- [ ] 社群功能 (可選)

### 環境需求

- **Xcode**: 15.0+
- **iOS**: 16.0+
- **Swift**: 5.9+
- **macOS**: Ventura 13.0+

### 安裝步驟

1. Clone 專案

```bash
git clone git@github.com:intervalrain/TidalHabits.git
cd TidalHabits
```

2. 開啟 Xcode 專案

```bash
open TidalHabits/TidalHabits.xcodeproj
```

3. 選擇目標裝置或模擬器

4. 建置並執行 (`⌘R`)

### 執行測試

```bash
# 在 Xcode 中執行所有測試
⌘U

# 或使用命令列
xcodebuild test -scheme TidalHabits -destination 'platform=iOS Simulator,name=iPhone 15'
```

---

## 專案優勢

### 架構優勢

✅ **高可維護性**: Clean Architecture 確保關注點分離
✅ **高可測試性**: TDD 流程，測試覆蓋率高
✅ **高可擴展性**: Feature-based 易於新增功能
✅ **低耦合**: 模組間依賴清晰，易於替換實作
✅ **技術獨立**: 易於替換技術實作 (如從 CoreData 換到 Realm)

### 開發優勢

✅ **清晰規範**: 完整的開發規範與流程文件
✅ **詳細規格**: 每個功能都有明確的規格文件
✅ **專業架構**: 符合 .NET Clean Architecture 慣例，易於理解
✅ **品質保證**: TDD + Code Review 雙重保障

### 團隊協作

✅ **模組獨立**: 多人可平行開發不同 Feature
✅ **文件完整**: 新成員易於上手
✅ **流程明確**: 定義規格 → 測試 → 實作 → Review → Commit

### 與 .NET Clean Architecture 的對應

| iOS/Swift | .NET |
|-----------|------|
| Feature/ | Modules/ or Features/ |
| Domain/Entities/ | Domain/Entities/ |
| Domain/ValueObjects/ | Domain/ValueObjects/ |
| Domain/Repositories/ | Application/Interfaces/ |
| Application/Commands/ | Application/Commands/ |
| Application/Queries/ | Application/Queries/ |
| Infrastructure/Repositories/ | Infrastructure/Repositories/ |
| Presentation/Views/ | WebUI/Pages/ or Controllers/ |
| Presentation/ViewModels/ | WebUI/ViewModels/ |

#### 差異說明

1. **UI Framework**:
   - .NET: ASP.NET Core MVC/Razor Pages/Blazor
   - iOS: SwiftUI

2. **依賴注入**:
   - .NET: Built-in DI Container
   - iOS: Protocol-oriented + Manual DI 或使用 Swinject

3. **資料持久化**:
   - .NET: Entity Framework Core
   - iOS: CoreData

4. **非同步模式**:
   - .NET: async/await (Task<T>)
   - iOS: async/await (Swift Concurrency)

---

## 專案成功指標

### 技術指標

- ✅ 架構設計完成
- ✅ 文件覆蓋率 100%
- ⏳ 測試覆蓋率 ≥ 75%
- ⏳ 編譯無警告
- ⏳ SwiftLint 通過

### 功能指標

- ⏳ MVP 功能完成
- ⏳ 多語系支援完整
- ⏳ 無障礙支援達標
- ⏳ 效能符合標準

### 品質指標

- ✅ 遵循 Clean Architecture
- ✅ 遵循 TDD 流程
- ⏳ Code Review 覆蓋率 100%
- ⏳ 文件與程式碼同步

---

## 下一步行動

### 立即行動

1. ✅ 閱讀 [快速開始指南](docs/dev/notes/getting-started.md)
2. ✅ 熟悉 [架構設計](docs/architecture.md)
3. ✅ 了解 [開發規範](docs/dev/notes/development-standards.md)

### 開始實作

4. 建立 Core 模組 (DDD 基礎)
5. 實作第一個 Feature: Habit
6. 遵循 TDD 流程: 規格 → 測試 → 實作

### 持續改進

7. Code Review 與重構
8. 補充文件與範例
9. 效能優化與測試

---

## 資源連結

### 專案文件

- [README](README.md) - 專案概述
- [架構設計](docs/architecture.md) - Clean Architecture 詳細說明
- [專案結構](docs/project-structure.md) - 目錄組織說明
- [開發規範](docs/dev/notes/development-standards.md) - TDD 流程與編碼規範
- [Git Flow](docs/dev/github/git-flow.md) - 版本控制策略
- [快速開始](docs/dev/notes/getting-started.md) - 開發指南
- [Milestone 規劃](docs/dev/milestones/phases/milestones.md) - 版本計畫
- [功能概述](docs/features/overview.md) - 功能規格總覽

### GitHub 連結

- **Repository**: [https://github.com/intervalrain/TidalHabits](https://github.com/intervalrain/TidalHabits)
- **Issues**: [https://github.com/intervalrain/TidalHabits/issues](https://github.com/intervalrain/TidalHabits/issues)
- **Milestones**: [https://github.com/intervalrain/TidalHabits/milestones](https://github.com/intervalrain/TidalHabits/milestones)
- **Projects**: [https://github.com/intervalrain/TidalHabits/projects](https://github.com/intervalrain/TidalHabits/projects)

### 外部資源

- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) - Uncle Bob's Clean Architecture
- [CQRS Pattern](https://martinfowler.com/bliki/CQRS.html) - Martin Fowler's CQRS
- [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/) - Swift 官方設計指南
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui) - Apple SwiftUI 文件

---

## 總結

TidalHabits 是一個採用專業軟體工程實踐的 iOS 應用程式專案。透過 Clean Architecture + CQRS 架構、TDD 開發流程、Feature-based 模組化組織，確保專案具備高可維護性、可測試性與可擴展性。

**專案已具備開始實作的所有基礎，可以立即開始開發!** 🚀

---

**TidalHabits - 潮汐般穩定的習慣養成** 🌊

_建立於 2025-10-28_
_License: MIT_
_Author: intervalrain_
