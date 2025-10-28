#!/bin/bash

# TidalHabits - GitHub Issues 建立腳本
# 根據 Milestone 規劃自動建立所有 Issues

REPO="intervalrain/TidalHabits"

echo "🚀 開始建立 TidalHabits GitHub Issues..."
echo "📦 Repository: $REPO"
echo ""

# =============================================================================
# Milestone: v0.2.0 - Core Foundation
# =============================================================================
echo "📋 建立 Milestone v0.2.0 的 Issues..."

# Core/Domain (必須)
gh issue create --repo $REPO \
  --title "建立 Entity 基礎協定" \
  --body "## 描述
建立 Entity 基礎協定，作為所有 Domain Entity 的基礎。

## 任務
- [ ] 定義 Entity protocol
- [ ] 實作 Equatable 與 Identifiable
- [ ] 加入 ID 屬性 (UUID)
- [ ] 撰寫單元測試

## 驗收標準
- Entity protocol 定義完整
- 測試覆蓋率 ≥ 90%
- 遵循 Swift API Design Guidelines

## 技術細節
\`\`\`swift
protocol Entity: Identifiable, Equatable {
    var id: UUID { get }
}
\`\`\`

## 參考文件
- [架構設計文件](https://github.com/intervalrain/TidalHabits/blob/main/docs/architecture.md)
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v0.2.0 - Core Foundation" \
  --label "feature,priority: high,module: core"

gh issue create --repo $REPO \
  --title "建立 Value Object 基礎協定" \
  --body "## 描述
建立 Value Object 基礎協定，作為所有 Value Object 的基礎。

## 任務
- [ ] 定義 ValueObject protocol
- [ ] 實作 Equatable
- [ ] 確保 immutability
- [ ] 撰寫單元測試

## 驗收標準
- ValueObject protocol 定義完整
- 測試覆蓋率 ≥ 90%
- 值物件不可變性

## 技術細節
\`\`\`swift
protocol ValueObject: Equatable {
    // Value objects are immutable
}
\`\`\`

## 參考文件
- [架構設計文件](https://github.com/intervalrain/TidalHabits/blob/main/docs/architecture.md)" \
  --milestone "v0.2.0 - Core Foundation" \
  --label "feature,priority: high,module: core"

gh issue create --repo $REPO \
  --title "建立 Aggregate Root 基礎" \
  --body "## 描述
建立 Aggregate Root 基礎協定與抽象類別。

## 任務
- [ ] 定義 AggregateRoot protocol
- [ ] 繼承 Entity
- [ ] 加入 Domain Events 支援
- [ ] 撰寫單元測試

## 驗收標準
- AggregateRoot 定義完整
- 支援 Domain Events
- 測試覆蓋率 ≥ 90%

## 依賴
- #10 (Entity 基礎協定)

## 參考文件
- [架構設計文件](https://github.com/intervalrain/TidalHabits/blob/main/docs/architecture.md)" \
  --milestone "v0.2.0 - Core Foundation" \
  --label "feature,priority: high,module: core"

gh issue create --repo $REPO \
  --title "建立 Domain Event 基礎" \
  --body "## 描述
建立 Domain Event 基礎設施。

## 任務
- [ ] 定義 DomainEvent protocol
- [ ] 實作 EventPublisher
- [ ] 實作 EventSubscriber
- [ ] 撰寫單元測試

## 驗收標準
- Domain Event 機制可運作
- 支援訂閱與發佈
- 測試覆蓋率 ≥ 90%

## 參考文件
- [架構設計文件](https://github.com/intervalrain/TidalHabits/blob/main/docs/architecture.md)" \
  --milestone "v0.2.0 - Core Foundation" \
  --label "feature,priority: medium,module: core"

gh issue create --repo $REPO \
  --title "建立 Result 型別" \
  --body "## 描述
建立自訂 Result 型別 (或使用 Swift 標準 Result)。

## 任務
- [ ] 定義 Result enum
- [ ] 加入 map, flatMap 等函數式方法
- [ ] 加入便利初始化方法
- [ ] 撰寫單元測試

## 驗收標準
- Result 型別可用
- 測試覆蓋率 ≥ 90%

## 技術細節
\`\`\`swift
typealias Result<T> = Swift.Result<T, Error>
// 或自訂實作
\`\`\`

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v0.2.0 - Core Foundation" \
  --label "feature,priority: high,module: core"

# Core/Extensions
gh issue create --repo $REPO \
  --title "Date Extensions (格式化、計算)" \
  --body "## 描述
實作 Date 擴充功能，提供常用的日期操作。

## 任務
- [ ] 格式化方法 (toDateString, toTimeString)
- [ ] 日期計算 (startOfDay, endOfDay, addDays)
- [ ] 日期比較 (isSameDay, isToday, isYesterday)
- [ ] 撰寫單元測試

## 驗收標準
- 所有方法正常運作
- 測試覆蓋率 ≥ 90%
- 處理時區問題

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v0.2.0 - Core Foundation" \
  --label "feature,priority: high,module: core"

gh issue create --repo $REPO \
  --title "String Extensions (驗證、本地化)" \
  --body "## 描述
實作 String 擴充功能。

## 任務
- [ ] 驗證方法 (isEmpty, isValidEmail)
- [ ] 本地化輔助方法
- [ ] 常用轉換 (trim, capitalized)
- [ ] 撰寫單元測試

## 驗收標準
- 所有方法正常運作
- 測試覆蓋率 ≥ 90%

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v0.2.0 - Core Foundation" \
  --label "feature,priority: medium,module: core"

gh issue create --repo $REPO \
  --title "TimeInterval Extensions" \
  --body "## 描述
實作 TimeInterval 擴充功能，用於時間計算。

## 任務
- [ ] 格式化方法 (toMinutesSeconds, toHoursMinutes)
- [ ] 便利初始化 (minutes, hours)
- [ ] 撰寫單元測試

## 驗收標準
- 所有方法正常運作
- 測試覆蓋率 ≥ 90%

## 參考文件
- [番茄鐘規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/checkin/spec.md)" \
  --milestone "v0.2.0 - Core Foundation" \
  --label "feature,priority: medium,module: core"

gh issue create --repo $REPO \
  --title "View Extensions (SwiftUI 常用)" \
  --body "## 描述
實作 SwiftUI View 擴充功能。

## 任務
- [ ] 常用 modifier 封裝
- [ ] 條件渲染輔助方法
- [ ] 動畫相關擴充
- [ ] 撰寫 UI 測試

## 驗收標準
- 所有方法可用
- UI 測試通過

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v0.2.0 - Core Foundation" \
  --label "feature,priority: low,module: core"

# Core/Utilities
gh issue create --repo $REPO \
  --title "Logger 實作" \
  --body "## 描述
實作 Logger 工具類別。

## 任務
- [ ] 實作 Logger protocol
- [ ] 支援不同 log level (debug, info, warning, error)
- [ ] 整合 os.log
- [ ] 撰寫單元測試

## 驗收標準
- Logger 可正常運作
- 支援多種 log level
- 測試覆蓋率 ≥ 90%

## 技術細節
\`\`\`swift
import OSLog

class Logger {
    static func debug(_ message: String)
    static func error(_ message: String, error: Error?)
}
\`\`\`

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v0.2.0 - Core Foundation" \
  --label "feature,priority: high,module: core"

gh issue create --repo $REPO \
  --title "Validators 實作" \
  --body "## 描述
實作常用的驗證工具。

## 任務
- [ ] 字串驗證 (非空、長度)
- [ ] 數值驗證 (範圍)
- [ ] 習慣名稱驗證
- [ ] 撰寫單元測試

## 驗收標準
- 所有驗證器正常運作
- 測試覆蓋率 ≥ 90%

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v0.2.0 - Core Foundation" \
  --label "feature,priority: medium,module: core"

gh issue create --repo $REPO \
  --title "DateFormatter 工具" \
  --body "## 描述
實作 DateFormatter 工具，提供常用格式。

## 任務
- [ ] 定義常用日期格式
- [ ] 實作格式化方法
- [ ] 支援多語系
- [ ] 撰寫單元測試

## 驗收標準
- 格式化正確
- 支援所有語言
- 測試覆蓋率 ≥ 90%

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v0.2.0 - Core Foundation" \
  --label "feature,priority: medium,module: core"

# Infrastructure
gh issue create --repo $REPO \
  --title "CoreData Stack 建立" \
  --body "## 描述
建立 CoreData Stack 基礎設施。

## 任務
- [ ] 建立 PersistenceController
- [ ] 設定 NSPersistentContainer
- [ ] 實作 Preview 用 in-memory store
- [ ] 撰寫基礎測試

## 驗收標準
- CoreData Stack 可運作
- 支援 Preview
- 測試通過

## 技術細節
\`\`\`swift
class PersistenceController {
    static let shared = PersistenceController()
    static let preview: PersistenceController
    let container: NSPersistentContainer
}
\`\`\`

## 參考文件
- [架構設計文件](https://github.com/intervalrain/TidalHabits/blob/main/docs/architecture.md)" \
  --milestone "v0.2.0 - Core Foundation" \
  --label "feature,priority: critical,module: infrastructure"

gh issue create --repo $REPO \
  --title "UserDefaults Wrapper" \
  --body "## 描述
建立 UserDefaults Wrapper，用於設定儲存。

## 任務
- [ ] 實作 SettingsStorage protocol
- [ ] 實作 UserDefaultsStorage
- [ ] 加入型別安全的 key
- [ ] 撰寫單元測試

## 驗收標準
- UserDefaults Wrapper 可用
- 型別安全
- 測試覆蓋率 ≥ 90%

## 參考文件
- [設定規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/settings/spec.md)" \
  --milestone "v0.2.0 - Core Foundation" \
  --label "feature,priority: high,module: infrastructure"

gh issue create --repo $REPO \
  --title "基礎 Repository Protocol" \
  --body "## 描述
建立基礎 Repository Protocol。

## 任務
- [ ] 定義 Repository protocol
- [ ] 定義 CRUD 方法
- [ ] 使用 async/await
- [ ] 撰寫文件

## 驗收標準
- Protocol 定義完整
- 符合 Clean Architecture

## 技術細節
\`\`\`swift
protocol Repository {
    associatedtype T: Entity
    func getAll() async throws -> [T]
    func getById(_ id: UUID) async throws -> T?
    func save(_ entity: T) async throws
    func delete(_ id: UUID) async throws
}
\`\`\`

## 參考文件
- [架構設計文件](https://github.com/intervalrain/TidalHabits/blob/main/docs/architecture.md)" \
  --milestone "v0.2.0 - Core Foundation" \
  --label "feature,priority: high,module: infrastructure"

# Shared
gh issue create --repo $REPO \
  --title "主題系統 (Colors, Fonts, Spacing)" \
  --body "## 描述
建立主題系統，統一 UI 風格。

## 任務
- [ ] 定義 Color Palette (AppColors)
- [ ] 定義 Typography (AppFonts)
- [ ] 定義 Spacing 規則
- [ ] 支援 Dark Mode

## 驗收標準
- 主題系統可用
- 支援深色模式
- 顏色符合設計規範

## 技術細節
\`\`\`swift
enum AppColors {
    static let primary = Color(\"Primary\")
    static let background = Color(\"Background\")
}
\`\`\`

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v0.2.0 - Core Foundation" \
  --label "feature,priority: high,module: shared"

gh issue create --repo $REPO \
  --title "Tab Bar 導航框架" \
  --body "## 描述
建立 Tab Bar 導航基礎框架。

## 任務
- [ ] 實作 TabBarView
- [ ] 定義 Tab Item enum
- [ ] 實作基本導航邏輯
- [ ] 撰寫 UI 測試

## 驗收標準
- Tab Bar 可正常切換
- UI 測試通過

## 參考文件
- [首頁規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/home/spec.md)" \
  --milestone "v0.2.0 - Core Foundation" \
  --label "feature,priority: high,module: shared"

gh issue create --repo $REPO \
  --title "基礎 UI 元件 (Button, Card)" \
  --body "## 描述
建立可重用的基礎 UI 元件。

## 任務
- [ ] 實作 PrimaryButton
- [ ] 實作 SecondaryButton
- [ ] 實作 Card Component
- [ ] 撰寫 Preview

## 驗收標準
- 所有元件可用
- Preview 正常顯示
- 支援深色模式

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v0.2.0 - Core Foundation" \
  --label "feature,priority: medium,module: shared"

# 測試
gh issue create --repo $REPO \
  --title "Core 模組單元測試" \
  --body "## 描述
為 Core 模組撰寫完整的單元測試。

## 任務
- [ ] Entity 測試
- [ ] Value Object 測試
- [ ] Aggregate Root 測試
- [ ] Domain Event 測試

## 驗收標準
- 測試覆蓋率 ≥ 90%
- 所有測試通過

## 依賴
- #10, #11, #12, #13, #14

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v0.2.0 - Core Foundation" \
  --label "test,priority: high,module: core"

gh issue create --repo $REPO \
  --title "Extensions 測試" \
  --body "## 描述
為所有 Extensions 撰寫單元測試。

## 任務
- [ ] Date Extensions 測試
- [ ] String Extensions 測試
- [ ] TimeInterval Extensions 測試
- [ ] View Extensions 測試

## 驗收標準
- 測試覆蓋率 ≥ 90%
- 所有測試通過

## 依賴
- #15, #16, #17, #18

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v0.2.0 - Core Foundation" \
  --label "test,priority: high,module: core"

gh issue create --repo $REPO \
  --title "Utilities 測試" \
  --body "## 描述
為 Utilities 撰寫單元測試。

## 任務
- [ ] Logger 測試
- [ ] Validators 測試
- [ ] DateFormatter 測試

## 驗收標準
- 測試覆蓋率 ≥ 90%
- 所有測試通過

## 依賴
- #19, #20, #21

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v0.2.0 - Core Foundation" \
  --label "test,priority: high,module: core"

echo "✅ Milestone v0.2.0 的 Issues 建立完成!"
echo ""

# =============================================================================
# Milestone: v0.3.0 - Habit Feature
# =============================================================================
echo "📋 建立 Milestone v0.3.0 的 Issues..."

# Domain Layer
gh issue create --repo $REPO \
  --title "Habit Entity 實作與測試" \
  --body "## 描述
實作 Habit Entity (TDD 方式)。

## 任務
- [ ] 先撰寫測試
- [ ] 定義 Habit struct
- [ ] 實作 Entity protocol
- [ ] 加入業務邏輯方法

## 驗收標準
- 測試先於實作
- 測試覆蓋率 ≥ 95%
- 遵循 TDD 流程

## 技術細節
\`\`\`swift
struct Habit: Entity {
    let id: UUID
    var name: String
    var iconId: String
    var defaultDuration: TimeInterval
    var starsReward: Int
    var reminders: [HabitReminder]
}
\`\`\`

## 參考文件
- [習慣管理規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/habit/spec.md)" \
  --milestone "v0.3.0 - Habit Feature" \
  --label "feature,priority: critical,module: habit"

gh issue create --repo $REPO \
  --title "HabitReminder Value Object 實作與測試" \
  --body "## 描述
實作 HabitReminder Value Object (TDD 方式)。

## 任務
- [ ] 先撰寫測試
- [ ] 定義 HabitReminder struct
- [ ] 實作 ValueObject protocol
- [ ] 實作驗證邏輯

## 驗收標準
- 測試先於實作
- 測試覆蓋率 ≥ 95%
- 值物件不可變

## 參考文件
- [習慣管理規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/habit/spec.md)" \
  --milestone "v0.3.0 - Habit Feature" \
  --label "feature,priority: high,module: habit"

gh issue create --repo $REPO \
  --title "IHabitRepository Protocol 定義" \
  --body "## 描述
定義 Habit Repository 介面。

## 任務
- [ ] 定義 IHabitRepository protocol
- [ ] 定義 CRUD 方法
- [ ] 定義查詢方法
- [ ] 撰寫文件

## 驗收標準
- Protocol 定義完整
- 方法簽名正確

## 技術細節
\`\`\`swift
protocol IHabitRepository {
    func getAll() async throws -> [Habit]
    func getById(_ id: UUID) async throws -> Habit?
    func save(_ habit: Habit) async throws
    func delete(_ id: UUID) async throws
}
\`\`\`

## 參考文件
- [習慣管理規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/habit/spec.md)" \
  --milestone "v0.3.0 - Habit Feature" \
  --label "feature,priority: high,module: habit"

gh issue create --repo $REPO \
  --title "HabitError 定義" \
  --body "## 描述
定義 Habit 相關錯誤類型。

## 任務
- [ ] 定義 HabitError enum
- [ ] 實作 LocalizedError
- [ ] 定義錯誤訊息

## 驗收標準
- 錯誤類型完整
- 錯誤訊息清晰

## 技術細節
\`\`\`swift
enum HabitError: LocalizedError {
    case notFound
    case invalidName
    case saveFailed(Error)
}
\`\`\`

## 參考文件
- [習慣管理規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/habit/spec.md)" \
  --milestone "v0.3.0 - Habit Feature" \
  --label "feature,priority: medium,module: habit"

# Infrastructure Layer
gh issue create --repo $REPO \
  --title "CoreData Habit Schema 設計" \
  --body "## 描述
設計 CoreData Habit Schema。

## 任務
- [ ] 建立 HabitEntity
- [ ] 定義屬性與關聯
- [ ] 設定驗證規則
- [ ] 建立 Migration 計畫

## 驗收標準
- Schema 設計完整
- 符合正規化原則

## 參考文件
- [習慣管理規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/habit/spec.md)" \
  --milestone "v0.3.0 - Habit Feature" \
  --label "feature,priority: high,module: habit"

gh issue create --repo $REPO \
  --title "HabitRepository 實作與測試" \
  --body "## 描述
實作 HabitRepository (TDD 方式)。

## 任務
- [ ] 先撰寫整合測試
- [ ] 實作 IHabitRepository
- [ ] 實作 CRUD 方法
- [ ] 錯誤處理

## 驗收標準
- 測試先於實作
- 測試覆蓋率 ≥ 90%
- 所有測試通過

## 依賴
- #42 (IHabitRepository Protocol)
- #44 (CoreData Schema)

## 參考文件
- [習慣管理規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/habit/spec.md)" \
  --milestone "v0.3.0 - Habit Feature" \
  --label "feature,priority: critical,module: habit"

gh issue create --repo $REPO \
  --title "CoreDataHabitDataSource 實作" \
  --body "## 描述
實作 CoreData Habit DataSource。

## 任務
- [ ] 實作 DataSource
- [ ] Domain ↔ CoreData 轉換
- [ ] 查詢優化
- [ ] 撰寫測試

## 驗收標準
- DataSource 可運作
- 轉換正確
- 測試通過

## 依賴
- #44 (CoreData Schema)

## 參考文件
- [架構設計文件](https://github.com/intervalrain/TidalHabits/blob/main/docs/architecture.md)" \
  --milestone "v0.3.0 - Habit Feature" \
  --label "feature,priority: high,module: habit"

# Application Layer (CQRS) - Commands
gh issue create --repo $REPO \
  --title "CreateHabitCommand & Handler 實作與測試" \
  --body "## 描述
實作建立習慣的 Command 與 Handler (TDD 方式)。

## 任務
- [ ] 先撰寫測試
- [ ] 定義 CreateHabitCommand
- [ ] 實作 CreateHabitCommandHandler
- [ ] 實作業務邏輯驗證

## 驗收標準
- 測試先於實作
- 測試覆蓋率 ≥ 90%
- 業務規則正確

## 技術細節
\`\`\`swift
struct CreateHabitCommand {
    let name: String
    let iconId: String
    let defaultDuration: TimeInterval
    let starsReward: Int
}
\`\`\`

## 依賴
- #40 (Habit Entity)
- #45 (HabitRepository)

## 參考文件
- [習慣管理規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/habit/spec.md)" \
  --milestone "v0.3.0 - Habit Feature" \
  --label "feature,priority: critical,module: habit"

gh issue create --repo $REPO \
  --title "UpdateHabitCommand & Handler 實作與測試" \
  --body "## 描述
實作更新習慣的 Command 與 Handler (TDD 方式)。

## 任務
- [ ] 先撰寫測試
- [ ] 定義 UpdateHabitCommand
- [ ] 實作 UpdateHabitCommandHandler
- [ ] 實作業務邏輯驗證

## 驗收標準
- 測試先於實作
- 測試覆蓋率 ≥ 90%
- 更新邏輯正確

## 依賴
- #40 (Habit Entity)
- #45 (HabitRepository)

## 參考文件
- [習慣管理規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/habit/spec.md)" \
  --milestone "v0.3.0 - Habit Feature" \
  --label "feature,priority: high,module: habit"

gh issue create --repo $REPO \
  --title "DeleteHabitCommand & Handler 實作與測試" \
  --body "## 描述
實作刪除習慣的 Command 與 Handler (TDD 方式)。

## 任務
- [ ] 先撰寫測試
- [ ] 定義 DeleteHabitCommand
- [ ] 實作 DeleteHabitCommandHandler
- [ ] 處理級聯刪除

## 驗收標準
- 測試先於實作
- 測試覆蓋率 ≥ 90%
- 級聯刪除正確

## 依賴
- #45 (HabitRepository)

## 參考文件
- [習慣管理規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/habit/spec.md)" \
  --milestone "v0.3.0 - Habit Feature" \
  --label "feature,priority: high,module: habit"

# Application Layer (CQRS) - Queries
gh issue create --repo $REPO \
  --title "GetAllHabitsQuery & Handler 實作與測試" \
  --body "## 描述
實作取得所有習慣的 Query 與 Handler (TDD 方式)。

## 任務
- [ ] 先撰寫測試
- [ ] 定義 GetAllHabitsQuery
- [ ] 實作 GetAllHabitsQueryHandler
- [ ] 實作排序與篩選

## 驗收標準
- 測試先於實作
- 測試覆蓋率 ≥ 90%
- 查詢效能良好

## 依賴
- #45 (HabitRepository)
- #52 (HabitDTO)

## 參考文件
- [習慣管理規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/habit/spec.md)" \
  --milestone "v0.3.0 - Habit Feature" \
  --label "feature,priority: critical,module: habit"

gh issue create --repo $REPO \
  --title "GetHabitByIdQuery & Handler 實作與測試" \
  --body "## 描述
實作取得單一習慣的 Query 與 Handler (TDD 方式)。

## 任務
- [ ] 先撰寫測試
- [ ] 定義 GetHabitByIdQuery
- [ ] 實作 GetHabitByIdQueryHandler
- [ ] 錯誤處理

## 驗收標準
- 測試先於實作
- 測試覆蓋率 ≥ 90%
- 錯誤處理正確

## 依賴
- #45 (HabitRepository)
- #52 (HabitDTO)

## 參考文件
- [習慣管理規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/habit/spec.md)" \
  --milestone "v0.3.0 - Habit Feature" \
  --label "feature,priority: high,module: habit"

gh issue create --repo $REPO \
  --title "HabitDTO 定義" \
  --body "## 描述
定義 Habit 資料傳輸物件。

## 任務
- [ ] 定義 HabitDTO struct
- [ ] 實作 Domain ↔ DTO 轉換
- [ ] 確保資料最小化

## 驗收標準
- DTO 定義完整
- 轉換方法正確

## 技術細節
\`\`\`swift
struct HabitDTO: Identifiable, Codable {
    let id: UUID
    let name: String
    let iconId: String
    let defaultDuration: TimeInterval
    let starsReward: Int
}
\`\`\`

## 參考文件
- [習慣管理規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/habit/spec.md)" \
  --milestone "v0.3.0 - Habit Feature" \
  --label "feature,priority: high,module: habit"

# Presentation Layer
gh issue create --repo $REPO \
  --title "HabitListViewModel 實作與測試" \
  --body "## 描述
實作習慣列表 ViewModel (TDD 方式)。

## 任務
- [ ] 先撰寫測試
- [ ] 實作 HabitListViewModel
- [ ] 整合 Commands 與 Queries
- [ ] 實作狀態管理

## 驗收標準
- 測試先於實作
- 測試覆蓋率 ≥ 80%
- 狀態管理正確

## 依賴
- #47, #48, #49, #50, #51

## 參考文件
- [習慣管理規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/habit/spec.md)" \
  --milestone "v0.3.0 - Habit Feature" \
  --label "feature,priority: critical,module: habit"

gh issue create --repo $REPO \
  --title "HabitListView UI 實作" \
  --body "## 描述
實作習慣列表 UI。

## 任務
- [ ] 實作 HabitListView
- [ ] 整合 HabitListViewModel
- [ ] 實作下拉刷新
- [ ] 實作空狀態

## 驗收標準
- UI 符合設計
- 互動流暢
- 支援深色模式

## 依賴
- #53 (HabitListViewModel)

## 參考文件
- [習慣管理規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/habit/spec.md)" \
  --milestone "v0.3.0 - Habit Feature" \
  --label "feature,priority: high,module: habit"

gh issue create --repo $REPO \
  --title "HabitFormView UI 實作" \
  --body "## 描述
實作習慣表單 UI (新增/編輯)。

## 任務
- [ ] 實作 HabitFormView
- [ ] 表單驗證
- [ ] 圖示選擇
- [ ] 錯誤顯示

## 驗收標準
- 表單驗證正確
- UI 符合設計
- 錯誤提示清晰

## 依賴
- #53 (HabitListViewModel)

## 參考文件
- [習慣管理規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/habit/spec.md)" \
  --milestone "v0.3.0 - Habit Feature" \
  --label "feature,priority: high,module: habit"

gh issue create --repo $REPO \
  --title "HabitDetailView UI 實作" \
  --body "## 描述
實作習慣詳情 UI。

## 任務
- [ ] 實作 HabitDetailView
- [ ] 顯示習慣資訊
- [ ] 編輯/刪除按鈕
- [ ] 統計資訊顯示

## 驗收標準
- UI 符合設計
- 資訊完整顯示

## 依賴
- #53 (HabitListViewModel)

## 參考文件
- [習慣管理規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/habit/spec.md)" \
  --milestone "v0.3.0 - Habit Feature" \
  --label "feature,priority: medium,module: habit"

gh issue create --repo $REPO \
  --title "HabitReminderView UI 實作" \
  --body "## 描述
實作習慣提醒設定 UI。

## 任務
- [ ] 實作 HabitReminderView
- [ ] 時間選擇器
- [ ] 重複設定
- [ ] 權限請求

## 驗收標準
- UI 符合設計
- 提醒功能正常

## 依賴
- #53 (HabitListViewModel)

## 參考文件
- [習慣管理規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/habit/spec.md)" \
  --milestone "v0.3.0 - Habit Feature" \
  --label "feature,priority: low,module: habit"

gh issue create --repo $REPO \
  --title "圖示選擇器 UI 實作" \
  --body "## 描述
實作習慣圖示選擇器。

## 任務
- [ ] 實作 IconPickerView
- [ ] 圖示網格顯示
- [ ] 選擇狀態
- [ ] 搜尋功能 (可選)

## 驗收標準
- 圖示正確顯示
- 選擇功能正常

## 參考文件
- [習慣管理規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/habit/spec.md)" \
  --milestone "v0.3.0 - Habit Feature" \
  --label "feature,priority: medium,module: habit"

# 整合測試
gh issue create --repo $REPO \
  --title "Habit CRUD 整合測試" \
  --body "## 描述
撰寫 Habit CRUD 的完整整合測試。

## 任務
- [ ] 建立、讀取、更新、刪除測試
- [ ] Repository 層測試
- [ ] End-to-End 測試

## 驗收標準
- 整合測試通過
- 覆蓋主要流程

## 依賴
- #40-#58 (所有 Habit 相關 Issues)

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v0.3.0 - Habit Feature" \
  --label "test,priority: high,module: habit"

gh issue create --repo $REPO \
  --title "UI Flow 測試" \
  --body "## 描述
撰寫 Habit UI Flow 測試。

## 任務
- [ ] 列表顯示測試
- [ ] 新增流程測試
- [ ] 編輯流程測試
- [ ] 刪除流程測試

## 驗收標準
- UI 測試通過
- 覆蓋主要使用者流程

## 依賴
- #54-#58 (UI Issues)

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v0.3.0 - Habit Feature" \
  --label "test,priority: medium,module: habit"

# 文件
gh issue create --repo $REPO \
  --title "更新 README (展示第一個完整 Feature)" \
  --body "## 描述
更新 README，展示第一個完整實作的 Feature。

## 任務
- [ ] 更新專案進度
- [ ] 加入螢幕截圖
- [ ] 更新功能清單
- [ ] 更新開發進度

## 驗收標準
- README 資訊完整
- 螢幕截圖清晰

## 依賴
- #40-#60 (整個 Habit Feature)

## 參考文件
- [習慣管理規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/habit/spec.md)" \
  --milestone "v0.3.0 - Habit Feature" \
  --label "docs,priority: low"

echo "✅ Milestone v0.3.0 的 Issues 建立完成!"
echo ""

echo "🎉 所有 Issues 建立完成!"
echo ""
echo "📊 統計:"
echo "  - v0.2.0 Core Foundation: 21 Issues"
echo "  - v0.3.0 Habit Feature: 22 Issues"
echo "  - 總計: 43 Issues"
echo ""
echo "📝 下一步:"
echo "1. 前往 GitHub 檢視 Issues: https://github.com/$REPO/issues"
echo "2. 前往 GitHub 檢視 Milestones: https://github.com/$REPO/milestones"
echo "3. 開始依照 Milestone 順序開發"
echo ""
echo "🚀 Happy Coding!"
