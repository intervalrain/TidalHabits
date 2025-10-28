# 首頁功能規格

## 概述

首頁是應用程式的主要入口,提供今日習慣總覽、快速操作與進度追蹤。

## 主要功能

### 1. 今日總覽
- 顯示日期與星期
- 今日完成進度環
  - 完成習慣數 / 計畫習慣數
  - 獲得星星數
  - 總執行時長
- 激勵語句 (依完成度動態顯示)

### 2. 今日習慣列表
- 顯示今日應完成的習慣
- 每個習慣顯示:
  - 圖示、名稱
  - 預設時長
  - 可獲得星星數
  - 完成狀態 (✓ 已完成 / - 未完成)
  - 「開始」按鈕
- 點擊「開始」直接啟動番茄鐘
- 已完成的習慣顯示實際執行時長與獲得星星數

### 3. 快速統計卡片
- **本週進度**:
  - 完成天數 / 7 天
  - 本週總星星數
- **累積成就**:
  - 總習慣數
  - 累積總星星數
  - 連續天數記錄

### 4. 即將到期提醒
- 顯示設定了提醒且即將觸發的習慣
- 點擊可直接開始

### 5. 快速操作
- 新增習慣按鈕 (FAB)
- 查看所有習慣按鈕
- 查看統計按鈕

## Domain Model

```swift
/// 今日總覽數據
struct DailyOverview {
    let date: Date
    let plannedHabits: [HabitSummary]
    let completedSessions: [CompletedSession]
    let totalStarsEarned: Int
    let totalDuration: TimeInterval
    let completionRate: Double // 0-1
}

/// 習慣摘要
struct HabitSummary {
    let habitId: UUID
    let name: String
    let icon: String
    let defaultDuration: TimeInterval
    let starsReward: Int
    let isCompletedToday: Bool
}

/// 已完成時段
struct CompletedSession {
    let habitId: UUID
    let duration: TimeInterval
    let starsEarned: Int
    let completedAt: Date
}

/// 週進度
struct WeeklyProgress {
    let completedDays: Int
    let totalDays: Int
    let totalStars: Int
    let averageDailyDuration: TimeInterval
}
```

## Queries

```swift
struct GetDailyOverviewQuery {
    let date: Date // 預設今天
}

struct GetWeeklyProgressQuery {
    let weekStartDate: Date
}

struct GetUpcomingRemindersQuery {
    let withinMinutes: Int // 未來 N 分鐘內
}
```

## Presentation

### Views

#### HomeView
- ScrollView 包含所有區塊
- 支援下拉刷新

#### DailyOverviewCard
- 日期顯示
- 圓形進度環 (完成率)
- 關鍵指標顯示

#### TodayHabitListView
- List 或 LazyVStack
- 每個習慣一個卡片
- 已完成的習慣打勾並置灰
- 未完成的習慣顯示「開始」按鈕

#### QuickStatsCard
- 兩欄卡片顯示本週與累積數據
- 使用圖示與數字

#### UpcomingRemindersCard
- 列表顯示即將到期的習慣
- 顯示倒數時間

### ViewModel

```swift
class HomeViewModel: ObservableObject {
    @Published var dailyOverview: DailyOverview?
    @Published var weeklyProgress: WeeklyProgress?
    @Published var upcomingReminders: [UpcomingReminder] = []
    @Published var isLoading: Bool = false
    @Published var isRefreshing: Bool = false

    func loadDailyData() async
    func loadWeeklyProgress() async
    func loadUpcomingReminders() async
    func refresh() async
    func startHabit(habitId: UUID) async
}
```

## 業務規則

### 今日習慣來源
1. 所有啟用的習慣
2. 或: 使用者明確加入今日計畫的習慣 (未來功能)

### 完成判定
- 習慣當天有至少一次完成的番茄鐘時段
- 不論時長,只要有完成記錄即算完成

### 激勵語句
依完成率顯示:
- 0%: "開始你的第一個習慣吧!"
- 1-50%: "繼續加油,已經開始了!"
- 51-80%: "做得很好,再接再厲!"
- 81-99%: "快要完成了,最後衝刺!"
- 100%: "太棒了!今日目標達成!"

## Repository

```swift
protocol IHomeRepository {
    func getDailyOverview(date: Date) async throws -> DailyOverview
    func getWeeklyProgress(weekStart: Date) async throws -> WeeklyProgress
    func getUpcomingReminders(within: TimeInterval) async throws -> [UpcomingReminder]
}
```

## UI/UX 指南

### 佈局
- 使用卡片式設計
- 卡片間適當間距
- 重要資訊放在上方 (首屏可見)

### 顏色
- 完成狀態: 綠色
- 未完成: 中性灰色
- 進度環: 漸層色 (依完成度)
- 激勵語句: 動態顏色 (完成度越高越亮)

### 動畫
- 進度環動畫填充
- 完成習慣時打勾動畫
- 星星數字跳動效果
- 下拉刷新動畫

### 空狀態
- 無習慣時顯示引導新增習慣
- 今日已全部完成顯示慶祝訊息

## 測試重點

- 今日資料載入與計算
- 完成率計算
- 刷新功能
- 啟動習慣流程
- 空狀態處理

## 效能優化

- 使用快取避免重複查詢
- 下拉刷新使用防抖動 (debounce)
- 圖片使用 cached loading

## 無障礙

- VoiceOver 友善
- 動態字體大小支援
- 高對比度模式支援
- 減少動畫選項

## 未來擴充

### Phase 2
- Widget 整合 (顯示今日進度)
- 自訂今日計畫 (手動選擇今日要做的習慣)
- 每日目標設定 (如今日要完成 3 個習慣)
- 連續完成徽章動畫

### Phase 3
- 每日打卡分享
- 每日總結報告
- AI 建議今日應執行的習慣
