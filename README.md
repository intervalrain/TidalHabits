# TidalHabits

一款專注於自律習慣養成的 iOS 應用程式，透過番茄鐘機制與獎勵系統，幫助使用者建立並維持良好習慣。

## 專案概述

TidalHabits 採用 Clean Architecture + CQRS 模式開發，以 feature-based 方式組織程式碼，確保高可維護性、可測試性與可擴展性。

### 核心功能

- **習慣管理**: 建立、編輯、刪除自訂習慣項目
- **番茄鐘**: 專注時段計時，螢幕鎖定，獎勵計算
- **統計分析**: 視覺化圖表呈現習慣執行數據
- **獎勵系統**: 星星累積與自訂獎勵兌換
- **行事曆**: GitHub 風格熱度圖與歷史記錄查詢
- **多語系**: 支援繁中、簡中、英語、日語、韓語

### 技術特點

- **架構**: Clean Architecture + CQRS
- **組織**: Feature-based 模組化
- **UI**: SwiftUI
- **資料**: CoreData + UserDefaults
- **測試**: TDD 開發流程，高測試覆蓋率
- **未來**: Apple Watch 整合

## 專案結構

```
TidalHabits/
├── src/                          # 原始碼
│   ├── App/                      # 應用程式進入點
│   ├── Core/                     # 核心共用模組 (DDD, Extensions, Utilities)
│   ├── Feature/                  # 功能模組 (Feature-based)
│   │   ├── CheckIn/             # 番茄鐘功能
│   │   ├── User/                # 使用者管理
│   │   ├── Habit/               # 習慣管理
│   │   ├── Statistic/           # 統計分析
│   │   └── Reward/              # 獎勵系統
│   └── Shared/                  # 共用元件 (Component, Localization, Navigation, Theme)
├── test/                         # 測試檔案
│   ├── Unit/                    # 單元測試
│   ├── Integration/             # 整合測試
│   └── E2E/                     # 端對端測試
├── docs/                         # 文件
│   ├── architecture.md          # 架構設計文件
│   ├── development-standards.md # 開發規範
│   └── features/                # 功能規格文件
├── scripts/                      # 建置與工具腳本
├── TidalHabits/                 # Xcode 專案目錄
├── README.md                    # 本文件
└── .gitignore
```

### Feature 模組結構

每個 Feature 模組遵循 Clean Architecture 分層:

```
Feature/Habit/
├── Application/          # CQRS Commands & Queries
├── Domain/              # 領域模型 (Entity, Value Object, Repository Interface)
├── Infrastructure/      # 技術實作 (Repository 實作, Data Source)
└── Presentation/        # UI (SwiftUI Views, ViewModels)
```

## 開始使用

> 📖 **快速指南**: 查看 [QUICK_START.md](QUICK_START.md) 獲取詳細的命令列操作說明

### 環境需求

- **Xcode**: 15.0+
- **iOS**: 16.0+
- **Swift**: 5.9+
- **macOS**: Ventura 13.0+
- **工具**: xcodegen (建議安裝: `brew install xcodegen`)

### 安裝步驟

1. Clone 專案

```bash
git clone git@github.com:intervalrain/TidalHabits.git
cd TidalHabits
```

2. 生成 Xcode 專案

```bash
# 使用腳本（推薦）
./scripts/rebuild-project.sh

# 或手動執行
xcodegen generate
sed -i '' 's/objectVersion = 77;/objectVersion = 56;/' TidalHabits.xcodeproj/project.pbxproj
```

3. 開啟 Xcode 專案

```bash
open TidalHabits.xcodeproj
```

4. 選擇目標裝置或模擬器

5. 建置並執行 (`⌘R`)

### 快速指令

```bash
# 執行測試
./scripts/test.sh

# 建置並執行 App（模擬器）
./scripts/run.sh

# 清理專案
./scripts/clean.sh
```

### 執行測試

```bash
# 使用腳本（推薦）
./scripts/test.sh

# 在 Xcode 中執行所有測試
⌘U

# 或使用完整命令列
xcodebuild \
  -project TidalHabits.xcodeproj \
  -scheme TidalHabits \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro' \
  -only-testing:TidalHabitsTests \
  test
```

📚 **詳細指南**:
- [Xcode CLI 完整操作指南](docs/dev/notes/xcode-cli-guide.md)
- [快速開始指南](QUICK_START.md)

## 開發規範

本專案採用嚴格的 TDD (Test-Driven Development) 流程:

### 開發流程

```
1. 定義規格 (Specification)
   ↓
2. 撰寫測試 (Write Tests)
   ↓
3. 實作功能 (Implementation)
   ↓
4. Code Review
   ↓
   ├─ Passed → 5. Commit
   └─ Failed → 返回步驟 1
```

詳細開發規範請參閱 [development-standards.md](docs/dev/notes/development-standards.md)

### 程式碼風格

- 遵循 [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- 使用 SwiftLint 檢查程式碼風格
- 所有 public API 必須有文件註解
- 禁止硬編碼字串 (使用多語系系統)

### Commit 訊息規範

採用 Conventional Commits:

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Type**:
- `feat`: 新功能
- `fix`: 錯誤修復
- `docs`: 文件更新
- `test`: 測試相關
- `refactor`: 重構

**範例**:
```
feat(habit): add create habit feature

實作建立習慣功能
- 新增 CreateHabitCommand
- 實作 HabitRepository
- 新增 HabitFormView

Closes #123
```

## 測試策略

### 測試覆蓋率目標

- **Domain Layer**: ≥ 90%
- **Application Layer**: ≥ 80%
- **Presentation Layer**: ≥ 60%
- **Overall**: ≥ 75%

### 測試類別

1. **Unit Tests**: 測試單一元件 (Domain, Application, ViewModel)
2. **Integration Tests**: 測試多個元件整合 (Repository, DataSource)
3. **UI Tests**: 測試使用者介面流程

## 文件

### 核心文件
- [架構設計](docs/architecture.md) - Clean Architecture + CQRS 詳細說明
- [開發規範](docs/dev/notes/development-standards.md) - 編碼規範、TDD 流程、測試規範
- [Git Flow](docs/dev/github/git-flow.md) - 分支策略、版本控制、CI/CD、Milestone 規劃
- [專案結構](docs/project-structure.md) - 目錄組織與命名慣例
- [快速開始](docs/dev/notes/getting-started.md) - 開發指南與實作範例
- [Milestone 規劃](docs/dev/milestones/phases/milestones.md) - 版本計畫與 Issue 追蹤

### 功能規格
- [功能概述](docs/features/overview.md) - 應用程式功能總覽
- [習慣管理規格](docs/features/habit/spec.md) - 習慣功能詳細規格
- [番茄鐘規格](docs/features/checkin/spec.md) - 番茄鐘功能詳細規格
- [設定規格](docs/features/settings/spec.md) - 設定與獎勵功能規格
- [統計規格](docs/features/statistics/spec.md) - 統計分析功能規格
- [行事曆規格](docs/features/calendar/spec.md) - 行事曆功能規格
- [首頁規格](docs/features/home/spec.md) - 首頁功能規格

## 多語系支援

應用程式支援以下語言:

- 🇹🇼 繁體中文 (zh-Hant)
- 🇨🇳 簡體中文 (zh-Hans)
- 🇺🇸 English (en)
- 🇯🇵 日本語 (ja)
- 🇰🇷 한국어 (ko)

所有使用者可見文字必須透過 `Localizable.strings` 處理。

## 依賴管理

使用 **Swift Package Manager (SPM)** 管理第三方依賴:

- 目前無外部依賴 (使用原生框架)
- 未來可能加入: Swift Charts (圖表)

## 貢獻指南

### 提交 Pull Request

1. Fork 專案
2. 建立 feature branch (`git checkout -b feature/AmazingFeature`)
3. 遵循開發流程 (定義規格 → 測試 → 實作 → Review)
4. Commit 變更 (`git commit -m 'feat(scope): add amazing feature'`)
5. Push 到分支 (`git push origin feature/AmazingFeature`)
6. 開啟 Pull Request

### Code Review Checklist

- [ ] 遵循 Clean Architecture 原則
- [ ] 測試覆蓋率達標
- [ ] 所有測試通過
- [ ] 無編譯警告
- [ ] 多語系文字已本地化
- [ ] 文件已更新

## Roadmap

### Phase 1 - MVP (v1.0)
- [x] 專案結構與文件
- [ ] 習慣管理 (CRUD)
- [ ] 番茄鐘核心功能
- [ ] 基礎統計
- [ ] 獎勵系統
- [ ] 多語系支援

### Phase 2 - Enhancement (v1.1)
- [ ] 行事曆熱度圖
- [ ] 進階統計圖表
- [ ] Widget 支援
- [ ] Siri Shortcuts
- [ ] 資料匯出

### Phase 3 - Watch Integration (v2.0)
- [ ] Apple Watch App
- [ ] Watch 獨立番茄鐘
- [ ] 同步與通知
- [ ] Complications

### Phase 4 - Advanced Features (v2.x)
- [ ] 習慣分類與標籤
- [ ] Focus Mode 整合
- [ ] iCloud 同步
- [ ] 社群功能 (可選)

## 授權

本專案採用 MIT 授權 - 詳見 [LICENSE](LICENSE) 檔案

## 聯絡方式

- **專案連結**: [https://github.com/intervalrain/TidalHabits](https://github.com/intervalrain/TidalHabits)
- **問題回報**: [Issues](https://github.com/intervalrain/TidalHabits/issues)
- **功能建議**: [Discussions](https://github.com/intervalrain/TidalHabits/discussions)

## 致謝

感謝所有貢獻者與使用者的支持!

---

**TidalHabits** - 潮汐般穩定的習慣養成 🌊
