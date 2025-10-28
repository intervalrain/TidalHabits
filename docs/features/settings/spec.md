# 設定功能規格

## 概述

設定模組負責管理應用程式的全域設定,包含番茄鐘行為、通知、語言、主題等設定項。

## User Stories

### US-S001: 設定時間到達行為
**身份**: 使用者
**需求**: 我想要設定番茄鐘時間到達時的自動行為
**目的**: 以便符合我的使用習慣

**Acceptance Criteria**:
- [ ] 可選擇「自動延長」或「自動停止」
- [ ] 設定無操作等待時間 (30/60/90 秒)
- [ ] 即時生效
- [ ] 顯示說明文字

### US-S002: 設定延長時間選項
**身份**: 使用者
**需求**: 我想要自訂延長時間的選項
**目的**: 以便快速選擇符合我需求的延長時長

**Acceptance Criteria**:
- [ ] 可設定 2-5 個延長時間選項
- [ ] 每個選項範圍: 5-240 分鐘
- [ ] 提供常用預設值 (15/30/60/120 分鐘)
- [ ] 可自訂分鐘數
- [ ] 設定後在延長畫面顯示

### US-S003: 設定延長獎勵比例
**身份**: 使用者
**需求**: 我想要設定延長時段的獎勵加成比例
**目的**: 以便激勵自己延長專注時間

**Acceptance Criteria**:
- [ ] 可選擇 0%, 10%, 20%, 30%, 50%, 100% 等比例
- [ ] 顯示計算範例
- [ ] 即時生效於新的延長操作
- [ ] 預設值: 30%

### US-S004: 語言設定
**身份**: 使用者
**需求**: 我想要切換應用程式的顯示語言
**目的**: 以便使用我熟悉的語言

**Acceptance Criteria**:
- [ ] 支援: 繁體中文、簡體中文、English、日本語、한국어
- [ ] 切換後即時更新所有介面文字
- [ ] 預設跟隨系統語言
- [ ] 可手動覆寫

### US-S005: 通知設定
**身份**: 使用者
**需求**: 我想要管理通知相關設定
**目的**: 以便控制何時接收通知

**Acceptance Criteria**:
- [ ] 啟用/停用習慣提醒通知
- [ ] 啟用/停用番茄鐘完成通知
- [ ] 設定勿擾時段
- [ ] 測試通知功能
- [ ] 檢查並請求通知權限

### US-S006: 獎勵管理
**身份**: 使用者
**需求**: 我想要管理我的獎勵項目
**目的**: 以便設定我想要兌換的獎勵

**Acceptance Criteria**:
- [ ] 查看所有獎勵項目
- [ ] 新增獎勵 (名稱、所需星星數、描述)
- [ ] 編輯獎勵
- [ ] 刪除獎勵
- [ ] 查看兌換歷史

### US-S007: 資料管理
**身份**: 使用者
**需求**: 我想要管理我的應用程式資料
**目的**: 以便備份或清除資料

**Acceptance Criteria**:
- [ ] 檢視資料使用量統計
- [ ] 匯出資料 (JSON/CSV)
- [ ] 清除所有資料 (需確認)
- [ ] 未來: iCloud 同步設定

### US-S008: 關於與說明
**身份**: 使用者
**需求**: 我想要查看應用程式資訊與使用說明
**目的**: 以便了解版本與如何使用

**Acceptance Criteria**:
- [ ] 顯示應用程式版本
- [ ] 使用說明/教學
- [ ] 隱私政策
- [ ] 開源授權資訊
- [ ] 聯絡方式/回饋

## Domain Model

### AppSettings Entity

```swift
/// 應用程式設定
struct AppSettings {
    /// 番茄鐘設定
    var pomodoroSettings: PomodoroSettings

    /// 通知設定
    var notificationSettings: NotificationSettings

    /// 顯示設定
    var displaySettings: DisplaySettings

    /// 語言設定
    var language: AppLanguage

    /// 最後更新時間
    var lastUpdatedAt: Date
}
```

### PomodoroSettings Value Object

```swift
/// 番茄鐘設定
struct PomodoroSettings {
    /// 時間到達自動行為
    var autoAction: PomodoroAutoAction

    /// 無操作等待時間 (秒)
    var idleTimeout: TimeInterval

    /// 延長時間選項 (分鐘)
    var extensionOptions: [Int]

    /// 延長獎勵比例 (0-1)
    var extensionBonusPercentage: Double

    /// 是否允許暫停
    var allowPause: Bool

    /// 每 N 分鐘震動提醒
    var vibrationInterval: Int?
}

enum PomodoroAutoAction {
    case autoExtend // 自動延長
    case autoStop   // 自動停止
    case none       // 無動作,等待使用者
}
```

### NotificationSettings Value Object

```swift
/// 通知設定
struct NotificationSettings {
    /// 啟用習慣提醒
    var habitRemindersEnabled: Bool

    /// 啟用完成通知
    var completionNotificationsEnabled: Bool

    /// 勿擾時段
    var quietHours: QuietHoursConfig?

    /// 通知音效
    var soundEnabled: Bool

    /// 通知震動
    var vibrationEnabled: Bool
}

struct QuietHoursConfig {
    var startTime: DateComponents // HH:mm
    var endTime: DateComponents   // HH:mm
    var enabled: Bool
}
```

### DisplaySettings Value Object

```swift
/// 顯示設定
struct DisplaySettings {
    /// 主題模式
    var themeMode: ThemeMode

    /// 主色調
    var accentColor: AccentColor

    /// 是否使用系統字體大小
    var useSystemFontSize: Bool
}

enum ThemeMode {
    case light
    case dark
    case system // 跟隨系統
}

enum AccentColor: String, CaseIterable {
    case blue
    case green
    case orange
    case purple
    case pink
}
```

### AppLanguage Enum

```swift
enum AppLanguage: String, CaseIterable {
    case zhHant = "zh-Hant" // 繁體中文
    case zhHans = "zh-Hans" // 簡體中文
    case en = "en"          // English
    case ja = "ja"          // 日本語
    case ko = "ko"          // 한국어

    var displayName: String {
        switch self {
        case .zhHant: return "繁體中文"
        case .zhHans: return "简体中文"
        case .en: return "English"
        case .ja: return "日本語"
        case .ko: return "한국어"
        }
    }
}
```

## Application Layer (CQRS)

### Commands

#### UpdatePomodoroSettingsCommand
```swift
struct UpdatePomodoroSettingsCommand {
    let autoAction: PomodoroAutoAction?
    let idleTimeout: TimeInterval?
    let extensionOptions: [Int]?
    let extensionBonusPercentage: Double?
}
```

#### UpdateNotificationSettingsCommand
```swift
struct UpdateNotificationSettingsCommand {
    let habitRemindersEnabled: Bool?
    let completionNotificationsEnabled: Bool?
    let quietHours: QuietHoursConfig?
    let soundEnabled: Bool?
    let vibrationEnabled: Bool?
}
```

#### UpdateLanguageCommand
```swift
struct UpdateLanguageCommand {
    let language: AppLanguage
}
```

#### UpdateThemeCommand
```swift
struct UpdateThemeCommand {
    let themeMode: ThemeMode
    let accentColor: AccentColor?
}
```

### Queries

#### GetAppSettingsQuery
```swift
struct GetAppSettingsQuery {
    // 取得所有設定
}
```

#### GetPomodoroSettingsQuery
```swift
struct GetPomodoroSettingsQuery {
    // 取得番茄鐘設定
}
```

## Infrastructure Layer

### Repository Interface

```swift
protocol ISettingsRepository {
    func getSettings() async throws -> AppSettings
    func updateSettings(_ settings: AppSettings) async throws
    func resetToDefault() async throws
}
```

### Data Source

使用 **UserDefaults** 儲存設定

```swift
class UserDefaultsSettingsDataSource {
    private let defaults = UserDefaults.standard

    enum Keys {
        static let pomodoroAutoAction = "pomodoro.autoAction"
        static let pomodoroIdleTimeout = "pomodoro.idleTimeout"
        static let extensionOptions = "pomodoro.extensionOptions"
        static let extensionBonusPercentage = "pomodoro.extensionBonus"
        static let language = "app.language"
        static let themeMode = "display.themeMode"
        // ... 其他 keys
    }
}
```

## Presentation Layer

### Views

#### SettingsView
- 列表式設定介面
- 分段顯示不同設定群組:
  - 番茄鐘
  - 通知
  - 顯示
  - 語言
  - 獎勵管理
  - 資料管理
  - 關於

#### PomodoroSettingsView
- 自動行為選擇 (Picker)
- 延長選項設定
- 延長獎勵比例 (Slider)
- 即時預覽計算結果

#### NotificationSettingsView
- 開關列表
- 勿擾時段時間選擇器
- 測試通知按鈕
- 權限狀態顯示

#### RewardManagementView
- 獎勵列表
- 新增/編輯/刪除獎勵
- 兌換歷史

#### DataManagementView
- 資料統計 (習慣數、記錄數、總星星數)
- 匯出按鈕
- 清除資料按鈕 (危險操作)

#### AboutView
- App 圖示
- 版本號與建置號
- 使用說明連結
- 隱私政策
- 開源授權
- 評分與回饋

### ViewModel

#### SettingsViewModel
```swift
class SettingsViewModel: ObservableObject {
    @Published var settings: AppSettings
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func loadSettings() async
    func updatePomodoroSettings(_ command: UpdatePomodoroSettingsCommand) async
    func updateNotificationSettings(_ command: UpdateNotificationSettingsCommand) async
    func updateLanguage(_ language: AppLanguage) async
    func updateTheme(_ command: UpdateThemeCommand) async
    func requestNotificationPermission() async
    func testNotification() async
    func exportData() async -> URL?
    func clearAllData() async throws
}
```

#### RewardManagementViewModel
```swift
class RewardManagementViewModel: ObservableObject {
    @Published var rewards: [RewardDTO] = []
    @Published var rewardHistory: [RewardRedemptionDTO] = []

    func loadRewards() async
    func createReward(_ command: CreateRewardCommand) async
    func updateReward(_ command: UpdateRewardCommand) async
    func deleteReward(id: UUID) async
    func loadHistory() async
}
```

## Reward 功能 (整合在設定中)

### Reward Entity

```swift
/// 獎勵實體
struct Reward {
    let id: UUID
    var name: String
    var description: String?
    var requiredStars: Int
    var icon: String
    var isActive: Bool
    let createdAt: Date
    var updatedAt: Date
}
```

### RewardRedemption Entity

```swift
/// 獎勵兌換記錄
struct RewardRedemption {
    let id: UUID
    let rewardId: UUID
    let redeemedAt: Date
    let starsSpent: Int
}
```

### Commands

#### CreateRewardCommand
```swift
struct CreateRewardCommand {
    let name: String
    let description: String?
    let requiredStars: Int
    let icon: String
}
```

#### RedeemRewardCommand
```swift
struct RedeemRewardCommand {
    let rewardId: UUID
}
```

### Reward Repository

```swift
protocol IRewardRepository {
    func create(_ reward: Reward) async throws -> UUID
    func update(_ reward: Reward) async throws
    func delete(id: UUID) async throws
    func getAll() async throws -> [Reward]
    func redeem(rewardId: UUID, userId: UUID) async throws
    func getRedemptionHistory() async throws -> [RewardRedemption]
}
```

## 驗證規則

### 延長時間選項
- 數量: 2-5 個
- 範圍: 5-240 分鐘
- 不可重複

### 延長獎勵比例
- 範圍: 0-100%
- 建議值: 0%, 10%, 20%, 30%, 50%, 100%

### 獎勵
- 名稱: 1-30 字元,必填
- 所需星星數: 1-9999

## 錯誤處理

```swift
enum SettingsError: Error {
    case invalidExtensionOptions
    case invalidBonusPercentage(Double)
    case notificationPermissionDenied
    case exportFailed(Error)
    case importFailed(Error)
}

enum RewardError: Error {
    case insufficientStars(required: Int, available: Int)
    case rewardNotFound(UUID)
    case invalidStarsAmount(Int)
}
```

## UI/UX 設計指南

### 設定畫面
- 使用原生 Form 或 List
- 每個設定項有說明文字
- 重要設定有即時預覽
- 危險操作使用紅色並需確認

### 獎勵管理
- 卡片式列表顯示獎勵
- 顯示圖示、名稱、所需星星數
- 可兌換的獎勵高亮顯示
- 已兌換的獎勵顯示在歷史中

## 測試策略

### Unit Tests
- `AppSettingsTests`: 測試設定實體
- `UpdatePomodoroSettingsCommandHandlerTests`: 測試設定更新邏輯
- `RewardTests`: 測試獎勵實體與驗證

### Integration Tests
- `SettingsRepositoryTests`: 測試 UserDefaults 整合
- `RewardRepositoryTests`: 測試獎勵資料存取

### UI Tests
- 測試設定變更流程
- 測試語言切換
- 測試獎勵兌換流程

## 預設值

```swift
extension AppSettings {
    static var `default`: AppSettings {
        AppSettings(
            pomodoroSettings: PomodoroSettings(
                autoAction: .none,
                idleTimeout: 60,
                extensionOptions: [15, 30, 60, 120],
                extensionBonusPercentage: 0.3,
                allowPause: false,
                vibrationInterval: nil
            ),
            notificationSettings: NotificationSettings(
                habitRemindersEnabled: true,
                completionNotificationsEnabled: true,
                quietHours: nil,
                soundEnabled: true,
                vibrationEnabled: true
            ),
            displaySettings: DisplaySettings(
                themeMode: .system,
                accentColor: .blue,
                useSystemFontSize: true
            ),
            language: .zhHant,
            lastUpdatedAt: Date()
        )
    }
}
```

## 未來擴充

### Phase 2
- 主題自訂 (顏色、字體)
- iCloud 同步設定
- 資料自動備份
- 匯入資料功能

### Phase 3
- Focus Mode 整合
- Shortcuts 整合
- 統計報告自動生成與分享
- 多裝置同步
