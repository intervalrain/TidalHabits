# TidalHabits 快速開始指南

## 專案現況

專案結構與文件已建立完成,目前處於 **架構設計階段**,尚未開始實作程式碼。

### 已完成
✅ 專案目錄結構建立
✅ 架構設計文件
✅ 開發規範文件
✅ 功能規格文件
✅ README 與專案說明

### 待完成
- [ ] 實作各 Feature 模組
- [ ] 撰寫測試
- [ ] UI 實作
- [ ] 多語系資源

## 文件導航

### 必讀文件

1. **[README.md](../README.md)**
   專案概述、技術棧、安裝與執行指南

2. **[architecture.md](./architecture.md)**
   Clean Architecture + CQRS 架構說明、分層規則、資料流

3. **[development-standards.md](./development-standards.md)**
   開發流程、編碼規範、Git 規範、測試規範

4. **[project-structure.md](./project-structure.md)**
   專案目錄結構說明、檔案命名慣例、模組組織

### 功能規格

5. **[features/overview.md](./features/overview.md)**
   應用程式功能總覽、核心概念、使用者流程

6. **[features/habit/spec.md](./features/habit/spec.md)**
   習慣管理功能詳細規格

7. **[features/checkin/spec.md](./features/checkin/spec.md)**
   番茄鐘功能詳細規格

8. **[features/settings/spec.md](./features/settings/spec.md)**
   設定與獎勵功能規格

9. **[features/statistics/spec.md](./features/statistics/spec.md)**
   統計分析功能規格

10. **[features/calendar/spec.md](./features/calendar/spec.md)**
    行事曆功能規格

11. **[features/home/spec.md](./features/home/spec.md)**
    首頁功能規格

## 開發流程

本專案採用 **TDD (Test-Driven Development)** 流程:

```
1. 定義規格 → 2. 撰寫測試 → 3. 實作 → 4. Review → 5. Commit
                                              ↓ (Failed)
                                         返回步驟 1
```

詳細說明請參閱 [development-standards.md](./development-standards.md#開發流程-development-workflow)

## 建議的實作順序

### Phase 1: 核心基礎 (MVP)

#### Step 1: 建立 Core 模組
```
1.1 Core/Domain/ - DDD 基礎協定與型別
1.2 Core/Extensions/ - 常用擴充
1.3 Core/Utilities/ - 工具類別
```

#### Step 2: 實作 Habit Feature
```
2.1 Habit/Domain/ - Habit Entity, Repository Interface
2.2 Habit/Infrastructure/ - CoreData Schema, Repository 實作
2.3 Habit/Application/ - CQRS Commands & Queries
2.4 Habit/Presentation/ - UI Views & ViewModels
```

**為什麼先實作 Habit?**
- 習慣是核心資料模型
- 其他功能 (番茄鐘、統計) 都依賴習慣
- 相對簡單,適合建立開發範本

#### Step 3: 實作 CheckIn (Pomodoro) Feature
```
3.1 CheckIn/Domain/ - PomodoroSession Entity, Timer Service
3.2 CheckIn/Infrastructure/ - Repository, System Services
3.3 CheckIn/Application/ - Commands & Queries
3.4 CheckIn/Presentation/ - Pomodoro UI
```

#### Step 4: 實作 Settings & Reward Feature
```
4.1 Settings/Domain/ - AppSettings, Reward Entity
4.2 Settings/Infrastructure/ - UserDefaults, CoreData
4.3 Settings/Application/ - Commands & Queries
4.4 Settings/Presentation/ - Settings UI
```

#### Step 5: 實作 Home Feature
```
5.1 Home/Domain/ - DailyOverview 聚合
5.2 Home/Application/ - Queries
5.3 Home/Presentation/ - Home UI
```

### Phase 2: 進階功能

#### Step 6: 實作 Statistics Feature
```
6.1 Statistics/Domain/ - 統計計算邏輯
6.2 Statistics/Application/ - 複雜查詢
6.3 Statistics/Presentation/ - 圖表 UI (Swift Charts)
```

#### Step 7: 實作 Calendar Feature
```
7.1 Calendar/Domain/ - Calendar 聚合
7.2 Calendar/Application/ - 日期範圍查詢
7.3 Calendar/Presentation/ - 月曆與熱度圖 UI
```

#### Step 8: 整合與優化
```
8.1 多語系資源完成
8.2 Navigation 整合
8.3 Theme 完善
8.4 效能優化
8.5 無障礙支援
```

### Phase 3: 擴充功能

#### Step 9: Widget & Shortcuts
```
9.1 Today Widget
9.2 Siri Shortcuts
9.3 App Clips (可選)
```

#### Step 10: Apple Watch
```
10.1 Watch App 實作
10.2 同步機制
10.3 Complications
```

## 第一個 Feature 實作範例: Habit

### 1. 定義規格
閱讀 [features/habit/spec.md](./features/habit/spec.md)

### 2. 撰寫測試

#### 2.1 Domain Tests
```swift
// test/Unit/Domain/Habit/HabitTests.swift

import XCTest
@testable import TidalHabits

final class HabitTests: XCTestCase {
    func testCreateHabit_WhenValidInput_ShouldCreateHabit() {
        // Given
        let name = "運動"
        let iconId = "sport"
        let duration: TimeInterval = 3600
        let stars = 30

        // When
        let habit = Habit(
            id: UUID(),
            name: name,
            iconId: iconId,
            defaultDuration: duration,
            starsReward: stars,
            createdAt: Date(),
            updatedAt: Date(),
            isActive: true,
            sortOrder: 0,
            reminders: []
        )

        // Then
        XCTAssertEqual(habit.name, name)
        XCTAssertEqual(habit.iconId, iconId)
        XCTAssertEqual(habit.defaultDuration, duration)
        XCTAssertEqual(habit.starsReward, stars)
        XCTAssertTrue(habit.isActive)
    }

    func testCreateHabit_WhenInvalidName_ShouldThrowError() {
        // Test validation logic
    }
}
```

#### 2.2 Application Tests
```swift
// test/Unit/Application/Habit/CreateHabitCommandHandlerTests.swift

final class CreateHabitCommandHandlerTests: XCTestCase {
    var sut: CreateHabitCommandHandler!
    var mockRepository: MockHabitRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockHabitRepository()
        sut = CreateHabitCommandHandler(repository: mockRepository)
    }

    func testHandle_WhenValidCommand_ShouldCreateHabit() async throws {
        // Given
        let command = CreateHabitCommand(
            name: "運動",
            iconId: "sport",
            defaultDuration: 3600,
            starsReward: 30
        )

        // When
        let habitId = try await sut.handle(command)

        // Then
        XCTAssertNotNil(habitId)
        XCTAssertTrue(mockRepository.createCalled)
    }
}
```

### 3. 實作

#### 3.1 Domain Layer
```swift
// src/Feature/Habit/Domain/Entities/Habit.swift

struct Habit {
    let id: UUID
    var name: String
    var iconId: String
    var defaultDuration: TimeInterval
    var starsReward: Int
    let createdAt: Date
    var updatedAt: Date
    var isActive: Bool
    var sortOrder: Int
    var reminders: [HabitReminder]

    init(
        id: UUID = UUID(),
        name: String,
        iconId: String,
        defaultDuration: TimeInterval,
        starsReward: Int,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        isActive: Bool = true,
        sortOrder: Int = 0,
        reminders: [HabitReminder] = []
    ) throws {
        guard !name.isEmpty && name.count <= 50 else {
            throw HabitError.invalidName(name)
        }
        guard defaultDuration >= 300 && defaultDuration <= 28800 else {
            throw HabitError.invalidDuration(defaultDuration)
        }
        guard starsReward >= 1 && starsReward <= 999 else {
            throw HabitError.invalidStarsReward(starsReward)
        }

        self.id = id
        self.name = name
        self.iconId = iconId
        self.defaultDuration = defaultDuration
        self.starsReward = starsReward
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.isActive = isActive
        self.sortOrder = sortOrder
        self.reminders = reminders
    }
}
```

繼續實作其他層級...

### 4. Code Review

檢查:
- [ ] 架構符合 Clean Architecture
- [ ] 測試覆蓋率達標
- [ ] 命名清晰
- [ ] 錯誤處理完整
- [ ] 文件註解完整

### 5. Commit

```bash
git add .
git commit -m "feat(habit): implement habit management feature

- Add Habit entity with validation
- Implement HabitRepository with CoreData
- Add CreateHabitCommand and handler
- Implement HabitListView and ViewModel
- Add unit tests with 90% coverage

Closes #1"
```

## 開發環境設定

### 必要工具
- Xcode 15.0+
- Swift 5.9+
- Git

### 可選工具
- SwiftLint (程式碼風格檢查)
- SwiftFormat (自動格式化)

### 安裝 SwiftLint (可選)
```bash
brew install swiftlint
```

建立 `.swiftlint.yml`:
```yaml
disabled_rules:
  - trailing_whitespace
opt_in_rules:
  - empty_count
included:
  - src
excluded:
  - TidalHabits/TidalHabits.xcodeproj
line_length: 120
```

## Git 分支策略

```
main (穩定版本)
  ↑
develop (開發主分支)
  ↑
feature/habit-management (功能分支)
feature/pomodoro-timer
feature/statistics
```

### 建立 feature branch
```bash
git checkout -b feature/habit-management
```

### 合併回 develop
```bash
git checkout develop
git merge --no-ff feature/habit-management
```

## 常見問題

### Q: 為什麼採用 Feature-based 而非 Layer-based?
A: Feature-based 提供更好的模組化,每個功能獨立開發與測試,適合團隊協作且易於維護。

### Q: CQRS 是否過於複雜?
A: 對於這個規模的 App,CQRS 提供清晰的讀寫分離,便於優化與擴展。範例程式碼會示範簡化的實作方式。

### Q: 為什麼不直接在 ViewModel 呼叫 Repository?
A: Application Layer (Command/Query Handler) 提供額外的業務邏輯層,便於測試與重用。ViewModel 只負責 UI 邏輯。

### Q: 是否需要嚴格遵循所有規範?
A: 核心原則(分層、依賴方向)必須遵循,細節(如命名)可依團隊習慣調整,但需保持一致性。

## 資源與參考

### Clean Architecture
- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [iOS Clean Architecture Example](https://github.com/kudoleh/iOS-Clean-Architecture-MVVM)

### CQRS
- [CQRS Pattern](https://martinfowler.com/bliki/CQRS.html)
- [CQRS in Practice](https://docs.microsoft.com/en-us/azure/architecture/patterns/cqrs)

### SwiftUI
- [Apple SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [Swift Charts](https://developer.apple.com/documentation/charts)

### Testing
- [iOS Unit Testing Guide](https://developer.apple.com/documentation/xctest)
- [TDD by Example](https://www.oreilly.com/library/view/test-driven-development/0321146530/)

## 下一步行動

1. **熟悉架構**: 閱讀 architecture.md 與 development-standards.md
2. **選擇 Feature**: 建議從 Habit 開始
3. **建立測試**: 遵循 TDD 流程,先寫測試
4. **實作功能**: 由內而外 (Domain → Infrastructure → Application → Presentation)
5. **Code Review**: 確保符合規範
6. **Commit**: 使用 Conventional Commits 格式

## 需要協助?

- 查看 [docs/features/](./features/) 中的詳細規格
- 參考 [development-standards.md](./development-standards.md) 中的範例
- 建立 Issue 討論設計決策
- 在 Pull Request 中詢問問題

---

**開始建立你的第一個習慣吧!** 🚀
