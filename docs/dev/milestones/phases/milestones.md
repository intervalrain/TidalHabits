# TidalHabits Milestone 規劃

## Milestone 總覽

| Milestone | 版本 | 狀態 | 目標日期 | 說明 |
|-----------|------|------|---------|------|
| Project Setup | v0.1.0 | ✅ 完成 | 2025-10-28 | 專案架構與文件 |
| Core Foundation | v0.2.0 | 📋 計畫中 | 2025-11-15 | Core 模組與基礎建設 |
| Habit Feature | v0.3.0 | 📋 計畫中 | 2025-11-30 | 習慣管理功能 |
| Pomodoro Feature | v0.4.0 | 📋 計畫中 | 2025-12-15 | 番茄鐘功能 |
| Settings & Reward | v0.5.0 | 📋 計畫中 | 2025-12-25 | 設定與獎勵系統 |
| Home & Navigation | v0.6.0 | 📋 計畫中 | 2025-12-31 | 首頁與導航整合 |
| MVP Beta | v1.0.0-beta.1 | 📋 計畫中 | 2026-01-15 | Beta 測試版 |
| MVP Release | v1.0.0 | 📋 計畫中 | 2026-01-31 | 正式發布 |
| Statistics | v1.1.0 | 📋 計畫中 | 2026-02-28 | 統計分析功能 |
| Calendar | v1.2.0 | 📋 計畫中 | 2026-03-31 | 行事曆與熱度圖 |
| Widget Support | v1.3.0 | 📋 計畫中 | 2026-04-30 | iOS Widget |
| Apple Watch | v2.0.0 | 📋 計畫中 | 2026-06-30 | Watch 整合 |

## Phase 1: MVP (v0.1.0 → v1.0.0)

### Milestone: v0.1.0 - Project Setup ✅

**狀態**: ✅ 完成
**完成日期**: 2025-10-28

#### 目標
建立專案基礎架構與完整文件系統。

#### Issues
- [x] #1 - 建立專案目錄結構
- [x] #2 - 撰寫架構設計文件
- [x] #3 - 撰寫開發規範文件
- [x] #4 - 撰寫 Git Flow 規範
- [x] #5 - 建立功能規格文件
- [x] #6 - 設定 GitHub Templates
- [x] #7 - 建立 CI/CD Workflow

#### 產出
- ✅ 完整的專案結構
- ✅ 架構設計文件
- ✅ 開發規範與 TDD 流程
- ✅ 7 個功能規格文件
- ✅ GitHub Issue/PR 模板
- ✅ CI/CD 配置檔案

---

### Milestone: v0.2.0 - Core Foundation

**狀態**: 📋 計畫中
**預計日期**: 2025-11-15
**預估時間**: 2 週

#### 目標
建立核心基礎模組,為後續功能開發提供基礎建設。

#### Issues

##### Core/Domain (必須)
- [ ] #10 - 建立 Entity 基礎協定
- [ ] #11 - 建立 Value Object 基礎協定
- [ ] #12 - 建立 Aggregate Root 基礎
- [ ] #13 - 建立 Domain Event 基礎
- [ ] #14 - 建立 Result 型別

##### Core/Extensions (必須)
- [ ] #15 - Date Extensions (格式化、計算)
- [ ] #16 - String Extensions (驗證、本地化)
- [ ] #17 - TimeInterval Extensions
- [ ] #18 - View Extensions (SwiftUI 常用)

##### Core/Utilities (必須)
- [ ] #19 - Logger 實作
- [ ] #20 - Validators 實作
- [ ] #21 - DateFormatter 工具

##### Infrastructure (必須)
- [ ] #22 - CoreData Stack 建立
- [ ] #23 - UserDefaults Wrapper
- [ ] #24 - 基礎 Repository Protocol

##### Shared (必須)
- [ ] #25 - 主題系統 (Colors, Fonts, Spacing)
- [ ] #26 - Tab Bar 導航框架
- [ ] #27 - 基礎 UI 元件 (Button, Card)

##### 測試 (必須)
- [ ] #28 - Core 模組單元測試
- [ ] #29 - Extensions 測試
- [ ] #30 - Utilities 測試

#### 驗收標準
- [x] Core/Domain 基礎類別完成
- [x] Extensions 與 Utilities 可用
- [x] CoreData Stack 可運作
- [x] 測試覆蓋率 ≥ 90%
- [x] 所有 CI 檢查通過

#### 依賴
無

---

### Milestone: v0.3.0 - Habit Feature

**狀態**: 📋 計畫中
**預計日期**: 2025-11-30
**預估時間**: 2 週

#### 目標
實作習慣管理的完整功能 (CRUD)。

#### Issues

##### Domain Layer (TDD - 先寫測試)
- [ ] #40 - Habit Entity 實作與測試
- [ ] #41 - HabitReminder Value Object 實作與測試
- [ ] #42 - IHabitRepository Protocol 定義
- [ ] #43 - HabitError 定義

##### Infrastructure Layer
- [ ] #44 - CoreData Habit Schema 設計
- [ ] #45 - HabitRepository 實作與測試
- [ ] #46 - CoreDataHabitDataSource 實作

##### Application Layer (CQRS)
- [ ] #47 - CreateHabitCommand & Handler 實作與測試
- [ ] #48 - UpdateHabitCommand & Handler 實作與測試
- [ ] #49 - DeleteHabitCommand & Handler 實作與測試
- [ ] #50 - GetAllHabitsQuery & Handler 實作與測試
- [ ] #51 - GetHabitByIdQuery & Handler 實作與測試
- [ ] #52 - HabitDTO 定義

##### Presentation Layer (UI)
- [ ] #53 - HabitListViewModel 實作與測試
- [ ] #54 - HabitListView UI 實作
- [ ] #55 - HabitFormView UI 實作
- [ ] #56 - HabitDetailView UI 實作
- [ ] #57 - HabitReminderView UI 實作
- [ ] #58 - 圖示選擇器 UI 實作

##### 整合測試
- [ ] #59 - Habit CRUD 整合測試
- [ ] #60 - UI Flow 測試

##### 文件
- [ ] #61 - 更新 README (展示第一個完整 Feature)

#### 驗收標準
- [x] 可建立、編輯、刪除習慣
- [x] 習慣列表正常顯示
- [x] 支援搜尋與排序
- [x] 測試覆蓋率 ≥ 80%
- [x] 所有 UI 文字已本地化
- [x] 遵循 Clean Architecture

#### 依賴
- v0.2.0 (Core Foundation)

---

### Milestone: v0.4.0 - Pomodoro Feature

**狀態**: 📋 計畫中
**預計日期**: 2025-12-15
**預估時間**: 2 週

#### 目標
實作番茄鐘核心功能,包含計時、鎖定、獎勵計算。

#### Issues

##### Domain Layer
- [ ] #70 - PomodoroSession Entity 實作與測試
- [ ] #71 - SessionExtension Value Object 實作與測試
- [ ] #72 - PomodoroTimer Service 實作與測試
- [ ] #73 - 星星計算邏輯測試

##### Infrastructure Layer
- [ ] #74 - CoreData Pomodoro Schema 設計
- [ ] #75 - PomodoroSessionRepository 實作與測試
- [ ] #76 - TimerService 實作 (Combine/AsyncSequence)
- [ ] #77 - ScreenLockService 實作 (研究最佳方案)
- [ ] #78 - NotificationService 實作

##### Application Layer
- [ ] #79 - StartPomodoroCommand & Handler
- [ ] #80 - CompletePomodoroCommand & Handler
- [ ] #81 - ExtendPomodoroCommand & Handler
- [ ] #82 - TerminatePomodoroCommand & Handler
- [ ] #83 - GetActivePomodoroQuery & Handler

##### Presentation Layer
- [ ] #84 - PomodoroViewModel 實作與測試
- [ ] #85 - PomodoroView UI (計時畫面)
- [ ] #86 - PomodoroCompletionView UI
- [ ] #87 - PomodoroExtensionSheet UI
- [ ] #88 - 圓形進度環 Component

##### 整合測試
- [ ] #89 - 完整番茄鐘流程測試
- [ ] #90 - 延長功能測試
- [ ] #91 - 提前終止測試

#### 驗收標準
- [x] 可啟動並完成番茄鐘
- [x] 螢幕保持常亮 (盡可能鎖定)
- [x] 星星計算正確
- [x] 支援延長與提前終止
- [x] 通知正常運作
- [x] 測試覆蓋率 ≥ 80%

#### 依賴
- v0.3.0 (Habit Feature - 需要習慣資料)

---

### Milestone: v0.5.0 - Settings & Reward

**狀態**: 📋 計畫中
**預計日期**: 2025-12-25
**預估時間**: 1.5 週

#### 目標
實作設定功能與獎勵系統。

#### Issues

##### Settings - Domain Layer
- [ ] #100 - AppSettings Entity
- [ ] #101 - PomodoroSettings Value Object
- [ ] #102 - NotificationSettings Value Object

##### Settings - Infrastructure
- [ ] #103 - UserDefaults Settings Repository
- [ ] #104 - 設定預設值

##### Settings - Application Layer
- [ ] #105 - UpdatePomodoroSettingsCommand
- [ ] #106 - UpdateNotificationSettingsCommand
- [ ] #107 - UpdateLanguageCommand
- [ ] #108 - GetAppSettingsQuery

##### Settings - Presentation
- [ ] #109 - SettingsViewModel
- [ ] #110 - SettingsView UI
- [ ] #111 - PomodoroSettingsView UI
- [ ] #112 - NotificationSettingsView UI

##### Reward - Domain Layer
- [ ] #113 - Reward Entity 實作
- [ ] #114 - RewardRedemption Entity 實作
- [ ] #115 - IRewardRepository Protocol

##### Reward - Infrastructure
- [ ] #116 - CoreData Reward Schema
- [ ] #117 - RewardRepository 實作

##### Reward - Application Layer
- [ ] #118 - CreateRewardCommand
- [ ] #119 - RedeemRewardCommand
- [ ] #120 - GetAllRewardsQuery

##### Reward - Presentation
- [ ] #121 - RewardManagementViewModel
- [ ] #122 - RewardManagementView UI
- [ ] #123 - RewardRedemptionHistoryView

##### 多語系
- [ ] #124 - 建立 Localizable.strings (繁中)
- [ ] #125 - 建立 Localizable.strings (簡中)
- [ ] #126 - 建立 Localizable.strings (英語)
- [ ] #127 - 建立 Localizable.strings (日語)
- [ ] #128 - 建立 Localizable.strings (韓語)

#### 驗收標準
- [x] 設定可儲存與讀取
- [x] 獎勵可建立與兌換
- [x] 多語系切換正常
- [x] 所有 UI 文字已本地化
- [x] 測試覆蓋率 ≥ 75%

#### 依賴
- v0.4.0 (Pomodoro Feature - 需要星星數資料)

---

### Milestone: v0.6.0 - Home & Navigation

**狀態**: 📋 計畫中
**預計日期**: 2025-12-31
**預估時間**: 1 週

#### 目標
實作首頁總覽與完整的導航系統。

#### Issues

##### Home - Domain Layer
- [ ] #140 - DailyOverview Aggregate
- [ ] #141 - WeeklyProgress Value Object

##### Home - Application Layer
- [ ] #142 - GetDailyOverviewQuery
- [ ] #143 - GetWeeklyProgressQuery

##### Home - Presentation
- [ ] #144 - HomeViewModel
- [ ] #145 - HomeView UI
- [ ] #146 - DailyOverviewCard Component
- [ ] #147 - TodayHabitListView Component
- [ ] #148 - QuickStatsCard Component

##### Navigation
- [ ] #149 - TabBarView 完整實作
- [ ] #150 - Navigation Coordinator
- [ ] #151 - Deep Linking 支援 (基礎)

##### 整合
- [ ] #152 - 整合所有 Feature 到 Tab Bar
- [ ] #153 - App 啟動流程
- [ ] #154 - 狀態管理整合

##### UI Polish
- [ ] #155 - 統一 UI 風格
- [ ] #156 - 動畫與轉場效果
- [ ] #157 - 空狀態處理

#### 驗收標準
- [x] 首頁正確顯示今日總覽
- [x] Tab Bar 導航流暢
- [x] 所有功能可正常使用
- [x] UI 一致性良好
- [x] 效能符合標準

#### 依賴
- v0.3.0 (Habit)
- v0.4.0 (Pomodoro)
- v0.5.0 (Settings & Reward)

---

### Milestone: v1.0.0-beta.1 - MVP Beta

**狀態**: 📋 計畫中
**預計日期**: 2026-01-15
**預估時間**: 2 週

#### 目標
準備 Beta 測試版本,進行全面測試與 Bug 修復。

#### Issues
- [ ] #170 - 完整功能測試
- [ ] #171 - UI/UX Review
- [ ] #172 - 效能優化
- [ ] #173 - 記憶體洩漏檢查
- [ ] #174 - 無障礙支援檢查
- [ ] #175 - 多語系完整性檢查
- [ ] #176 - Beta 測試文件準備
- [ ] #177 - TestFlight 設定
- [ ] #178 - 收集 Beta Tester 回饋
- [ ] #179 - Bug 修復 (批次)

#### 驗收標準
- [x] 所有核心功能正常運作
- [x] 無 Critical Bug
- [x] 測試覆蓋率 ≥ 75%
- [x] 效能符合標準
- [x] Beta Tester 回饋正面

#### 依賴
- v0.6.0 (Home & Navigation)

---

### Milestone: v1.0.0 - MVP Release

**狀態**: 📋 計畫中
**預計日期**: 2026-01-31
**預估時間**: 2 週

#### 目標
正式發布 MVP 版本。

#### Issues
- [ ] #190 - Beta 回饋問題修復
- [ ] #191 - 最終 UI 調整
- [ ] #192 - App Store 資產準備 (截圖、預覽影片)
- [ ] #193 - App Store 描述撰寫 (多語言)
- [ ] #194 - Privacy Policy 撰寫
- [ ] #195 - 使用說明撰寫
- [ ] #196 - Release Notes 準備
- [ ] #197 - 最終測試
- [ ] #198 - App Store 提交
- [ ] #199 - 行銷準備

#### 驗收標準
- [x] 通過 App Store Review
- [x] 無 Critical Bug
- [x] 所有文件齊全
- [x] 準備好使用者支援管道

#### 依賴
- v1.0.0-beta.1

---

## Phase 2: Enhancement (v1.1.0 → v1.5.0)

### Milestone: v1.1.0 - Statistics

**預計日期**: 2026-02-28

### Milestone: v1.2.0 - Calendar

**預計日期**: 2026-03-31

### Milestone: v1.3.0 - Widget Support

**預計日期**: 2026-04-30

---

## Phase 3: Watch Integration (v2.0.0)

### Milestone: v2.0.0 - Apple Watch

**預計日期**: 2026-06-30

---

## 如何使用 Milestone

### 在 GitHub 建立 Milestone

```bash
# 透過 GitHub Web UI 或 GitHub CLI

gh milestone create "v0.2.0 - Core Foundation" \
  --due-date 2025-11-15 \
  --description "建立核心基礎模組"
```

### 將 Issue 加入 Milestone

```bash
# 建立 Issue 時指定
gh issue create \
  --title "建立 Entity 基礎協定" \
  --body "..." \
  --milestone "v0.2.0 - Core Foundation"
```

### 追蹤進度

每個 Milestone 的進度可在 GitHub 查看:
```
https://github.com/intervalrain/TidalHabits/milestones
```

---

## 更新記錄

- **2025-10-28**: 建立 Milestone 規劃文件
- **2025-10-28**: 完成 v0.1.0 Milestone
