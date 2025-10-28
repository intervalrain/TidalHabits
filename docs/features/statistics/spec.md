# 統計功能規格

## 概述

統計模組負責收集、分析與視覺化呈現使用者的習慣執行數據。

## 主要功能

### 1. 習慣統計總覽
- 選擇特定習慣或全部習慣
- 時間範圍選擇 (今日/本週/本月/全部)
- 顯示關鍵指標:
  - 總執行時長
  - 完成次數
  - 累積獲得星星數
  - 平均每日執行時長
  - 完成率
  - 最長連續天數
  - 當前連續天數

### 2. 圖表視覺化
- **時長趨勢圖**: 每日/每週執行時長折線圖
- **完成次數柱狀圖**: 每日/每週完成次數
- **時段分布圖**: 一天中各時段的執行分布
- **習慣比較圖**: 多個習慣的執行時長對比
- **星星累積圖**: 累積星星數趨勢

### 3. 排行與成就
- 本週最常執行的習慣
- 本月最高星星數習慣
- 連續完成記錄
- 里程碑提示 (如總時長達 100 小時)

## Domain Model

```swift
/// 統計數據
struct HabitStatistics {
    let habitId: UUID
    let habitName: String
    let totalDuration: TimeInterval
    let completionCount: Int
    let totalStarsEarned: Int
    let averageDailyDuration: TimeInterval
    let completionRate: Double // 0-1
    let longestStreak: Int // 最長連續天數
    let currentStreak: Int // 當前連續天數
    let period: DateInterval
}

/// 時段統計
struct TimeSlotStatistics {
    let habitId: UUID
    let hourOfDay: Int // 0-23
    let totalDuration: TimeInterval
    let completionCount: Int
}

/// 趨勢數據點
struct TrendDataPoint {
    let date: Date
    let value: Double // 可能是時長、次數等
}
```

## Queries

```swift
struct GetHabitStatisticsQuery {
    let habitId: UUID?
    let startDate: Date
    let endDate: Date
}

struct GetTrendDataQuery {
    let habitId: UUID
    let metric: MetricType // duration, count, stars
    let granularity: Granularity // daily, weekly, monthly
    let startDate: Date
    let endDate: Date
}

enum MetricType {
    case duration
    case completionCount
    case starsEarned
}

enum Granularity {
    case daily
    case weekly
    case monthly
}
```

## Presentation

### Views

#### StatisticsView
- Tab 切換: 概覽 / 圖表 / 排行
- 習慣選擇器
- 時間範圍選擇器

#### StatisticsOverviewView
- 卡片式顯示關鍵指標
- 環狀進度圖 (完成率)
- 連續記錄顯示

#### StatisticsChartView
- 圖表類型選擇
- 使用 Swift Charts 繪製
- 支援縮放與詳細資訊顯示

#### RankingView
- 排行榜列表
- 顯示前 5 名習慣
- 成就徽章

### ViewModel

```swift
class StatisticsViewModel: ObservableObject {
    @Published var statistics: HabitStatistics?
    @Published var trendData: [TrendDataPoint] = []
    @Published var selectedHabitId: UUID?
    @Published var selectedPeriod: TimePeriod = .thisWeek
    @Published var isLoading: Bool = false

    func loadStatistics() async
    func loadTrendData(metric: MetricType) async
    func exportReport() async -> URL?
}
```

## 計算邏輯

### 完成率
```swift
完成率 = 實際完成次數 / 期望完成次數
期望完成次數 = 期間天數 (假設每天應完成一次)
```

### 連續天數
```swift
// 從今天往回算,連續有完成記錄的天數
// 允許一天多次完成,計為一天
```

### 平均每日時長
```swift
平均每日時長 = 總執行時長 / 期間天數
```

## 測試重點

- 統計數據計算正確性
- 邊界情況處理 (無資料、單一資料點)
- 圖表資料轉換
- 日期範圍計算

## UI/UX 指南

- 使用清晰的圖表標題與軸標籤
- 提供空狀態引導
- 支援淺色/深色模式
- 圖表支援橫向滑動查看更多資料
- 關鍵數字使用大字體突出

## 未來擴充

- 統計報告自動生成與分享
- 目標設定與追蹤
- 週期性報告通知
- 與朋友比較 (社群功能)
