# 習慣管理功能規格

## 概述

習慣管理模組負責使用者習慣的建立、編輯、刪除與查詢功能。習慣是應用程式的核心概念,作為「常用項目」供使用者快速啟動番茄鐘。

## User Stories

### US-H001: 建立習慣
**身份**: 使用者
**需求**: 我想要建立一個新的習慣
**目的**: 以便追蹤我的日常活動並獲得獎勵

**Acceptance Criteria**:
- [ ] 使用者可以輸入習慣名稱 (1-50 字元)
- [ ] 使用者可以選擇習慣圖示 (從預設圖示庫)
- [ ] 使用者可以設定預設時長 (5-480 分鐘)
- [ ] 使用者可以設定完成獎勵星星數 (1-999)
- [ ] 系統驗證輸入有效性
- [ ] 習慣成功建立後顯示確認訊息
- [ ] 新習慣出現在習慣列表

### US-H002: 檢視習慣列表
**身份**: 使用者
**需求**: 我想要查看我所有的習慣
**目的**: 以便管理與選擇要執行的習慣

**Acceptance Criteria**:
- [ ] 顯示所有習慣的清單
- [ ] 每個習慣顯示: 圖示、名稱、預設時長、獎勵星星數
- [ ] 習慣可依最近使用/名稱/建立時間排序
- [ ] 支援搜尋功能
- [ ] 空狀態顯示引導訊息

### US-H003: 編輯習慣
**身份**: 使用者
**需求**: 我想要修改現有習慣的資訊
**目的**: 以便調整習慣設定符合我的需求

**Acceptance Criteria**:
- [ ] 使用者可以點擊習慣進入編輯畫面
- [ ] 可修改名稱、圖示、時長、星星數
- [ ] 修改後即時生效
- [ ] 歷史記錄不受影響 (保持原設定)
- [ ] 顯示儲存確認

### US-H004: 刪除習慣
**身份**: 使用者
**需求**: 我想要刪除不再需要的習慣
**目的**: 以便保持習慣列表的整潔

**Acceptance Criteria**:
- [ ] 使用者可以滑動刪除或長按選單刪除
- [ ] 刪除前顯示確認對話框
- [ ] 刪除後習慣從列表移除
- [ ] 歷史記錄保留但標記為已刪除習慣
- [ ] 可選: 提供「還原」功能 (7 天內)

### US-H005: 快速啟動番茄鐘
**身份**: 使用者
**需求**: 我想要從習慣列表直接啟動番茄鐘
**目的**: 以便快速開始專注時段

**Acceptance Criteria**:
- [ ] 每個習慣旁有「開始」按鈕
- [ ] 點擊後直接啟動番茄鐘 (使用預設時長)
- [ ] 切換到番茄鐘畫面
- [ ] 開始計時並鎖定螢幕

### US-H006: 設定習慣提醒
**身份**: 使用者
**需求**: 我想要為習慣設定提醒時間
**目的**: 以便在特定時間收到執行習慣的通知

**Acceptance Criteria**:
- [ ] 可為每個習慣設定多個提醒時間
- [ ] 可選擇重複規則 (每日/特定星期)
- [ ] 提醒時發送本地通知
- [ ] 可從通知直接啟動番茄鐘
- [ ] 可啟用/停用提醒

## Domain Model

### Habit Entity

```swift
/// 習慣實體
struct Habit {
    /// 唯一識別碼
    let id: UUID

    /// 習慣名稱 (1-50 字元)
    var name: String

    /// 圖示識別碼
    var iconId: String

    /// 預設時長 (秒)
    var defaultDuration: TimeInterval

    /// 完成獎勵星星數 (1-999)
    var starsReward: Int

    /// 建立時間
    let createdAt: Date

    /// 最後更新時間
    var updatedAt: Date

    /// 是否啟用
    var isActive: Bool

    /// 排序順序
    var sortOrder: Int

    /// 提醒設定
    var reminders: [HabitReminder]
}
```

### HabitReminder Value Object

```swift
/// 習慣提醒
struct HabitReminder {
    /// 唯一識別碼
    let id: UUID

    /// 提醒時間 (HH:mm)
    var time: DateComponents

    /// 重複規則
    var repeatRule: RepeatRule

    /// 是否啟用
    var isEnabled: Bool
}

enum RepeatRule {
    case daily
    case weekdays([Weekday])
    case custom([DayOfWeek])
}
```

## Application Layer (CQRS)

### Commands

#### CreateHabitCommand
```swift
struct CreateHabitCommand {
    let name: String
    let iconId: String
    let defaultDuration: TimeInterval
    let starsReward: Int
}
```

#### UpdateHabitCommand
```swift
struct UpdateHabitCommand {
    let habitId: UUID
    let name: String?
    let iconId: String?
    let defaultDuration: TimeInterval?
    let starsReward: Int?
}
```

#### DeleteHabitCommand
```swift
struct DeleteHabitCommand {
    let habitId: UUID
}
```

#### AddHabitReminderCommand
```swift
struct AddHabitReminderCommand {
    let habitId: UUID
    let time: DateComponents
    let repeatRule: RepeatRule
}
```

### Queries

#### GetAllHabitsQuery
```swift
struct GetAllHabitsQuery {
    let sortBy: HabitSortOption
    let searchTerm: String?
}

enum HabitSortOption {
    case recentlyUsed
    case name
    case createdDate
}
```

#### GetHabitByIdQuery
```swift
struct GetHabitByIdQuery {
    let habitId: UUID
}
```

### DTOs

```swift
/// 習慣 DTO (用於 Presentation Layer)
struct HabitDTO {
    let id: UUID
    let name: String
    let iconId: String
    let defaultDuration: TimeInterval
    let starsReward: Int
    let reminderCount: Int
    let isActive: Bool
}
```

## Infrastructure Layer

### Repository Interface

```swift
protocol IHabitRepository {
    func create(_ habit: Habit) async throws -> UUID
    func update(_ habit: Habit) async throws
    func delete(id: UUID) async throws
    func getById(id: UUID) async throws -> Habit?
    func getAll(sortBy: HabitSortOption) async throws -> [Habit]
    func search(term: String) async throws -> [Habit]
}
```

### Data Source (CoreData)

**Entity**: `HabitEntity`

| 屬性 | 型別 | 說明 |
|-----|------|------|
| id | UUID | 主鍵 |
| name | String | 習慣名稱 |
| iconId | String | 圖示 ID |
| defaultDuration | Double | 預設時長 (秒) |
| starsReward | Int32 | 獎勵星星數 |
| createdAt | Date | 建立時間 |
| updatedAt | Date | 更新時間 |
| isActive | Bool | 是否啟用 |
| sortOrder | Int32 | 排序順序 |
| reminders | Relationship | 關聯到 ReminderEntity |

## Presentation Layer

### Views

#### HabitListView
- 顯示所有習慣
- 搜尋列
- 排序選項
- 新增按鈕
- 快速啟動按鈕

#### HabitFormView
- 習慣名稱輸入
- 圖示選擇器
- 時長選擇器 (Picker 或 Stepper)
- 星星數輸入
- 儲存/取消按鈕

#### HabitDetailView
- 習慣資訊顯示
- 編輯按鈕
- 刪除按鈕
- 提醒設定
- 歷史統計概覽

#### HabitReminderView
- 提醒列表
- 新增提醒
- 編輯/刪除提醒
- 啟用/停用開關

### ViewModel

#### HabitListViewModel
```swift
class HabitListViewModel: ObservableObject {
    @Published var habits: [HabitDTO] = []
    @Published var searchTerm: String = ""
    @Published var sortOption: HabitSortOption = .recentlyUsed
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func loadHabits() async
    func createHabit(_ command: CreateHabitCommand) async
    func deleteHabit(id: UUID) async
    func startPomodoro(habitId: UUID) async
}
```

## 驗證規則

### 習慣名稱
- 必填
- 長度: 1-50 字元
- 不可只包含空白字元

### 預設時長
- 必填
- 範圍: 5-480 分鐘 (300-28800 秒)
- 建議值: 15, 25, 30, 45, 60, 90, 120 分鐘

### 獎勵星星數
- 必填
- 範圍: 1-999
- 建議: 時長越長,星星數越多 (可提供計算建議)

### 圖示
- 必選
- 從預設圖示庫選擇

## 錯誤處理

### 可能的錯誤

```swift
enum HabitError: Error {
    case invalidName(String)
    case invalidDuration(TimeInterval)
    case invalidStarsReward(Int)
    case habitNotFound(UUID)
    case duplicateName(String)
    case databaseError(Error)
}
```

### 錯誤訊息 (多語系)

| 錯誤 | 中文訊息 | 英文訊息 |
|-----|---------|---------|
| invalidName | 習慣名稱必須為 1-50 個字元 | Habit name must be 1-50 characters |
| invalidDuration | 時長必須在 5-480 分鐘之間 | Duration must be between 5-480 minutes |
| invalidStarsReward | 星星數必須在 1-999 之間 | Stars reward must be between 1-999 |
| habitNotFound | 找不到指定的習慣 | Habit not found |
| duplicateName | 習慣名稱已存在 | Habit name already exists |

## UI/UX 設計指南

### 習慣列表
- 使用 List 或 LazyVStack
- 每個項目顯示圖示、名稱、時長、星星數
- 支援滑動操作 (編輯/刪除)
- 空狀態顯示引導圖示與文字

### 習慣表單
- 使用 Form 或自訂 UI
- 即時驗證與錯誤提示
- 圖示選擇使用 Grid 顯示
- 時長選擇提供快速選項

### 動畫
- 新增/刪除習慣: fade + slide 動畫
- 列表重新排序: smooth transition
- 啟動番茄鐘: 轉場動畫

## 測試策略

### Unit Tests

#### Domain Layer
- `HabitTests`: 測試實體建立、驗證、行為
- `HabitReminderTests`: 測試提醒邏輯

#### Application Layer
- `CreateHabitCommandHandlerTests`: 測試建立流程
- `UpdateHabitCommandHandlerTests`: 測試更新邏輯
- `GetAllHabitsQueryHandlerTests`: 測試查詢與排序

#### Presentation Layer
- `HabitListViewModelTests`: 測試 ViewModel 邏輯
- 測試排序、搜尋、錯誤處理

### Integration Tests
- `HabitRepositoryTests`: 測試與 CoreData 整合
- 測試 CRUD 操作完整流程

### UI Tests
- 測試建立習慣完整流程
- 測試編輯與刪除
- 測試搜尋與排序功能

## 效能考量

### 優化策略
- 習慣列表使用 lazy loading
- 圖示使用 cached images
- 搜尋使用 debounce (延遲 300ms)
- CoreData 使用適當的 fetch batch size

### 監控指標
- 習慣列表載入時間 < 100ms
- 搜尋回應時間 < 200ms
- 記憶體使用合理 (避免 retain cycle)

## 未來擴充

### Phase 2
- 習慣分類/標籤
- 習慣模板庫
- 習慣分享 (匯出/匯入)
- 習慣群組

### Phase 3
- 習慣依賴關係 (連續完成多個習慣)
- AI 建議習慣時長與獎勵
- 習慣完成預測
