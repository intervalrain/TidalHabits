#!/bin/bash

# TidalHabits - 建立所有 GitHub Issues
# 包含 v0.2.0 到 v2.0.0 的所有 Issues

REPO="intervalrain/TidalHabits"

echo "🚀 開始建立 TidalHabits 所有 GitHub Issues..."
echo "📦 Repository: $REPO"
echo ""

# =============================================================================
# Milestone: v0.4.0 - Pomodoro Feature
# =============================================================================
echo "📋 建立 Milestone v0.4.0 - Pomodoro Feature 的 Issues..."

# Domain Layer
gh issue create --repo $REPO \
  --title "PomodoroSession Entity 實作與測試" \
  --body "## 描述
實作 PomodoroSession Entity (TDD 方式)。

## 任務
- [ ] 先撰寫測試
- [ ] 定義 PomodoroSession struct
- [ ] 實作計時邏輯
- [ ] 實作星星計算

## 驗收標準
- 測試先於實作
- 測試覆蓋率 ≥ 95%
- 星星計算正確

## 技術細節
\`\`\`swift
struct PomodoroSession: Entity {
    let id: UUID
    let habitId: UUID
    let startTime: Date
    var endTime: Date?
    var duration: TimeInterval
    var starsEarned: Int
    var isCompleted: Bool
}
\`\`\`

## 參考文件
- [番茄鐘規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/checkin/spec.md)" \
  --milestone "v0.4.0 - Pomodoro Feature" \
  --label "feature,priority: critical"

gh issue create --repo $REPO \
  --title "SessionExtension Value Object 實作與測試" \
  --body "## 描述
實作 SessionExtension Value Object (延長時段)。

## 任務
- [ ] 先撰寫測試
- [ ] 定義 SessionExtension struct
- [ ] 實作延長邏輯
- [ ] 實作獎勵懲罰

## 驗收標準
- 測試先於實作
- 測試覆蓋率 ≥ 90%

## 參考文件
- [番茄鐘規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/checkin/spec.md)" \
  --milestone "v0.4.0 - Pomodoro Feature" \
  --label "feature,priority: high"

gh issue create --repo $REPO \
  --title "PomodoroTimer Service 實作與測試" \
  --body "## 描述
實作 PomodoroTimer Domain Service。

## 任務
- [ ] 先撰寫測試
- [ ] 實作計時邏輯
- [ ] 實作暫停/恢復
- [ ] 實作完成判定

## 驗收標準
- 測試先於實作
- 測試覆蓋率 ≥ 90%
- 計時準確

## 參考文件
- [番茄鐘規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/checkin/spec.md)" \
  --milestone "v0.4.0 - Pomodoro Feature" \
  --label "feature,priority: critical"

gh issue create --repo $REPO \
  --title "星星計算邏輯測試" \
  --body "## 描述
為星星計算邏輯撰寫完整測試。

## 任務
- [ ] 基礎完成獎勵測試
- [ ] 延長懲罰測試
- [ ] 提前終止測試
- [ ] 邊界情況測試

## 驗收標準
- 測試覆蓋率 ≥ 95%
- 所有邊界情況考慮

## 參考文件
- [番茄鐘規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/checkin/spec.md)" \
  --milestone "v0.4.0 - Pomodoro Feature" \
  --label "test,priority: high"

# Infrastructure Layer
gh issue create --repo $REPO \
  --title "CoreData Pomodoro Schema 設計" \
  --body "## 描述
設計 CoreData PomodoroSession Schema。

## 任務
- [ ] 建立 PomodoroSessionEntity
- [ ] 定義屬性與關聯
- [ ] 與 Habit 的關聯
- [ ] 索引優化

## 驗收標準
- Schema 設計完整
- 查詢效能良好

## 參考文件
- [番茄鐘規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/checkin/spec.md)" \
  --milestone "v0.4.0 - Pomodoro Feature" \
  --label "feature,priority: high"

gh issue create --repo $REPO \
  --title "PomodoroSessionRepository 實作與測試" \
  --body "## 描述
實作 PomodoroSessionRepository。

## 任務
- [ ] 先撰寫整合測試
- [ ] 實作 Repository
- [ ] CRUD 操作
- [ ] 查詢方法

## 驗收標準
- 測試先於實作
- 測試覆蓋率 ≥ 90%

## 參考文件
- [番茄鐘規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/checkin/spec.md)" \
  --milestone "v0.4.0 - Pomodoro Feature" \
  --label "feature,priority: critical"

gh issue create --repo $REPO \
  --title "TimerService 實作 (Combine/AsyncSequence)" \
  --body "## 描述
實作 TimerService，使用 Combine 或 AsyncSequence。

## 任務
- [ ] 實作 TimerService
- [ ] 使用 Combine Timer 或 AsyncSequence
- [ ] 背景執行處理
- [ ] 撰寫測試

## 驗收標準
- 計時準確
- 背景運作正常
- 測試通過

## 技術細節
\`\`\`swift
class TimerService {
    func start(duration: TimeInterval) -> AsyncStream<TimeInterval>
}
\`\`\`

## 參考文件
- [番茄鐘規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/checkin/spec.md)" \
  --milestone "v0.4.0 - Pomodoro Feature" \
  --label "feature,priority: critical"

gh issue create --repo $REPO \
  --title "ScreenLockService 實作 (研究最佳方案)" \
  --body "## 描述
研究並實作螢幕保持常亮的最佳方案。

## 任務
- [ ] 研究 iOS 螢幕鎖定機制
- [ ] 評估 UIApplication.shared.isIdleTimerDisabled
- [ ] 評估其他方案
- [ ] 實作最佳方案
- [ ] 撰寫測試

## 驗收標準
- 螢幕保持常亮
- 不過度耗電
- 符合 App Store 審核標準

## 技術細節
\`\`\`swift
class ScreenLockService {
    func disableIdleTimer()
    func enableIdleTimer()
}
\`\`\`

## 參考文件
- [番茄鐘規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/checkin/spec.md)" \
  --milestone "v0.4.0 - Pomodoro Feature" \
  --label "feature,priority: high,research"

gh issue create --repo $REPO \
  --title "NotificationService 實作" \
  --body "## 描述
實作本地通知服務。

## 任務
- [ ] 實作 NotificationService
- [ ] 請求通知權限
- [ ] 排程通知
- [ ] 處理通知回應
- [ ] 撰寫測試

## 驗收標準
- 通知正常發送
- 權限處理正確
- 測試通過

## 參考文件
- [番茄鐘規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/checkin/spec.md)" \
  --milestone "v0.4.0 - Pomodoro Feature" \
  --label "feature,priority: medium"

# Application Layer
gh issue create --repo $REPO \
  --title "StartPomodoroCommand & Handler" \
  --body "## 描述
實作啟動番茄鐘的 Command 與 Handler。

## 任務
- [ ] 先撰寫測試
- [ ] 定義 StartPomodoroCommand
- [ ] 實作 Handler
- [ ] 業務邏輯驗證

## 驗收標準
- 測試先於實作
- 測試覆蓋率 ≥ 90%

## 技術細節
\`\`\`swift
struct StartPomodoroCommand {
    let habitId: UUID
    let duration: TimeInterval
}
\`\`\`

## 參考文件
- [番茄鐘規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/checkin/spec.md)" \
  --milestone "v0.4.0 - Pomodoro Feature" \
  --label "feature,priority: critical"

gh issue create --repo $REPO \
  --title "CompletePomodoroCommand & Handler" \
  --body "## 描述
實作完成番茄鐘的 Command 與 Handler。

## 任務
- [ ] 先撰寫測試
- [ ] 定義 CompletePomodoroCommand
- [ ] 實作 Handler
- [ ] 星星獎勵計算

## 驗收標準
- 測試先於實作
- 測試覆蓋率 ≥ 90%
- 獎勵計算正確

## 參考文件
- [番茄鐘規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/checkin/spec.md)" \
  --milestone "v0.4.0 - Pomodoro Feature" \
  --label "feature,priority: critical"

gh issue create --repo $REPO \
  --title "ExtendPomodoroCommand & Handler" \
  --body "## 描述
實作延長番茄鐘的 Command 與 Handler。

## 任務
- [ ] 先撰寫測試
- [ ] 定義 ExtendPomodoroCommand
- [ ] 實作 Handler
- [ ] 獎勵懲罰計算

## 驗收標準
- 測試先於實作
- 測試覆蓋率 ≥ 90%
- 懲罰計算正確

## 參考文件
- [番茄鐘規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/checkin/spec.md)" \
  --milestone "v0.4.0 - Pomodoro Feature" \
  --label "feature,priority: high"

gh issue create --repo $REPO \
  --title "TerminatePomodoroCommand & Handler" \
  --body "## 描述
實作提前終止番茄鐘的 Command 與 Handler。

## 任務
- [ ] 先撰寫測試
- [ ] 定義 TerminatePomodoroCommand
- [ ] 實作 Handler
- [ ] 確認對話處理

## 驗收標準
- 測試先於實作
- 測試覆蓋率 ≥ 90%

## 參考文件
- [番茄鐘規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/checkin/spec.md)" \
  --milestone "v0.4.0 - Pomodoro Feature" \
  --label "feature,priority: medium"

gh issue create --repo $REPO \
  --title "GetActivePomodoroQuery & Handler" \
  --body "## 描述
實作取得進行中番茄鐘的 Query 與 Handler。

## 任務
- [ ] 先撰寫測試
- [ ] 定義 GetActivePomodoroQuery
- [ ] 實作 Handler
- [ ] 狀態處理

## 驗收標準
- 測試先於實作
- 測試覆蓋率 ≥ 90%

## 參考文件
- [番茄鐘規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/checkin/spec.md)" \
  --milestone "v0.4.0 - Pomodoro Feature" \
  --label "feature,priority: high"

# Presentation Layer
gh issue create --repo $REPO \
  --title "PomodoroViewModel 實作與測試" \
  --body "## 描述
實作番茄鐘 ViewModel。

## 任務
- [ ] 先撰寫測試
- [ ] 實作 PomodoroViewModel
- [ ] 整合 Commands/Queries
- [ ] 計時器狀態管理
- [ ] UI 更新邏輯

## 驗收標準
- 測試先於實作
- 測試覆蓋率 ≥ 80%
- 狀態管理正確

## 參考文件
- [番茄鐘規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/checkin/spec.md)" \
  --milestone "v0.4.0 - Pomodoro Feature" \
  --label "feature,priority: critical"

gh issue create --repo $REPO \
  --title "PomodoroView UI (計時畫面)" \
  --body "## 描述
實作番茄鐘主要計時 UI。

## 任務
- [ ] 實作 PomodoroView
- [ ] 圓形進度環
- [ ] 時間顯示
- [ ] 控制按鈕
- [ ] 習慣資訊顯示

## 驗收標準
- UI 符合設計
- 動畫流暢
- 支援深色模式

## 參考文件
- [番茄鐘規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/checkin/spec.md)" \
  --milestone "v0.4.0 - Pomodoro Feature" \
  --label "feature,priority: critical"

gh issue create --repo $REPO \
  --title "PomodoroCompletionView UI" \
  --body "## 描述
實作番茄鐘完成畫面。

## 任務
- [ ] 實作 CompletionView
- [ ] 顯示獎勵資訊
- [ ] 慶祝動畫
- [ ] 返回按鈕

## 驗收標準
- UI 符合設計
- 動畫吸引人

## 參考文件
- [番茄鐘規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/checkin/spec.md)" \
  --milestone "v0.4.0 - Pomodoro Feature" \
  --label "feature,priority: high"

gh issue create --repo $REPO \
  --title "PomodoroExtensionSheet UI" \
  --body "## 描述
實作番茄鐘延長時間選擇 Sheet。

## 任務
- [ ] 實作 ExtensionSheet
- [ ] 時間選擇器
- [ ] 懲罰提示
- [ ] 確認/取消按鈕

## 驗收標準
- UI 符合設計
- 提示清晰

## 參考文件
- [番茄鐘規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/checkin/spec.md)" \
  --milestone "v0.4.0 - Pomodoro Feature" \
  --label "feature,priority: medium"

gh issue create --repo $REPO \
  --title "圓形進度環 Component" \
  --body "## 描述
實作可重用的圓形進度環 Component。

## 任務
- [ ] 實作 CircularProgressRing
- [ ] 動畫效果
- [ ] 可自訂顏色/大小
- [ ] 撰寫 Preview

## 驗收標準
- Component 可重用
- 動畫流暢
- Preview 正常

## 參考文件
- [番茄鐘規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/checkin/spec.md)" \
  --milestone "v0.4.0 - Pomodoro Feature" \
  --label "feature,priority: high"

# 整合測試
gh issue create --repo $REPO \
  --title "完整番茄鐘流程測試" \
  --body "## 描述
撰寫完整番茄鐘流程的整合測試。

## 任務
- [ ] 啟動到完成流程測試
- [ ] Repository 整合測試
- [ ] End-to-End 測試

## 驗收標準
- 整合測試通過
- 覆蓋主要流程

## 參考文件
- [番茄鐘規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/checkin/spec.md)" \
  --milestone "v0.4.0 - Pomodoro Feature" \
  --label "test,priority: high"

gh issue create --repo $REPO \
  --title "延長功能測試" \
  --body "## 描述
測試番茄鐘延長功能。

## 任務
- [ ] 延長流程測試
- [ ] 獎勵懲罰測試
- [ ] 邊界條件測試

## 驗收標準
- 測試通過
- 覆蓋所有情況

## 參考文件
- [番茄鐘規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/checkin/spec.md)" \
  --milestone "v0.4.0 - Pomodoro Feature" \
  --label "test,priority: medium"

gh issue create --repo $REPO \
  --title "提前終止測試" \
  --body "## 描述
測試番茄鐘提前終止功能。

## 任務
- [ ] 終止流程測試
- [ ] 確認對話測試
- [ ] 資料儲存測試

## 驗收標準
- 測試通過
- 資料正確儲存

## 參考文件
- [番茄鐘規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/checkin/spec.md)" \
  --milestone "v0.4.0 - Pomodoro Feature" \
  --label "test,priority: medium"

echo "✅ Milestone v0.4.0 的 Issues 建立完成!"
echo ""

# =============================================================================
# Milestone: v0.5.0 - Settings & Reward
# =============================================================================
echo "📋 建立 Milestone v0.5.0 - Settings & Reward 的 Issues..."

# Settings - Domain Layer
gh issue create --repo $REPO \
  --title "AppSettings Entity" \
  --body "## 描述
實作 AppSettings Entity。

## 任務
- [ ] 定義 AppSettings
- [ ] 番茄鐘設定
- [ ] 通知設定
- [ ] 語言設定

## 驗收標準
- Entity 定義完整
- 測試覆蓋率 ≥ 90%

## 參考文件
- [設定規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/settings/spec.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "feature,priority: high"

gh issue create --repo $REPO \
  --title "PomodoroSettings Value Object" \
  --body "## 描述
實作 PomodoroSettings Value Object。

## 任務
- [ ] 定義設定項目
- [ ] 預設值
- [ ] 驗證邏輯

## 驗收標準
- Value Object 完整
- 測試覆蓋率 ≥ 90%

## 參考文件
- [設定規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/settings/spec.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "feature,priority: high"

gh issue create --repo $REPO \
  --title "NotificationSettings Value Object" \
  --body "## 描述
實作 NotificationSettings Value Object。

## 任務
- [ ] 定義通知設定
- [ ] 時間設定
- [ ] 開關控制

## 驗收標準
- Value Object 完整
- 測試覆蓋率 ≥ 90%

## 參考文件
- [設定規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/settings/spec.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "feature,priority: medium"

# Settings - Infrastructure
gh issue create --repo $REPO \
  --title "UserDefaults Settings Repository" \
  --body "## 描述
實作基於 UserDefaults 的 Settings Repository。

## 任務
- [ ] 實作 Repository
- [ ] CRUD 操作
- [ ] 型別安全
- [ ] 撰寫測試

## 驗收標準
- Repository 可運作
- 測試覆蓋率 ≥ 90%

## 參考文件
- [設定規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/settings/spec.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "feature,priority: high"

gh issue create --repo $REPO \
  --title "設定預設值" \
  --body "## 描述
定義並實作所有設定的預設值。

## 任務
- [ ] 番茄鐘預設值
- [ ] 通知預設值
- [ ] 語言預設值
- [ ] 首次啟動處理

## 驗收標準
- 預設值合理
- 首次啟動正常

## 參考文件
- [設定規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/settings/spec.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "feature,priority: medium"

# Settings - Application Layer
gh issue create --repo $REPO \
  --title "UpdatePomodoroSettingsCommand" \
  --body "## 描述
實作更新番茄鐘設定的 Command。

## 任務
- [ ] 定義 Command
- [ ] 實作 Handler
- [ ] 驗證邏輯
- [ ] 撰寫測試

## 驗收標準
- Command 正常運作
- 測試覆蓋率 ≥ 90%

## 參考文件
- [設定規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/settings/spec.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "feature,priority: high"

gh issue create --repo $REPO \
  --title "UpdateNotificationSettingsCommand" \
  --body "## 描述
實作更新通知設定的 Command。

## 任務
- [ ] 定義 Command
- [ ] 實作 Handler
- [ ] 權限檢查
- [ ] 撰寫測試

## 驗收標準
- Command 正常運作
- 測試覆蓋率 ≥ 90%

## 參考文件
- [設定規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/settings/spec.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "feature,priority: medium"

gh issue create --repo $REPO \
  --title "UpdateLanguageCommand" \
  --body "## 描述
實作更新語言設定的 Command。

## 任務
- [ ] 定義 Command
- [ ] 實作 Handler
- [ ] 語言切換邏輯
- [ ] 撰寫測試

## 驗收標準
- 語言切換正常
- 測試覆蓋率 ≥ 90%

## 參考文件
- [設定規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/settings/spec.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "feature,priority: medium"

gh issue create --repo $REPO \
  --title "GetAppSettingsQuery" \
  --body "## 描述
實作取得應用程式設定的 Query。

## 任務
- [ ] 定義 Query
- [ ] 實作 Handler
- [ ] DTO 定義
- [ ] 撰寫測試

## 驗收標準
- Query 正常運作
- 測試覆蓋率 ≥ 90%

## 參考文件
- [設定規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/settings/spec.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "feature,priority: high"

# Settings - Presentation
gh issue create --repo $REPO \
  --title "SettingsViewModel" \
  --body "## 描述
實作設定頁面 ViewModel。

## 任務
- [ ] 實作 ViewModel
- [ ] 整合 Commands/Queries
- [ ] 狀態管理
- [ ] 撰寫測試

## 驗收標準
- ViewModel 正常運作
- 測試覆蓋率 ≥ 80%

## 參考文件
- [設定規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/settings/spec.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "feature,priority: high"

gh issue create --repo $REPO \
  --title "SettingsView UI" \
  --body "## 描述
實作設定主頁面 UI。

## 任務
- [ ] 實作 SettingsView
- [ ] 設定項目列表
- [ ] 導航到子頁面
- [ ] 版本資訊

## 驗收標準
- UI 符合設計
- 導航正常

## 參考文件
- [設定規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/settings/spec.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "feature,priority: high"

gh issue create --repo $REPO \
  --title "PomodoroSettingsView UI" \
  --body "## 描述
實作番茄鐘設定頁面 UI。

## 任務
- [ ] 實作 PomodoroSettingsView
- [ ] 時長設定
- [ ] 延長時間設定
- [ ] 獎勵設定

## 驗收標準
- UI 符合設計
- 設定儲存正常

## 參考文件
- [設定規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/settings/spec.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "feature,priority: high"

gh issue create --repo $REPO \
  --title "NotificationSettingsView UI" \
  --body "## 描述
實作通知設定頁面 UI。

## 任務
- [ ] 實作 NotificationSettingsView
- [ ] 權限請求
- [ ] 時間設定
- [ ] 開關控制

## 驗收標準
- UI 符合設計
- 權限處理正確

## 參考文件
- [設定規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/settings/spec.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "feature,priority: medium"

# Reward - Domain Layer
gh issue create --repo $REPO \
  --title "Reward Entity 實作" \
  --body "## 描述
實作 Reward Entity。

## 任務
- [ ] 定義 Reward struct
- [ ] 實作 Entity protocol
- [ ] 業務邏輯
- [ ] 撰寫測試

## 驗收標準
- Entity 完整
- 測試覆蓋率 ≥ 90%

## 技術細節
\`\`\`swift
struct Reward: Entity {
    let id: UUID
    var title: String
    var requiredStars: Int
    var isRedeemed: Bool
}
\`\`\`

## 參考文件
- [設定規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/settings/spec.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "feature,priority: high"

gh issue create --repo $REPO \
  --title "RewardRedemption Entity 實作" \
  --body "## 描述
實作 RewardRedemption Entity (兌換記錄)。

## 任務
- [ ] 定義 RewardRedemption struct
- [ ] 兌換記錄
- [ ] 時間戳
- [ ] 撰寫測試

## 驗收標準
- Entity 完整
- 測試覆蓋率 ≥ 90%

## 參考文件
- [設定規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/settings/spec.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "feature,priority: medium"

gh issue create --repo $REPO \
  --title "IRewardRepository Protocol" \
  --body "## 描述
定義 Reward Repository 介面。

## 任務
- [ ] 定義 Protocol
- [ ] CRUD 方法
- [ ] 查詢方法
- [ ] 撰寫文件

## 驗收標準
- Protocol 定義完整

## 參考文件
- [設定規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/settings/spec.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "feature,priority: high"

# Reward - Infrastructure
gh issue create --repo $REPO \
  --title "CoreData Reward Schema" \
  --body "## 描述
設計 CoreData Reward Schema。

## 任務
- [ ] 建立 RewardEntity
- [ ] 建立 RewardRedemptionEntity
- [ ] 定義關聯
- [ ] 索引優化

## 驗收標準
- Schema 設計完整

## 參考文件
- [設定規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/settings/spec.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "feature,priority: high"

gh issue create --repo $REPO \
  --title "RewardRepository 實作" \
  --body "## 描述
實作 RewardRepository。

## 任務
- [ ] 實作 Repository
- [ ] CRUD 操作
- [ ] 兌換邏輯
- [ ] 撰寫測試

## 驗收標準
- Repository 可運作
- 測試覆蓋率 ≥ 90%

## 參考文件
- [設定規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/settings/spec.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "feature,priority: high"

# Reward - Application Layer
gh issue create --repo $REPO \
  --title "CreateRewardCommand" \
  --body "## 描述
實作建立獎勵的 Command。

## 任務
- [ ] 定義 Command
- [ ] 實作 Handler
- [ ] 驗證邏輯
- [ ] 撰寫測試

## 驗收標準
- Command 正常運作
- 測試覆蓋率 ≥ 90%

## 參考文件
- [設定規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/settings/spec.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "feature,priority: high"

gh issue create --repo $REPO \
  --title "RedeemRewardCommand" \
  --body "## 描述
實作兌換獎勵的 Command。

## 任務
- [ ] 定義 Command
- [ ] 實作 Handler
- [ ] 星星扣除邏輯
- [ ] 撰寫測試

## 驗收標準
- Command 正常運作
- 測試覆蓋率 ≥ 90%
- 星星計算正確

## 參考文件
- [設定規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/settings/spec.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "feature,priority: critical"

gh issue create --repo $REPO \
  --title "GetAllRewardsQuery" \
  --body "## 描述
實作取得所有獎勵的 Query。

## 任務
- [ ] 定義 Query
- [ ] 實作 Handler
- [ ] DTO 轉換
- [ ] 撰寫測試

## 驗收標準
- Query 正常運作
- 測試覆蓋率 ≥ 90%

## 參考文件
- [設定規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/settings/spec.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "feature,priority: high"

# Reward - Presentation
gh issue create --repo $REPO \
  --title "RewardManagementViewModel" \
  --body "## 描述
實作獎勵管理 ViewModel。

## 任務
- [ ] 實作 ViewModel
- [ ] 整合 Commands/Queries
- [ ] 狀態管理
- [ ] 撰寫測試

## 驗收標準
- ViewModel 正常運作
- 測試覆蓋率 ≥ 80%

## 參考文件
- [設定規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/settings/spec.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "feature,priority: high"

gh issue create --repo $REPO \
  --title "RewardManagementView UI" \
  --body "## 描述
實作獎勵管理頁面 UI。

## 任務
- [ ] 實作 RewardManagementView
- [ ] 獎勵列表
- [ ] 新增/編輯獎勵
- [ ] 兌換功能
- [ ] 星星餘額顯示

## 驗收標準
- UI 符合設計
- 功能完整

## 參考文件
- [設定規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/settings/spec.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "feature,priority: high"

gh issue create --repo $REPO \
  --title "RewardRedemptionHistoryView" \
  --body "## 描述
實作獎勵兌換歷史頁面 UI。

## 任務
- [ ] 實作 HistoryView
- [ ] 兌換記錄列表
- [ ] 時間顯示
- [ ] 空狀態處理

## 驗收標準
- UI 符合設計
- 記錄正確顯示

## 參考文件
- [設定規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/settings/spec.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "feature,priority: low"

# 多語系
gh issue create --repo $REPO \
  --title "建立 Localizable.strings (繁中)" \
  --body "## 描述
建立繁體中文 Localizable.strings。

## 任務
- [ ] 建立 zh-Hant.lproj
- [ ] 翻譯所有字串
- [ ] 測試顯示

## 驗收標準
- 所有字串已翻譯
- 顯示正常

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "localization,priority: high"

gh issue create --repo $REPO \
  --title "建立 Localizable.strings (簡中)" \
  --body "## 描述
建立簡體中文 Localizable.strings。

## 任務
- [ ] 建立 zh-Hans.lproj
- [ ] 翻譯所有字串
- [ ] 測試顯示

## 驗收標準
- 所有字串已翻譯
- 顯示正常

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "localization,priority: high"

gh issue create --repo $REPO \
  --title "建立 Localizable.strings (英語)" \
  --body "## 描述
建立英語 Localizable.strings。

## 任務
- [ ] 建立 en.lproj
- [ ] 翻譯所有字串
- [ ] 測試顯示

## 驗收標準
- 所有字串已翻譯
- 顯示正常

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "localization,priority: high"

gh issue create --repo $REPO \
  --title "建立 Localizable.strings (日語)" \
  --body "## 描述
建立日語 Localizable.strings。

## 任務
- [ ] 建立 ja.lproj
- [ ] 翻譯所有字串
- [ ] 測試顯示

## 驗收標準
- 所有字串已翻譯
- 顯示正常

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "localization,priority: medium"

gh issue create --repo $REPO \
  --title "建立 Localizable.strings (韓語)" \
  --body "## 描述
建立韓語 Localizable.strings。

## 任務
- [ ] 建立 ko.lproj
- [ ] 翻譯所有字串
- [ ] 測試顯示

## 驗收標準
- 所有字串已翻譯
- 顯示正常

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v0.5.0 - Settings & Reward" \
  --label "localization,priority: medium"

echo "✅ Milestone v0.5.0 的 Issues 建立完成!"
echo ""

# =============================================================================
# Milestone: v0.6.0 - Home & Navigation
# =============================================================================
echo "📋 建立 Milestone v0.6.0 - Home & Navigation 的 Issues..."

# Home - Domain Layer
gh issue create --repo $REPO \
  --title "DailyOverview Aggregate" \
  --body "## 描述
實作 DailyOverview Aggregate。

## 任務
- [ ] 定義 DailyOverview
- [ ] 聚合今日資料
- [ ] 統計計算
- [ ] 撰寫測試

## 驗收標準
- Aggregate 完整
- 測試覆蓋率 ≥ 90%

## 參考文件
- [首頁規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/home/spec.md)" \
  --milestone "v0.6.0 - Home & Navigation" \
  --label "feature,priority: high"

gh issue create --repo $REPO \
  --title "WeeklyProgress Value Object" \
  --body "## 描述
實作 WeeklyProgress Value Object。

## 任務
- [ ] 定義 WeeklyProgress
- [ ] 週統計計算
- [ ] 趨勢分析
- [ ] 撰寫測試

## 驗收標準
- Value Object 完整
- 測試覆蓋率 ≥ 90%

## 參考文件
- [首頁規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/home/spec.md)" \
  --milestone "v0.6.0 - Home & Navigation" \
  --label "feature,priority: medium"

# Home - Application Layer
gh issue create --repo $REPO \
  --title "GetDailyOverviewQuery" \
  --body "## 描述
實作取得今日總覽的 Query。

## 任務
- [ ] 定義 Query
- [ ] 實作 Handler
- [ ] 資料聚合
- [ ] 撰寫測試

## 驗收標準
- Query 正常運作
- 測試覆蓋率 ≥ 90%

## 參考文件
- [首頁規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/home/spec.md)" \
  --milestone "v0.6.0 - Home & Navigation" \
  --label "feature,priority: high"

gh issue create --repo $REPO \
  --title "GetWeeklyProgressQuery" \
  --body "## 描述
實作取得週進度的 Query。

## 任務
- [ ] 定義 Query
- [ ] 實作 Handler
- [ ] 資料計算
- [ ] 撰寫測試

## 驗收標準
- Query 正常運作
- 測試覆蓋率 ≥ 90%

## 參考文件
- [首頁規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/home/spec.md)" \
  --milestone "v0.6.0 - Home & Navigation" \
  --label "feature,priority: medium"

# Home - Presentation
gh issue create --repo $REPO \
  --title "HomeViewModel" \
  --body "## 描述
實作首頁 ViewModel。

## 任務
- [ ] 實作 ViewModel
- [ ] 整合 Queries
- [ ] 狀態管理
- [ ] 撰寫測試

## 驗收標準
- ViewModel 正常運作
- 測試覆蓋率 ≥ 80%

## 參考文件
- [首頁規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/home/spec.md)" \
  --milestone "v0.6.0 - Home & Navigation" \
  --label "feature,priority: critical"

gh issue create --repo $REPO \
  --title "HomeView UI" \
  --body "## 描述
實作首頁 UI。

## 任務
- [ ] 實作 HomeView
- [ ] 今日總覽卡片
- [ ] 習慣列表
- [ ] 快速統計
- [ ] 下拉刷新

## 驗收標準
- UI 符合設計
- 互動流暢

## 參考文件
- [首頁規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/home/spec.md)" \
  --milestone "v0.6.0 - Home & Navigation" \
  --label "feature,priority: critical"

gh issue create --repo $REPO \
  --title "DailyOverviewCard Component" \
  --body "## 描述
實作今日總覽卡片 Component。

## 任務
- [ ] 實作 DailyOverviewCard
- [ ] 今日完成數
- [ ] 今日星星數
- [ ] 進度環

## 驗收標準
- Component 可重用
- UI 符合設計

## 參考文件
- [首頁規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/home/spec.md)" \
  --milestone "v0.6.0 - Home & Navigation" \
  --label "feature,priority: high"

gh issue create --repo $REPO \
  --title "TodayHabitListView Component" \
  --body "## 描述
實作今日習慣列表 Component。

## 任務
- [ ] 實作 TodayHabitListView
- [ ] 習慣項目顯示
- [ ] 快速啟動按鈕
- [ ] 空狀態

## 驗收標準
- Component 可用
- UI 符合設計

## 參考文件
- [首頁規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/home/spec.md)" \
  --milestone "v0.6.0 - Home & Navigation" \
  --label "feature,priority: high"

gh issue create --repo $REPO \
  --title "QuickStatsCard Component" \
  --body "## 描述
實作快速統計卡片 Component。

## 任務
- [ ] 實作 QuickStatsCard
- [ ] 週統計
- [ ] 月統計
- [ ] 趨勢顯示

## 驗收標準
- Component 可用
- 資料正確

## 參考文件
- [首頁規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/home/spec.md)" \
  --milestone "v0.6.0 - Home & Navigation" \
  --label "feature,priority: medium"

# Navigation
gh issue create --repo $REPO \
  --title "TabBarView 完整實作" \
  --body "## 描述
完整實作 TabBarView。

## 任務
- [ ] 整合所有 Tab
- [ ] 圖示與文字
- [ ] 選中狀態
- [ ] 動畫效果

## 驗收標準
- Tab Bar 完整
- 切換流暢

## 參考文件
- [首頁規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/home/spec.md)" \
  --milestone "v0.6.0 - Home & Navigation" \
  --label "feature,priority: critical"

gh issue create --repo $REPO \
  --title "Navigation Coordinator" \
  --body "## 描述
實作 Navigation Coordinator。

## 任務
- [ ] 實作 Coordinator
- [ ] 導航邏輯
- [ ] Deep Linking 準備
- [ ] 撰寫測試

## 驗收標準
- Coordinator 可用
- 導航正常

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v0.6.0 - Home & Navigation" \
  --label "feature,priority: high"

gh issue create --repo $REPO \
  --title "Deep Linking 支援 (基礎)" \
  --body "## 描述
實作基礎 Deep Linking 支援。

## 任務
- [ ] URL Scheme 設定
- [ ] 路由處理
- [ ] 導航邏輯
- [ ] 測試

## 驗收標準
- Deep Link 可運作
- 導航正確

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v0.6.0 - Home & Navigation" \
  --label "feature,priority: low"

# 整合
gh issue create --repo $REPO \
  --title "整合所有 Feature 到 Tab Bar" \
  --body "## 描述
將所有已完成的 Feature 整合到 Tab Bar。

## 任務
- [ ] Home Tab
- [ ] Habit Tab
- [ ] Pomodoro Tab
- [ ] Settings Tab
- [ ] 測試所有流程

## 驗收標準
- 所有 Tab 可用
- 導航正常

## 依賴
- v0.3.0, v0.4.0, v0.5.0

## 參考文件
- [首頁規格](https://github.com/intervalrain/TidalHabits/blob/main/docs/features/home/spec.md)" \
  --milestone "v0.6.0 - Home & Navigation" \
  --label "feature,priority: critical"

gh issue create --repo $REPO \
  --title "App 啟動流程" \
  --body "## 描述
實作 App 啟動流程。

## 任務
- [ ] Splash Screen
- [ ] 首次啟動引導
- [ ] 資料初始化
- [ ] 錯誤處理

## 驗收標準
- 啟動流暢
- 首次體驗良好

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v0.6.0 - Home & Navigation" \
  --label "feature,priority: high"

gh issue create --repo $REPO \
  --title "狀態管理整合" \
  --body "## 描述
整合全域狀態管理。

## 任務
- [ ] 使用者狀態
- [ ] 星星餘額
- [ ] 設定狀態
- [ ] 狀態同步

## 驗收標準
- 狀態管理正確
- 無資料不一致

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v0.6.0 - Home & Navigation" \
  --label "feature,priority: high"

# UI Polish
gh issue create --repo $REPO \
  --title "統一 UI 風格" \
  --body "## 描述
統一所有頁面的 UI 風格。

## 任務
- [ ] 顏色一致性檢查
- [ ] 字體一致性檢查
- [ ] 間距一致性檢查
- [ ] 元件一致性檢查

## 驗收標準
- UI 風格統一
- 設計系統完整

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v0.6.0 - Home & Navigation" \
  --label "ui,priority: medium"

gh issue create --repo $REPO \
  --title "動畫與轉場效果" \
  --body "## 描述
加入動畫與轉場效果。

## 任務
- [ ] 頁面轉場動畫
- [ ] 元素出現動畫
- [ ] 互動回饋動畫
- [ ] 性能優化

## 驗收標準
- 動畫流暢
- 無卡頓

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v0.6.0 - Home & Navigation" \
  --label "ui,priority: low"

gh issue create --repo $REPO \
  --title "空狀態處理" \
  --body "## 描述
為所有頁面加入空狀態處理。

## 任務
- [ ] 空習慣列表
- [ ] 空統計資料
- [ ] 空獎勵列表
- [ ] 引導文字

## 驗收標準
- 所有空狀態已處理
- 引導清晰

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v0.6.0 - Home & Navigation" \
  --label "ui,priority: medium"

echo "✅ Milestone v0.6.0 的 Issues 建立完成!"
echo ""

# =============================================================================
# Milestone: v1.0.0-beta.1 - MVP Beta
# =============================================================================
echo "📋 建立 Milestone v1.0.0-beta.1 - MVP Beta 的 Issues..."

gh issue create --repo $REPO \
  --title "完整功能測試" \
  --body "## 描述
對所有功能進行完整測試。

## 任務
- [ ] 習慣管理完整流程測試
- [ ] 番茄鐘完整流程測試
- [ ] 獎勵系統測試
- [ ] 設定功能測試
- [ ] 多語系測試

## 驗收標準
- 所有功能正常
- 無 Critical Bug

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v1.0.0-beta.1 - MVP Beta" \
  --label "test,priority: critical"

gh issue create --repo $REPO \
  --title "UI/UX Review" \
  --body "## 描述
全面 UI/UX 審查。

## 任務
- [ ] 設計一致性檢查
- [ ] 使用者體驗檢查
- [ ] 互動流暢度檢查
- [ ] 無障礙檢查

## 驗收標準
- UI/UX 符合標準
- 無明顯問題

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v1.0.0-beta.1 - MVP Beta" \
  --label "ui,priority: high"

gh issue create --repo $REPO \
  --title "效能優化" \
  --body "## 描述
優化 App 效能。

## 任務
- [ ] 啟動時間優化
- [ ] 頁面載入優化
- [ ] 記憶體使用優化
- [ ] 動畫效能優化
- [ ] 性能測試

## 驗收標準
- 啟動時間 < 2s
- 頁面切換流暢
- 記憶體使用合理

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v1.0.0-beta.1 - MVP Beta" \
  --label "performance,priority: high"

gh issue create --repo $REPO \
  --title "記憶體洩漏檢查" \
  --body "## 描述
檢查並修復記憶體洩漏。

## 任務
- [ ] Instruments 檢查
- [ ] 循環引用檢查
- [ ] 修復洩漏
- [ ] 驗證修復

## 驗收標準
- 無記憶體洩漏
- 記憶體穩定

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v1.0.0-beta.1 - MVP Beta" \
  --label "bug,priority: high"

gh issue create --repo $REPO \
  --title "無障礙支援檢查" \
  --body "## 描述
檢查並改善無障礙支援。

## 任務
- [ ] VoiceOver 測試
- [ ] 動態字型支援
- [ ] 顏色對比檢查
- [ ] 觸控目標大小檢查

## 驗收標準
- VoiceOver 可用
- 符合 WCAG 標準

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v1.0.0-beta.1 - MVP Beta" \
  --label "accessibility,priority: medium"

gh issue create --repo $REPO \
  --title "多語系完整性檢查" \
  --body "## 描述
檢查所有語言的完整性。

## 任務
- [ ] 檢查缺失翻譯
- [ ] 檢查翻譯準確性
- [ ] 檢查顯示問題
- [ ] 修正問題

## 驗收標準
- 所有語言完整
- 翻譯準確

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v1.0.0-beta.1 - MVP Beta" \
  --label "localization,priority: high"

gh issue create --repo $REPO \
  --title "Beta 測試文件準備" \
  --body "## 描述
準備 Beta 測試相關文件。

## 任務
- [ ] Beta 測試指南
- [ ] 問題回報指南
- [ ] FAQ 文件
- [ ] Release Notes

## 驗收標準
- 文件完整
- 說明清楚

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v1.0.0-beta.1 - MVP Beta" \
  --label "docs,priority: high"

gh issue create --repo $REPO \
  --title "TestFlight 設定" \
  --body "## 描述
設定 TestFlight 並上傳 Beta 版本。

## 任務
- [ ] App Store Connect 設定
- [ ] TestFlight 群組建立
- [ ] Build 上傳
- [ ] 邀請 Beta Tester

## 驗收標準
- TestFlight 可用
- Beta Tester 可下載

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v1.0.0-beta.1 - MVP Beta" \
  --label "deployment,priority: critical"

gh issue create --repo $REPO \
  --title "收集 Beta Tester 回饋" \
  --body "## 描述
收集並整理 Beta Tester 回饋。

## 任務
- [ ] 建立回饋表單
- [ ] 收集回饋
- [ ] 分類問題
- [ ] 優先級排序

## 驗收標準
- 回饋已收集
- 問題已分類

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v1.0.0-beta.1 - MVP Beta" \
  --label "feedback,priority: high"

gh issue create --repo $REPO \
  --title "Bug 修復 (批次)" \
  --body "## 描述
修復 Beta 測試發現的 Bug。

## 任務
- [ ] Critical Bug 修復
- [ ] High Priority Bug 修復
- [ ] Medium Priority Bug 修復
- [ ] 迴歸測試

## 驗收標準
- 所有 Critical Bug 已修復
- High Priority Bug 大部分已修復

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v1.0.0-beta.1 - MVP Beta" \
  --label "bug,priority: critical"

echo "✅ Milestone v1.0.0-beta.1 的 Issues 建立完成!"
echo ""

# =============================================================================
# Milestone: v1.0.0 - MVP Release
# =============================================================================
echo "📋 建立 Milestone v1.0.0 - MVP Release 的 Issues..."

gh issue create --repo $REPO \
  --title "Beta 回饋問題修復" \
  --body "## 描述
修復 Beta 測試回饋的剩餘問題。

## 任務
- [ ] 剩餘 Bug 修復
- [ ] UI 調整
- [ ] 體驗改善
- [ ] 最終測試

## 驗收標準
- 所有重要問題已修復
- Beta Tester 滿意

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v1.0.0 - MVP Release" \
  --label "bug,priority: high"

gh issue create --repo $REPO \
  --title "最終 UI 調整" \
  --body "## 描述
最終 UI 細節調整。

## 任務
- [ ] 視覺細節調整
- [ ] 動畫優化
- [ ] 文字調整
- [ ] 圖示調整

## 驗收標準
- UI 完美
- 符合設計稿

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v1.0.0 - MVP Release" \
  --label "ui,priority: medium"

gh issue create --repo $REPO \
  --title "App Store 資產準備 (截圖、預覽影片)" \
  --body "## 描述
準備 App Store 所需資產。

## 任務
- [ ] 截圖製作 (所有語言)
- [ ] 預覽影片製作
- [ ] App Icon 最終版
- [ ] 其他資產

## 驗收標準
- 所有資產齊全
- 符合 App Store 規範

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v1.0.0 - MVP Release" \
  --label "design,priority: critical"

gh issue create --repo $REPO \
  --title "App Store 描述撰寫 (多語言)" \
  --body "## 描述
撰寫 App Store 描述 (所有語言)。

## 任務
- [ ] 繁中描述
- [ ] 簡中描述
- [ ] 英語描述
- [ ] 日語描述
- [ ] 韓語描述
- [ ] 關鍵字優化

## 驗收標準
- 所有語言描述完整
- SEO 優化良好

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v1.0.0 - MVP Release" \
  --label "docs,localization,priority: high"

gh issue create --repo $REPO \
  --title "Privacy Policy 撰寫" \
  --body "## 描述
撰寫隱私權政策。

## 任務
- [ ] 資料收集說明
- [ ] 資料使用說明
- [ ] 第三方服務說明
- [ ] 法律審查

## 驗收標準
- Privacy Policy 完整
- 符合法規

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v1.0.0 - MVP Release" \
  --label "docs,legal,priority: critical"

gh issue create --repo $REPO \
  --title "使用說明撰寫" \
  --body "## 描述
撰寫 App 使用說明。

## 任務
- [ ] 功能介紹
- [ ] 使用教學
- [ ] 常見問題
- [ ] 多語言版本

## 驗收標準
- 使用說明完整
- 易於理解

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v1.0.0 - MVP Release" \
  --label "docs,priority: medium"

gh issue create --repo $REPO \
  --title "Release Notes 準備" \
  --body "## 描述
準備 v1.0.0 Release Notes。

## 任務
- [ ] 功能清單
- [ ] 改進說明
- [ ] 已知問題
- [ ] 多語言版本

## 驗收標準
- Release Notes 完整
- 所有語言齊全

## 參考文件
- [CHANGELOG](https://github.com/intervalrain/TidalHabits/blob/main/CHANGELOG.md)" \
  --milestone "v1.0.0 - MVP Release" \
  --label "docs,priority: high"

gh issue create --repo $REPO \
  --title "最終測試" \
  --body "## 描述
發布前最終測試。

## 任務
- [ ] 完整功能測試
- [ ] 多裝置測試
- [ ] 多語言測試
- [ ] 性能測試
- [ ] 無障礙測試

## 驗收標準
- 所有測試通過
- 無 Critical Bug

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v1.0.0 - MVP Release" \
  --label "test,priority: critical"

gh issue create --repo $REPO \
  --title "App Store 提交" \
  --body "## 描述
提交 App 到 App Store。

## 任務
- [ ] 最終 Build 上傳
- [ ] 資訊填寫
- [ ] 送審
- [ ] 處理審核問題

## 驗收標準
- App 成功提交
- 通過 App Store 審核

## 參考文件
- [開發規範](https://github.com/intervalrain/TidalHabits/blob/main/docs/dev/notes/development-standards.md)" \
  --milestone "v1.0.0 - MVP Release" \
  --label "deployment,priority: critical"

gh issue create --repo $REPO \
  --title "行銷準備" \
  --body "## 描述
準備發布行銷活動。

## 任務
- [ ] 社群媒體文案
- [ ] 宣傳圖片
- [ ] 發布計畫
- [ ] 媒體聯絡

## 驗收標準
- 行銷素材齊全
- 發布計畫完整

## 參考文件
- [README](https://github.com/intervalrain/TidalHabits/blob/main/README.md)" \
  --milestone "v1.0.0 - MVP Release" \
  --label "marketing,priority: low"

echo "✅ Milestone v1.0.0 的 Issues 建立完成!"
echo ""

echo "🎉 所有 Issues 建立完成!"
echo ""
echo "📊 統計:"
echo "  - v0.4.0 Pomodoro Feature: 22 Issues"
echo "  - v0.5.0 Settings & Reward: 29 Issues"
echo "  - v0.6.0 Home & Navigation: 18 Issues"
echo "  - v1.0.0-beta.1 MVP Beta: 10 Issues"
echo "  - v1.0.0 MVP Release: 10 Issues"
echo "  - 總計新增: 89 Issues"
echo ""
echo "📝 下一步:"
echo "1. 前往 GitHub 檢視所有 Issues: https://github.com/$REPO/issues"
echo "2. 前往 GitHub 檢視所有 Milestones: https://github.com/$REPO/milestones"
echo "3. 依照 Milestone 順序開始開發"
echo ""
echo "🚀 Ready to build TidalHabits!"
