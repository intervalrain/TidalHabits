# 行事曆功能規格

## 概述

行事曆模組提供視覺化的時間檢視,讓使用者查看過去記錄與未來安排的習慣執行計畫。

## 主要功能

### 1. 月曆檢視
- 顯示當月日曆
- 每日顯示完成狀態:
  - 無記錄: 灰色
  - 部分完成: 淺色
  - 完成: 深色 (顏色深度依完成時長)
- 點擊日期查看當天詳細記錄
- 支援左右滑動切換月份

### 2. GitHub 風格熱度圖 (Heatmap)
- 顯示過去一年的完成情況
- 方格顏色深度代表當天執行時長
- 點擊方格顯示該日詳細資訊
- 顯示統計:
  - 總天數
  - 完成天數
  - 最長連續
  - 平均每日時長

### 3. 日期詳細檢視
- 選擇特定日期查看:
  - 當天完成的習慣列表
  - 每個習慣的執行時長
  - 獲得的星星數
  - 執行時間點 (幾點到幾點)

### 4. 週檢視 (可選)
- 顯示本週七天
- 每天的習慣完成情況
- 快速概覽

## Domain Model

```swift
/// 日曆數據
struct CalendarData {
    let date: Date
    let totalDuration: TimeInterval
    let completionCount: Int
    let totalStars: Int
    let sessions: [PomodoroSessionSummary]
}

/// 番茄鐘時段摘要
struct PomodoroSessionSummary {
    let habitId: UUID
    let habitName: String
    let habitIcon: String
    let duration: TimeInterval
    let starsEarned: Int
    let startTime: Date
    let endTime: Date
}

/// 熱度圖資料
struct HeatmapData {
    let date: Date
    let intensity: Double // 0-1,代表該日強度
    let totalDuration: TimeInterval
    let completionCount: Int
}
```

## Queries

```swift
struct GetCalendarDataQuery {
    let year: Int
    let month: Int
}

struct GetDayDetailQuery {
    let date: Date
}

struct GetHeatmapDataQuery {
    let startDate: Date // 一年前
    let endDate: Date   // 今天
}
```

## Presentation

### Views

#### CalendarView
- Tab 選擇: 月曆 / 熱度圖
- 月份切換按鈕
- 日期網格

#### MonthCalendarView
- 使用 Grid 或自訂 UI 繪製月曆
- 每個日期格子顯示顏色標記
- 當前日期高亮

#### HeatmapView
- 使用 Grid 繪製小方格
- 顏色漸層: 白色 → 淺綠 → 深綠
- 底部顯示圖例與統計

#### DayDetailView
- 顯示選定日期
- 習慣列表 (完成的)
- 時間軸顯示執行時段
- 總計資訊

### ViewModel

```swift
class CalendarViewModel: ObservableObject {
    @Published var currentMonth: Date = Date()
    @Published var calendarData: [Date: CalendarData] = [:]
    @Published var heatmapData: [HeatmapData] = []
    @Published var selectedDate: Date?
    @Published var dayDetail: CalendarData?
    @Published var isLoading: Bool = false

    func loadMonth() async
    func loadHeatmap() async
    func selectDate(_ date: Date) async
    func nextMonth()
    func previousMonth()
}
```

## 計算邏輯

### 熱度強度計算
```swift
intensity = min(totalDuration / (4 * 3600), 1.0)
// 4 小時為滿強度,超過也算 1.0
```

### 顏色映射
```swift
// 5 個級別
0.0:      白色 (無資料)
0.01-0.2: 很淺綠
0.2-0.4:  淺綠
0.4-0.6:  中綠
0.6-0.8:  深綠
0.8-1.0:  很深綠
```

## Repository

```swift
protocol ICalendarRepository {
    func getMonthData(year: Int, month: Int) async throws -> [Date: CalendarData]
    func getDayDetail(date: Date) async throws -> CalendarData?
    func getHeatmapData(from: Date, to: Date) async throws -> [HeatmapData]
}
```

## UI/UX 指南

### 月曆
- 使用系統預設的月曆佈局 (日一二三四五六)
- 當前日期圓圈標記
- 今天之後的日期可顯示已安排的習慣 (未來功能)
- 平滑的月份切換動畫

### 熱度圖
- 參考 GitHub Contributions 設計
- 每個方格大小一致
- 支援橫向滑動查看完整一年
- 點擊方格顯示浮動資訊卡

### 日期詳細
- 使用 Sheet 或 Navigation 顯示
- 時間軸視覺化當天的執行時段
- 支援分享當天成果

## 測試重點

- 日期計算正確性 (閏年、月份邊界)
- 熱度強度計算
- 資料聚合正確性
- UI 日期對齊與顯示

## 未來擴充

### Phase 2
- 支援新增未來計畫
- 拖曳習慣到日曆安排
- 週期性計畫 (每週一運動)

### Phase 3
- 行事曆匯出 (iCal 格式)
- 與系統日曆整合
- 提醒整合
