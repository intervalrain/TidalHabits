# TidalHabits 開發規範

## 專案資訊

### 平台與技術
- **平台**: iOS (主要)、Apple Watch (未來整合)
- **語言**: Swift
- **UI Framework**: SwiftUI
- **最低支援版本**: iOS 16.0+
- **架構模式**: Clean Architecture + CQRS
- **組織方式**: Feature-based

### 多語系支援
專案必須支援以下語言:
1. 繁體中文 (zh-Hant)
2. 簡體中文 (zh-Hans)
3. English (en)
4. 日本語 (ja)
5. 한국어 (ko)

所有使用者可見文字必須透過 Localization 系統處理,禁止硬編碼字串。

## 開發流程 (Development Workflow)

本專案採用嚴格的 TDD (Test-Driven Development) 流程,確保程式碼品質與可維護性。

### 標準開發流程

```
┌─────────────────┐
│  1. 定義規格     │ ← Review Failed 時返回此步驟
│  (Spec)         │
└────────┬────────┘
         ↓
┌─────────────────┐
│  2. 撰寫測試     │
│  (Write Tests)  │
└────────┬────────┘
         ↓
┌─────────────────┐
│  3. 實作功能     │
│  (Implement)    │
└────────┬────────┘
         ↓
┌─────────────────┐
│  4. Code Review │
│                 │
└────────┬────────┘
         ↓
    ┌────┴────┐
    │ Passed? │
    └────┬────┘
         │
    ┌────┴─────────┐
    ↓              ↓
  [Yes]          [No]
    │              │
    ↓              └──→ 返回步驟 1
┌─────────────────┐
│  5. Commit      │
└─────────────────┘
```

### 步驟詳解

#### 1. 定義規格 (Specification)
**目的**: 明確定義功能需求與驗收標準

**產出**:
- 在 `docs/features/<feature-name>/` 建立規格文件
- 定義 User Story 或 Use Case
- 列出驗收條件 (Acceptance Criteria)
- 定義 API 介面 (如 Command/Query 結構)
- 識別需要的 Domain Model

**範例文件結構**:
```markdown
# Feature: 建立習慣

## User Story
作為使用者,我想要建立一個新的習慣,以便追蹤我的自律目標。

## Acceptance Criteria
- [ ] 使用者可以輸入習慣名稱
- [ ] 使用者可以設定習慣時長 (分鐘)
- [ ] 使用者可以選擇習慣圖示
- [ ] 使用者可以設定完成獎勵星星數
- [ ] 系統驗證輸入有效性
- [ ] 習慣成功儲存後返回習慣 ID

## API Design
**Command**: CreateHabitCommand
**Handler**: CreateHabitCommandHandler
**Domain**: Habit Entity, HabitRepository
```

**檢查點**:
- [ ] 需求明確且可測試
- [ ] 驗收標準具體
- [ ] 架構設計符合 Clean Architecture

#### 2. 撰寫測試 (Write Tests)
**目的**: 在實作前定義期望行為

**測試層級**:
1. **Unit Tests** (必須)
   - Domain Layer: 實體行為、業務規則
   - Application Layer: Command/Query Handler
   - Presentation Layer: ViewModel 邏輯

2. **Integration Tests** (視需求)
   - Repository 與 DataSource 整合
   - 跨層級整合測試

3. **UI Tests** (視需求)
   - 重要使用者流程

**測試撰寫原則**:
- 使用 Given-When-Then 結構
- 測試命名清晰描述情境
- 一個測試只驗證一個行為
- 測試必須可重複執行且獨立

**範例**:
```swift
// test/Unit/Domain/HabitTests.swift
func testCreateHabit_WhenValidInput_ShouldReturnHabit() {
    // Given
    let name = "運動"
    let duration: TimeInterval = 3600
    let stars = 10

    // When
    let habit = Habit(name: name, duration: duration, starsReward: stars)

    // Then
    XCTAssertEqual(habit.name, name)
    XCTAssertEqual(habit.duration, duration)
    XCTAssertEqual(habit.starsReward, stars)
}
```

**檢查點**:
- [ ] 測試覆蓋所有驗收條件
- [ ] 測試包含正常與異常情境
- [ ] 測試可執行 (此時應該是 Red 狀態)

#### 3. 實作功能 (Implementation)
**目的**: 實作功能使測試通過

**實作順序** (由內而外):
1. **Domain Layer**: Entity, Value Object, Domain Service
2. **Infrastructure Layer**: Repository 實作
3. **Application Layer**: Command/Query Handler
4. **Presentation Layer**: ViewModel, View

**實作原則**:
- 只寫讓測試通過的最少程式碼
- 遵循 SOLID 原則
- 保持函數簡短且單一職責
- 適當的錯誤處理

**檢查點**:
- [ ] 所有測試通過 (Green)
- [ ] 沒有多餘的程式碼
- [ ] 遵循專案編碼規範
- [ ] 適當的註解與文件

#### 4. Code Review
**目的**: 確保程式碼品質與架構一致性

**Review 重點**:

**架構層面**:
- [ ] 依賴方向正確 (Presentation → Application → Domain ← Infrastructure)
- [ ] 業務邏輯在 Domain Layer
- [ ] 沒有跨層級直接依賴
- [ ] CQRS 模式正確使用

**程式碼品質**:
- [ ] 命名清晰且有意義
- [ ] 函數職責單一
- [ ] 沒有重複程式碼
- [ ] 錯誤處理完整
- [ ] 沒有 force unwrap 在不安全處

**測試品質**:
- [ ] 測試覆蓋率達標
- [ ] 測試有意義且不脆弱
- [ ] 測試命名清晰

**多語系**:
- [ ] UI 文字已本地化
- [ ] 支援所有指定語言

**效能**:
- [ ] 沒有明顯效能問題
- [ ] 適當使用 async/await
- [ ] 避免主執行緒阻塞

**Review 結果**:
- **Passed**: 進入 Commit 階段
- **Failed**: 返回「定義規格」重新審視需求與設計

#### 5. Commit
**目的**: 將變更提交至版本控制

**Commit 前檢查**:
- [ ] 所有測試通過
- [ ] 沒有編譯警告
- [ ] Code Review 已通過
- [ ] 相關文件已更新

**Commit 訊息格式**:
```
<type>(<scope>): <subject>

<body>

<footer>
```

**Commit 後**:
- Push 至 feature branch
- 建立或更新 Pull Request
- 等待 CI/CD 檢查通過
- 合併至 develop branch

### Review Failed 處理流程

當 Code Review 失敗時:

1. **分析失敗原因**
   - 架構設計問題 → 返回規格定義
   - 實作細節問題 → 可在實作階段修正
   - 測試不足 → 補充測試

2. **重新定義規格** (如需要)
   - 與團隊討論問題點
   - 更新規格文件
   - 重新評估設計方案

3. **重新開始流程**
   - 從步驟 1 開始
   - 確保問題被正確解決

### 流程範例

**Feature**: 新增建立習慣功能

1. **定義規格**
   - 撰寫 `docs/features/habit/create-habit-spec.md`
   - 定義 CreateHabitCommand 結構
   - 確認驗收條件

2. **撰寫測試**
   - `HabitEntityTests.swift`
   - `CreateHabitCommandHandlerTests.swift`
   - `HabitRepositoryTests.swift`
   - 執行測試 → Red ❌

3. **實作功能**
   - 實作 Habit Entity
   - 實作 HabitRepository
   - 實作 CreateHabitCommandHandler
   - 執行測試 → Green ✅

4. **Code Review**
   - 提交 PR
   - 團隊成員 review
   - 發現 Domain 邏輯洩漏到 Presentation
   - Review Failed ❌ → 返回步驟 1

5. **重新定義規格**
   - 修正架構設計
   - 重新分配職責
   - 重新執行流程 2-4
   - Review Passed ✅

6. **Commit**
   - `git commit -m "feat(habit): add create habit feature"`
   - Push 並合併

## 程式碼規範

### Swift Style Guide
遵循 [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)

#### 命名規範
- **型別**: PascalCase (如 `HabitEntity`, `PomodoroSession`)
- **變數/函數**: camelCase (如 `createHabit()`, `totalStars`)
- **常數**: camelCase 或 UPPER_SNAKE_CASE
- **Protocol**: 使用 `I` 前綴 (如 `IHabitRepository`) 或描述性名稱 (如 `Identifiable`)
- **Private 成員**: 使用 `_` 前綴 (可選,視團隊慣例)

#### 檔案組織
- 每個檔案只包含一個主要型別
- 相關的 extension 可以在同一檔案或獨立檔案
- 使用 `// MARK: -` 分隔程式碼區塊

```swift
// MARK: - Properties
// MARK: - Initialization
// MARK: - Public Methods
// MARK: - Private Methods
```

### 註解規範
- 使用 Swift Documentation 格式 (`///`)
- 所有 public API 必須有文件註解
- 複雜邏輯必須加上說明註解

```swift
/// 建立新的習慣
/// - Parameters:
///   - name: 習慣名稱
///   - duration: 持續時間 (秒)
///   - starsReward: 獎勵星星數
/// - Returns: 建立的習慣 ID
/// - Throws: `HabitError.invalidDuration` 如果時間無效
func createHabit(name: String, duration: TimeInterval, starsReward: Int) async throws -> UUID
```

## Git 工作流程

### 分支策略
- `main`: 穩定版本分支
- `develop`: 開發分支
- `feature/<feature-name>`: 功能開發分支
- `bugfix/<bug-name>`: 錯誤修復分支
- `release/<version>`: 發布準備分支

### Commit 訊息規範
採用 Conventional Commits 格式:

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Type**:
- `feat`: 新功能
- `fix`: 錯誤修復
- `docs`: 文件更新
- `style`: 程式碼格式 (不影響功能)
- `refactor`: 重構
- `test`: 測試相關
- `chore`: 建置工具、依賴更新

**範例**:
```
feat(habit): add pomodoro timer lock screen feature

實作番茄鐘期間的螢幕鎖定功能
- 新增螢幕鎖定機制
- 實作強制終止提醒
- 計算星星數扣除邏輯

Closes #123
```

### Pull Request 規範
- PR 標題遵循 commit 訊息格式
- 必須包含功能說明與測試計畫
- 至少一位團隊成員 review
- 通過所有 CI 檢查才能合併

## 測試規範

### 測試覆蓋率目標
- **Domain Layer**: ≥ 90%
- **Application Layer**: ≥ 80%
- **Presentation Layer**: ≥ 60%
- **Overall**: ≥ 75%

### 測試命名
```swift
// Given_When_Then 模式
func testCreateHabit_WhenValidInput_ShouldReturnHabitId()
func testStartPomodoro_WhenAlreadyRunning_ShouldThrowError()
```

### 測試類別
1. **Unit Tests**: 測試單一元件
2. **Integration Tests**: 測試多個元件整合
3. **UI Tests**: 測試使用者介面流程
4. **Snapshot Tests**: 測試 UI 視覺回歸 (可選)

## 依賴管理

### 套件管理工具
- 使用 **Swift Package Manager (SPM)** 作為主要套件管理工具
- 避免不必要的第三方依賴

### 允許的第三方套件範圍
- 網路請求: Alamofire (如需要)
- 圖表: Swift Charts (iOS 16+)
- 其他依賴需經團隊討論核准

## 資料持久化

### 資料儲存方案
- **CoreData**: 主要資料 (習慣、統計、獎勵)
- **UserDefaults**: 設定與偏好
- **Keychain**: 敏感資料 (如有)

### 資料遷移
- 每次 schema 變更必須提供 migration 策略
- 必須在 docs/ 記錄遷移腳本

## 效能規範

### 必須遵守的效能指標
- App 啟動時間 < 2 秒
- 畫面切換動畫流暢 (60 FPS)
- 記憶體使用量合理 (避免 memory leak)
- 背景任務不影響前景效能

### 最佳化原則
- 使用 lazy loading
- 圖片適當壓縮
- 避免在主執行緒執行耗時操作
- 使用 Instruments 定期 profiling

## 無障礙設計 (Accessibility)

### 必須支援
- VoiceOver
- Dynamic Type (字體大小調整)
- 高對比度模式
- 減少動態效果

### 實作要求
- 所有 UI 元件必須有適當的 accessibility label
- 支援鍵盤導航
- 確保色彩對比符合 WCAG AA 標準

## 隱私與安全

### 資料隱私
- 所有資料本地儲存,不上傳雲端 (除非明確功能需求)
- 遵守 Apple 隱私政策
- 在 Privacy Manifest 宣告資料使用

### 安全最佳實踐
- 敏感資料使用 Keychain
- 避免在 log 輸出敏感資訊
- 定期審查第三方套件安全性

## Code Review Checklist

### 提交前檢查
- [ ] 遵循架構規範 (Clean Architecture + CQRS)
- [ ] 所有 public API 有文件註解
- [ ] 新增對應的單元測試
- [ ] 多語系文字已本地化
- [ ] 無 Swift 編譯警告
- [ ] 通過 SwiftLint 檢查 (如有使用)
- [ ] 無 force unwrap (`!`) 在非安全情境
- [ ] 適當的錯誤處理

### Review 時檢查
- [ ] 業務邏輯是否在正確的層級
- [ ] 依賴方向是否正確
- [ ] 是否有重複程式碼可抽取
- [ ] 命名是否清晰易懂
- [ ] 效能是否有問題
- [ ] 有無潛在的記憶體洩漏

## 文件規範

### 必須維護的文件
- `README.md`: 專案概述、安裝與執行指南
- `docs/architecture.md`: 架構設計
- `docs/development-standards.md`: 開發規範 (本文件)
- `docs/features/`: 各功能模組詳細規格
- `docs/api/`: API 文件 (如有後端)
- `CHANGELOG.md`: 版本更新記錄

### 文件更新時機
- 新增或修改功能時,同步更新文件
- 架構調整時,更新架構文件
- 發布新版本時,更新 CHANGELOG

## 發布流程

### 版本號規範
遵循 Semantic Versioning (SemVer):
- `MAJOR.MINOR.PATCH` (如 `1.2.3`)
- MAJOR: 不相容的 API 變更
- MINOR: 新增向下相容的功能
- PATCH: 向下相容的錯誤修復

### 發布檢查清單
- [ ] 所有測試通過
- [ ] 更新版本號
- [ ] 更新 CHANGELOG.md
- [ ] 建立 release tag
- [ ] 提交 App Store
- [ ] 準備 release notes (多語系)

## 開發工具

### 推薦 Xcode Extensions/Tools
- SwiftLint: 程式碼風格檢查
- SwiftFormat: 自動格式化
- Instruments: 效能分析

### IDE 設定
- 縮排: 4 個空格
- 行寬限制: 120 字元
- 尾隨空格: 自動移除
