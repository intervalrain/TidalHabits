# 番茄鐘 (Check-In) 功能規格

## 概述

番茄鐘模組是應用程式的核心功能,負責執行習慣時的計時、螢幕鎖定、獎勵計算與記錄儲存。

## User Stories

### US-C001: 啟動番茄鐘
**身份**: 使用者
**需求**: 我想要啟動番茄鐘開始執行習慣
**目的**: 以便專注於當前任務並獲得獎勵

**Acceptance Criteria**:
- [ ] 可從習慣列表或首頁啟動
- [ ] 顯示倒數計時介面
- [ ] 手機螢幕鎖定 (保持 App 在前景)
- [ ] 背景持續計時
- [ ] 顯示當前習慣資訊 (名稱、圖示、目標時長)
- [ ] 顯示預期獲得的星星數

### US-C002: 時間到達提醒
**身份**: 使用者
**需求**: 當番茄鐘時間到達時,我想要收到提醒
**目的**: 以便知道任務時段已完成

**Acceptance Criteria**:
- [ ] 時間到達時播放提示音
- [ ] 裝置震動提醒
- [ ] 顯示完成確認畫面
- [ ] 顯示獲得的星星數
- [ ] 提供「完成」與「延長」選項
- [ ] 根據設定決定自動行為 (自動延長/自動停止)

### US-C003: 提前終止
**身份**: 使用者
**需求**: 我想要在時間未到時終止番茄鐘
**目的**: 以便處理突發狀況

**Acceptance Criteria**:
- [ ] 提供「終止」按鈕
- [ ] 點擊後顯示確認對話框
- [ ] 提示將損失的星星數 (依已執行時間比例計算)
- [ ] 確認後停止計時並解鎖螢幕
- [ ] 記錄部分完成的時段 (標記為未完成)

### US-C004: 延長時間
**身份**: 使用者
**需求**: 當時間到達時,我想要延長番茄鐘
**目的**: 以便繼續專注於當前任務

**Acceptance Criteria**:
- [ ] 時間到達時顯示「延長」選項
- [ ] 可選擇預設延長時間 (如 30/60/120 分鐘)
- [ ] 顯示延長後可獲得的額外星星數 (依延長獎勵比例)
- [ ] 確認後繼續計時
- [ ] 可多次延長

### US-C005: 查看執行中狀態
**身份**: 使用者
**需求**: 在番茄鐘執行期間,我想要查看當前狀態
**目的**: 以便了解剩餘時間與進度

**Acceptance Criteria**:
- [ ] 顯示倒數計時 (HH:MM:SS)
- [ ] 顯示進度環或進度條
- [ ] 顯示已執行時間
- [ ] 顯示目標時間
- [ ] 顯示當前可獲得星星數 (即時更新)

### US-C006: 螢幕鎖定機制
**身份**: 使用者
**需求**: 番茄鐘執行期間,我的螢幕應保持鎖定
**目的**: 以便避免誤觸與干擾

**Acceptance Criteria**:
- [ ] 啟動後螢幕保持開啟但鎖定互動
- [ ] 只能操作「終止」按鈕
- [ ] 防止切換到其他 App
- [ ] 時間到達或終止後解鎖
- [ ] 支援 Face ID/Touch ID 解鎖終止

## Domain Model

### PomodoroSession Entity

```swift
/// 番茄鐘時段
struct PomodoroSession {
    /// 唯一識別碼
    let id: UUID

    /// 關聯的習慣 ID
    let habitId: UUID

    /// 開始時間
    let startTime: Date

    /// 結束時間 (如已完成)
    var endTime: Date?

    /// 計畫時長 (秒)
    let plannedDuration: TimeInterval

    /// 實際時長 (秒)
    var actualDuration: TimeInterval {
        if let end = endTime {
            return end.timeIntervalSince(startTime)
        }
        return Date().timeIntervalSince(startTime)
    }

    /// 狀態
    var status: SessionStatus

    /// 獲得的星星數
    var earnedStars: Int

    /// 延長記錄
    var extensions: [SessionExtension]

    /// 是否提前終止
    var isEarlyTermination: Bool
}

enum SessionStatus {
    case running
    case completed
    case terminated
    case extended
}
```

### SessionExtension Value Object

```swift
/// 延長記錄
struct SessionExtension {
    /// 延長時間 (秒)
    let duration: TimeInterval

    /// 延長時的時間點
    let extendedAt: Date

    /// 延長獲得的星星數
    let bonusStars: Int
}
```

### PomodoroTimer Domain Service

```swift
/// 番茄鐘計時器領域服務
class PomodoroTimer {
    /// 計算應獲得的星星數
    func calculateEarnedStars(
        baseStars: Int,
        plannedDuration: TimeInterval,
        actualDuration: TimeInterval,
        isCompleted: Bool
    ) -> Int

    /// 計算延長獎勵星星數
    func calculateExtensionBonus(
        baseStars: Int,
        extensionDuration: TimeInterval,
        bonusPercentage: Double
    ) -> Int

    /// 驗證是否允許延長
    func canExtend(session: PomodoroSession) -> Bool
}
```

## Application Layer (CQRS)

### Commands

#### StartPomodoroCommand
```swift
struct StartPomodoroCommand {
    let habitId: UUID
    let duration: TimeInterval? // nil 使用習慣預設時長
}
```

#### CompletePomodoroCommand
```swift
struct CompletePomodoroCommand {
    let sessionId: UUID
}
```

#### TerminatePomodoroCommand
```swift
struct TerminatePomodoroCommand {
    let sessionId: UUID
    let reason: TerminationReason
}

enum TerminationReason {
    case userRequested
    case systemInterrupted
}
```

#### ExtendPomodoroCommand
```swift
struct ExtendPomodoroCommand {
    let sessionId: UUID
    let extensionDuration: TimeInterval
}
```

### Queries

#### GetActivePomodoroQuery
```swift
struct GetActivePomodoroQuery {
    // 取得當前執行中的番茄鐘
}
```

#### GetPomodoroHistoryQuery
```swift
struct GetPomodoroHistoryQuery {
    let habitId: UUID?
    let startDate: Date
    let endDate: Date
}
```

### DTOs

```swift
/// 番茄鐘 DTO
struct PomodoroDTO {
    let id: UUID
    let habitId: UUID
    let habitName: String
    let habitIcon: String
    let startTime: Date
    let plannedDuration: TimeInterval
    let elapsedDuration: TimeInterval
    let remainingDuration: TimeInterval
    let status: SessionStatus
    let earnedStars: Int
    let potentialStars: Int // 完成後可獲得的星星
}
```

## Infrastructure Layer

### Repository Interface

```swift
protocol IPomodoroSessionRepository {
    func create(_ session: PomodoroSession) async throws -> UUID
    func update(_ session: PomodoroSession) async throws
    func getById(id: UUID) async throws -> PomodoroSession?
    func getActiveSession() async throws -> PomodoroSession?
    func getHistory(
        habitId: UUID?,
        from: Date,
        to: Date
    ) async throws -> [PomodoroSession]
}
```

### System Services

#### ScreenLockService
```swift
protocol IScreenLockService {
    func enableLock() async throws
    func disableLock() async throws
    func isLocked() -> Bool
}
```

#### NotificationService
```swift
protocol INotificationService {
    func scheduleCompletion(at: Date, sessionId: UUID) async throws
    func cancelScheduled(sessionId: UUID) async throws
    func sendImmediateNotification(title: String, body: String) async throws
}
```

#### TimerService
```swift
protocol ITimerService {
    func start(duration: TimeInterval, onTick: @escaping (TimeInterval) -> Void)
    func pause()
    func resume()
    func stop()
}
```

### Data Source (CoreData)

**Entity**: `PomodoroSessionEntity`

| 屬性 | 型別 | 說明 |
|-----|------|------|
| id | UUID | 主鍵 |
| habitId | UUID | 習慣 ID |
| startTime | Date | 開始時間 |
| endTime | Date? | 結束時間 |
| plannedDuration | Double | 計畫時長 |
| status | String | 狀態 (enum raw value) |
| earnedStars | Int32 | 獲得星星數 |
| isEarlyTermination | Bool | 是否提前終止 |
| extensions | Relationship | 關聯到 SessionExtensionEntity |

## Presentation Layer

### Views

#### PomodoroView
- 圓形進度環
- 倒數計時顯示 (大字體)
- 習慣資訊 (圖示、名稱)
- 已執行時間 / 目標時間
- 預期獲得星星數
- 終止按鈕 (需確認)

#### PomodoroCompletionView
- 完成動畫 (慶祝效果)
- 顯示獲得的星星數
- 顯示執行時長
- 「完成」按鈕
- 「延長」按鈕 (顯示可選時長)

#### PomodoroTerminationDialog
- 警告訊息
- 顯示將損失的星星數
- 「確認終止」按鈕
- 「繼續」按鈕

#### PomodoroExtensionSheet
- 延長時間選項 (30/60/120 分鐘)
- 顯示每個選項可獲得的額外星星
- 確認按鈕

### ViewModel

#### PomodoroViewModel
```swift
class PomodoroViewModel: ObservableObject {
    @Published var session: PomodoroDTO?
    @Published var elapsedTime: TimeInterval = 0
    @Published var remainingTime: TimeInterval = 0
    @Published var progress: Double = 0
    @Published var earnedStars: Int = 0
    @Published var isRunning: Bool = false
    @Published var showCompletionView: Bool = false
    @Published var showTerminationDialog: Bool = false

    func startPomodoro(habitId: UUID, duration: TimeInterval?) async
    func completePomodoro() async
    func terminatePomodoro() async
    func extendPomodoro(duration: TimeInterval) async
    func pausePomodoro()
    func resumePomodoro()
}
```

## 業務規則

### 星星計算規則

#### 正常完成
```
獲得星星數 = 習慣設定的基礎星星數
```

#### 提前終止
```
獲得星星數 = 基礎星星數 × (實際執行時間 / 計畫時間)
最少獲得 = 0 (執行時間 < 5 分鐘)
```

#### 延長獎勵
```
延長獎勵 = 基礎星星數 × (延長時間 / 原計畫時間) × 延長獎勵比例

範例:
基礎: 30 stars / 60 分鐘
延長: 30 分鐘
延長獎勵比例: 30%
計算: 30 × (30/60) × 1.3 = 19.5 ≈ 20 stars
```

### 延長規則
- 最多延長次數: 無限制
- 每次延長時間選項: 可在設定中配置
- 延長獎勵比例: 可在設定中配置 (0%, 10%, 20%, 30% 等)

### 時間到達自動行為
根據使用者設定:
1. **自動延長**: 時間到達後,若 60 秒內無操作,自動延長預設時間
2. **自動停止**: 時間到達後,若 60 秒內無操作,自動標記完成

## 錯誤處理

### 可能的錯誤

```swift
enum PomodoroError: Error {
    case sessionAlreadyRunning
    case sessionNotFound(UUID)
    case habitNotFound(UUID)
    case invalidDuration(TimeInterval)
    case screenLockFailed(Error)
    case permissionDenied
}
```

## UI/UX 設計指南

### 顏色方案
- **執行中**: 綠色/藍色漸層
- **即將完成** (最後 5 分鐘): 橘色
- **完成**: 金色/黃色
- **終止**: 紅色

### 動畫
- **啟動**: 圓形進度環從 0% 開始填滿
- **完成**: 星星飛入動畫 + 粒子效果
- **終止**: shake 動畫

### 音效
- **時間到達**: 柔和鈴聲 (可自訂)
- **完成**: 成功音效
- **終止**: 取消音效

### 震動
- **時間到達**: 長震動
- **每 15 分鐘**: 短震動提醒 (可選)

## 螢幕鎖定實作策略

### iOS 限制
iOS 不允許真正鎖定螢幕或阻止切換 App,因此採用以下策略:

1. **保持螢幕常亮**
   - 使用 `UIApplication.shared.isIdleTimerDisabled = true`

2. **全螢幕模式**
   - 使用 `.fullScreenCover` 或 `.sheet(fullScreenCover: true)`
   - 隱藏返回按鈕 (僅保留終止按鈕)

3. **Guided Access 提示**
   - 引導使用者啟用 iOS 的「引導使用模式」(Guided Access)
   - 提供教學說明

4. **Apple Watch 整合** (未來)
   - 在 Watch 上同步顯示計時
   - 即使切換 App,Watch 仍提醒

## 測試策略

### Unit Tests

#### Domain Layer
- `PomodoroSessionTests`: 測試狀態轉換
- `PomodoroTimerTests`: 測試星星計算邏輯
- 測試延長、終止邏輯

#### Application Layer
- `StartPomodoroCommandHandlerTests`: 測試啟動邏輯
- `CompletePomodoroCommandHandlerTests`: 測試完成流程
- `ExtendPomodoroCommandHandlerTests`: 測試延長計算

#### Presentation Layer
- `PomodoroViewModelTests`: 測試 ViewModel 狀態管理
- 測試計時器更新邏輯

### Integration Tests
- 測試完整番茄鐘流程 (啟動 → 完成)
- 測試延長流程
- 測試終止流程
- 測試與 Repository 整合

### UI Tests
- 測試啟動番茄鐘
- 測試完成確認
- 測試提前終止
- 測試延長操作

## 效能考量

### 計時器優化
- 使用 `Timer` 或 `DispatchSourceTimer`
- 計時精度: 1 秒
- 背景模式: 使用 Background Task

### 記憶體管理
- 避免 Timer 的 retain cycle
- 適當釋放資源

### 電池優化
- 減少不必要的 UI 更新
- 背景模式下降低更新頻率

## 無障礙支援

- VoiceOver 朗讀剩餘時間
- 支援語音控制終止
- 提供視覺替代方案 (如閃爍)

## 未來擴充

### Phase 2
- 暫停/恢復功能
- 番茄鐘預設休息時段
- 統計圖表 (每日番茄鐘數)

### Phase 3
- Apple Watch 獨立計時
- Focus Mode 整合
- 白噪音/背景音樂播放
- 目標設定 (如每日 4 個番茄鐘)
