# TidalHabits Git Flow 規範

## 概述

本專案採用 **Git Flow** 變體,結合 CI/CD 自動化流程,確保程式碼品質與發布流程的穩定性。

## 分支策略

### 主要分支 (長期分支)

```
main (生產環境)
  ↑
  │ (merge via PR, trigger CI/CD)
  │
develop (開發主線)
  ↑
  │ (merge via PR after review)
  │
feature/* (功能開發)
```

#### 1. `main` 分支
- **用途**: 生產環境程式碼,隨時可發布
- **保護規則**:
  - ✅ 禁止直接 push
  - ✅ 必須透過 PR 合併
  - ✅ 需要至少 1 人 approve
  - ✅ 必須通過所有 CI 檢查
  - ✅ 需要 linear history (使用 squash merge 或 rebase)
- **自動觸發**:
  - CI/CD 建置與測試
  - 自動部署到 TestFlight (Beta)
  - 自動建立 Git Tag (版本號)
- **合併來源**: `release/*` 或 `hotfix/*`

#### 2. `develop` 分支
- **用途**: 開發主線,整合所有已完成的功能
- **保護規則**:
  - ✅ 禁止直接 push
  - ✅ 必須透過 PR 合併
  - ✅ 需要 Code Review
  - ✅ 必須通過所有測試
- **自動觸發**:
  - CI 建置與測試
  - 程式碼品質檢查 (SwiftLint)
- **合併來源**: `feature/*`, `bugfix/*`, `release/*` (反向合併)

### 輔助分支 (臨時分支)

#### 3. `feature/*` 分支
- **命名格式**: `feature/<issue-number>-<short-description>`
  - 範例: `feature/12-habit-management`
  - 範例: `feature/34-pomodoro-timer`
- **分支來源**: `develop`
- **合併目標**: `develop`
- **生命週期**: 功能開發完成後刪除
- **命名規則**:
  - 使用小寫與連字號
  - 包含 Issue 編號 (如有)
  - 描述要簡短且清楚

```bash
# 建立 feature branch
git checkout develop
git pull origin develop
git checkout -b feature/12-habit-management

# 開發完成後合併
# (透過 PR,不直接 merge)
```

#### 4. `release/*` 分支
- **命名格式**: `release/<version>`
  - 範例: `release/1.0.0`
  - 範例: `release/1.1.0-beta.1`
- **分支來源**: `develop`
- **合併目標**: `main` 和 `develop` (雙向合併)
- **用途**:
  - 準備發布版本
  - 修復發布前的小 bug
  - 更新版本號
  - 更新 CHANGELOG
- **生命週期**: 發布完成後刪除
- **自動觸發**: CI/CD 完整測試流程

```bash
# 建立 release branch
git checkout develop
git pull origin develop
git checkout -b release/1.0.0

# 更新版本號與 CHANGELOG
# 修復 bug (如有)
# 測試通過後,發 PR 到 main 和 develop
```

#### 5. `hotfix/*` 分支
- **命名格式**: `hotfix/<version>-<description>`
  - 範例: `hotfix/1.0.1-critical-crash-fix`
- **分支來源**: `main`
- **合併目標**: `main` 和 `develop`
- **用途**: 緊急修復生產環境問題
- **生命週期**: 修復完成後刪除

```bash
# 建立 hotfix branch
git checkout main
git pull origin main
git checkout -b hotfix/1.0.1-critical-crash-fix

# 修復問題
# 測試通過後,發 PR 到 main 和 develop
```

#### 6. `bugfix/*` 分支
- **命名格式**: `bugfix/<issue-number>-<description>`
  - 範例: `bugfix/56-fix-timer-calculation`
- **分支來源**: `develop`
- **合併目標**: `develop`
- **用途**: 修復開發環境的 bug (非生產環境)

## Git Flow 視覺化

```
main      ●────────●────────────────●──────────●────→ (v1.0.0, v1.1.0)
          │        ↑                ↑          ↑
          │        │ (merge)        │          │
release   │        ●────────●       │          ●────●
          │       ↗          ↘      │         ↗      ↘
develop   ●──●───●────●───●───●────●────●───●────────●────→
           ↗  ↖  ↗    ↖  ↗     ↖  ↗     ↖
feature  ●─●  ●─●    ●─●       ●─●       ...
         (1)  (2)    (3)       (4)

(1) feature/habit-management
(2) feature/pomodoro-timer
(3) bugfix/fix-validation
(4) feature/statistics
```

## 版本控制策略

### Semantic Versioning (SemVer)

格式: `MAJOR.MINOR.PATCH[-PRERELEASE]`

```
1.0.0       - 正式版本
1.1.0       - 新增功能 (向下相容)
1.0.1       - Bug 修復
1.0.0-beta.1 - Beta 測試版
1.0.0-rc.1  - Release Candidate
```

#### MAJOR (主版本號)
- 重大架構變更
- 不相容的 API 變更
- 重新設計的 UI/UX

#### MINOR (次版本號)
- 新增功能 (向下相容)
- 新增 Feature
- 效能改進

#### PATCH (修補版本號)
- Bug 修復
- 小幅優化
- 文件更新

#### PRERELEASE (預發布版本)
- `alpha` - 內部測試
- `beta` - 公開測試
- `rc` (Release Candidate) - 發布候選

### 版本號範例

```
0.1.0       - 初始開發版本
0.2.0       - 新增功能
1.0.0-beta.1 - 第一個 Beta 版
1.0.0-rc.1  - Release Candidate
1.0.0       - 正式發布 (MVP)
1.1.0       - 新增統計功能
1.0.1       - 修復 Bug
2.0.0       - 加入 Apple Watch 支援 (重大更新)
```

## Git Tag 策略

### Tag 時機

#### 自動 Tag (CI/CD)
當 PR 合併到 `main` 時,自動建立 tag:

```yaml
# .github/workflows/release.yml (範例)
on:
  push:
    branches:
      - main

jobs:
  release:
    runs-on: macos-latest
    steps:
      - name: Create Git Tag
        run: |
          VERSION=$(cat version.txt)
          git tag -a "v$VERSION" -m "Release version $VERSION"
          git push origin "v$VERSION"
```

#### 手動 Tag
特殊情況下手動建立:

```bash
# 建立 annotated tag
git tag -a v1.0.0 -m "Release version 1.0.0 - MVP"
git push origin v1.0.0

# 建立 lightweight tag (不推薦用於 release)
git tag v1.0.0-beta.1
git push origin v1.0.0-beta.1
```

### Tag 命名規則

```
v1.0.0           - 正式版本
v1.0.0-beta.1    - Beta 版本
v1.0.0-rc.1      - Release Candidate
v1.0.0-hotfix    - Hotfix 版本 (不推薦,應使用 v1.0.1)
```

### Tag 與分支對應

| Tag | 分支來源 | 說明 |
|-----|---------|------|
| v0.x.x | develop | 開發版本 |
| v1.0.0-beta.x | release/1.0.0 | Beta 測試 |
| v1.0.0-rc.x | release/1.0.0 | Release Candidate |
| v1.0.0 | main | 正式發布 |
| v1.0.1 | main (hotfix) | Hotfix 版本 |

## CI/CD Pipeline

### 自動化流程

#### 1. Feature Branch (開發階段)
```yaml
on:
  push:
    branches:
      - 'feature/**'
  pull_request:
    branches:
      - develop

jobs:
  build-and-test:
    - ✅ 編譯檢查
    - ✅ 執行單元測試
    - ✅ SwiftLint 檢查
    - ✅ 測試覆蓋率檢查 (≥ 75%)
```

#### 2. Develop Branch (整合階段)
```yaml
on:
  push:
    branches:
      - develop

jobs:
  integration:
    - ✅ 完整建置
    - ✅ 執行所有測試 (Unit + Integration)
    - ✅ 程式碼品質分析
    - ✅ 產生測試報告
    - ✅ 部署到內部測試環境 (可選)
```

#### 3. Release Branch (準備發布)
```yaml
on:
  push:
    branches:
      - 'release/**'

jobs:
  prepare-release:
    - ✅ 完整建置與測試
    - ✅ E2E 測試
    - ✅ 效能測試
    - ✅ 產生 Beta 版本
    - ✅ 上傳到 TestFlight (Beta)
    - ✅ 通知測試團隊
```

#### 4. Main Branch (正式發布)
```yaml
on:
  push:
    branches:
      - main

jobs:
  release:
    - ✅ 完整建置
    - ✅ 所有測試
    - ✅ 建立 Git Tag (自動版本號)
    - ✅ 產生 Release Notes
    - ✅ 上傳到 TestFlight (Production)
    - ✅ 更新 CHANGELOG
    - ✅ 建立 GitHub Release
    - ✅ 通知團隊
```

### CI/CD 工具選擇

推薦使用:
- **GitHub Actions** (推薦) - 與 GitHub 整合良好
- **Bitrise** - 專為 iOS 優化
- **Xcode Cloud** - Apple 官方 CI/CD

## Milestone 規劃

### Milestone 定義

每個 Milestone 對應一個發布版本,包含多個相關 Issue。

### Milestone 結構

```
Milestone: v1.0.0 - MVP
├── Due Date: 2025-12-31
├── Description: 最小可行產品,包含核心功能
└── Issues:
    ├── #1 - 建立專案架構
    ├── #2 - 實作 Habit Feature
    ├── #3 - 實作 Pomodoro Feature
    ├── #4 - 實作 Settings Feature
    ├── #5 - 實作 Home Feature
    └── #6 - 多語系支援
```

### Milestone 命名規則

```
v1.0.0 - MVP
v1.1.0 - Statistics & Calendar
v2.0.0 - Apple Watch Support
```

### Milestone 與 Phase 對應

| Phase | Milestone | 版本 | 目標 |
|-------|-----------|------|------|
| Phase 1 | MVP | v1.0.0 | 核心功能 |
| Phase 2 | Enhancement | v1.1.0 | 進階功能 |
| Phase 3 | Watch Integration | v2.0.0 | Apple Watch |
| Phase 4 | Advanced Features | v2.x | 進階特性 |

## Phase 詳細規劃

### Phase 1: MVP (v0.1.0 → v1.0.0)

**目標**: 建立最小可行產品

#### v0.1.0 - 專案基礎
- ✅ 專案結構建立
- ✅ 文件完成
- [ ] Core 模組實作

#### v0.2.0 - Habit Feature
- [ ] Habit Domain 實作
- [ ] Habit Repository 實作
- [ ] Habit UI 實作
- [ ] 單元測試完成

#### v0.3.0 - Pomodoro Feature
- [ ] Pomodoro Domain 實作
- [ ] 計時器服務實作
- [ ] Pomodoro UI 實作
- [ ] 螢幕鎖定機制

#### v0.4.0 - Settings & Reward
- [ ] Settings 實作
- [ ] Reward 系統實作
- [ ] 多語系資源完成

#### v0.5.0 - Home & Navigation
- [ ] Home UI 實作
- [ ] Tab Bar 導航
- [ ] 主題系統

#### v1.0.0-beta.1 → v1.0.0-rc.1 → v1.0.0
- [ ] 完整測試
- [ ] Bug 修復
- [ ] 效能優化
- [ ] 正式發布

**Timeline**: 3-4 個月

### Phase 2: Enhancement (v1.1.0 → v1.5.0)

**目標**: 新增進階功能

#### v1.1.0 - Statistics
- [ ] Statistics Feature 實作
- [ ] Swift Charts 整合
- [ ] 圖表 UI

#### v1.2.0 - Calendar
- [ ] Calendar Feature 實作
- [ ] 熱度圖實作
- [ ] 歷史記錄查詢

#### v1.3.0 - Widget
- [ ] Today Widget
- [ ] 資料同步

#### v1.4.0 - Shortcuts
- [ ] Siri Shortcuts 整合
- [ ] 快速操作

#### v1.5.0 - Data Export
- [ ] 資料匯出功能
- [ ] CSV/JSON 格式
- [ ] 分享功能

**Timeline**: 2-3 個月

### Phase 3: Watch Integration (v2.0.0)

**目標**: Apple Watch 支援

#### v2.0.0-alpha.x
- [ ] Watch App 基礎
- [ ] 資料同步機制

#### v2.0.0-beta.x
- [ ] Watch 獨立計時
- [ ] Complications
- [ ] 通知整合

#### v2.0.0
- [ ] 完整 Watch 支援
- [ ] 雙向同步
- [ ] 正式發布

**Timeline**: 2-3 個月

### Phase 4: Advanced Features (v2.x)

**目標**: 進階特性與優化

- v2.1.0 - 習慣分類與標籤
- v2.2.0 - Focus Mode 整合
- v2.3.0 - iCloud 同步
- v2.4.0 - 社群功能 (可選)
- v3.0.0 - 重大重構或新平台支援

**Timeline**: 持續迭代

## 發布流程

### 完整發布流程

#### 1. 準備發布 (從 develop 建立 release branch)

```bash
# 1. 確保 develop 是最新的
git checkout develop
git pull origin develop

# 2. 建立 release branch
git checkout -b release/1.0.0

# 3. 更新版本號
# 編輯 TidalHabits/Info.plist 或 version.txt
echo "1.0.0" > version.txt

# 4. 更新 CHANGELOG.md
# 新增本版本的變更記錄

# 5. Commit
git add .
git commit -m "chore(release): prepare release 1.0.0"

# 6. Push release branch
git push origin release/1.0.0
```

#### 2. 測試與修復

```bash
# 在 release/1.0.0 分支上
# - 執行完整測試
# - 修復發現的 bug (小 bug)
# - 每次 commit 觸發 CI/CD

# 如有 bug 修復
git commit -m "fix(release): fix timer display issue"
git push origin release/1.0.0
```

#### 3. 發布到 Main (透過 PR)

```bash
# 1. 建立 PR: release/1.0.0 → main
# Title: "Release v1.0.0"
# Description: 包含 CHANGELOG 內容

# 2. Code Review & Approval

# 3. Merge to main (Squash Merge)
# CI/CD 自動:
# - 建置 & 測試
# - 建立 Git Tag v1.0.0
# - 上傳 TestFlight
# - 建立 GitHub Release
```

#### 4. 反向合併到 Develop

```bash
# release branch 也要合併回 develop
# 建立 PR: release/1.0.0 → develop

# 合併後刪除 release branch
git branch -d release/1.0.0
git push origin --delete release/1.0.0
```

### Hotfix 發布流程

```bash
# 1. 從 main 建立 hotfix branch
git checkout main
git pull origin main
git checkout -b hotfix/1.0.1-timer-crash

# 2. 修復問題
# ... 修改程式碼 ...
git commit -m "fix(pomodoro): fix timer crash on background"

# 3. 更新版本號
echo "1.0.1" > version.txt
git commit -m "chore(release): bump version to 1.0.1"

# 4. 建立 PR 到 main 和 develop
# PR 1: hotfix/1.0.1-timer-crash → main
# PR 2: hotfix/1.0.1-timer-crash → develop

# 5. 合併後自動建立 tag v1.0.1
```

## CHANGELOG 管理

### CHANGELOG.md 格式

```markdown
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Feature in development

## [1.0.0] - 2025-12-31

### Added
- 習慣管理功能 (CRUD)
- 番茄鐘計時功能
- 獎勵系統
- 多語系支援 (繁中、簡中、英、日、韓)
- 首頁總覽

### Changed
- 優化 UI 動畫效果

### Fixed
- 修復計時器在背景模式的問題

## [0.5.0] - 2025-11-30

### Added
- Home 頁面實作
- Tab Bar 導航

## [0.1.0] - 2025-10-28

### Added
- 初始專案架構
- 完整文件系統
```

### 自動生成 CHANGELOG

可使用工具:
- [conventional-changelog](https://github.com/conventional-changelog/conventional-changelog)
- [git-cliff](https://github.com/orhun/git-cliff)

## 總結

### Git Flow 快速參考

| 操作 | 命令 |
|-----|------|
| 開始新功能 | `git checkout -b feature/12-habit-management develop` |
| 完成功能 | PR `feature/12-habit-management` → `develop` |
| 準備發布 | `git checkout -b release/1.0.0 develop` |
| 發布到生產 | PR `release/1.0.0` → `main` + `develop` |
| 緊急修復 | `git checkout -b hotfix/1.0.1 main` |
| 修復完成 | PR `hotfix/1.0.1` → `main` + `develop` |

### 版本號決策樹

```
程式碼變更
    ↓
    ├─ 不相容的 API 變更? → Yes → MAJOR++
    ├─ 新增功能 (向下相容)? → Yes → MINOR++
    └─ Bug 修復? → Yes → PATCH++
```

### Milestone 優先順序

1. **v1.0.0 - MVP** (最高優先)
2. v1.1.0 - Statistics
3. v1.2.0 - Calendar
4. v2.0.0 - Watch Support

---

**遵循此 Git Flow,確保程式碼品質與發布流程的穩定性!** 🚀
