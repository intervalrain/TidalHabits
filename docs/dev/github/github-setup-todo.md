# GitHub 手動設定待辦清單

## ✅ 已完成 (透過自動化腳本)

- ✅ **21 個 Labels** - Type, Priority, Status, Module 標籤
- ✅ **11 個 Milestones** - v0.2.0 到 v2.0.0 的版本規劃
- ✅ **Repository 功能** - Issues, Projects, Wiki 已啟用
- ✅ **Repository 資訊** - 描述與基本設定
- ✅ **Topics** - ios, swift, swiftui, clean-architecture 等標籤

## ⚠️ 必須手動設定 (在 GitHub Web UI)

以下項目**必須手動設定**,無法透過 GitHub CLI 自動化:

### 1. 🔒 分支保護規則 (最重要!) ⭐

**URL**: https://github.com/intervalrain/TidalHabits/settings/branches

#### 保護 `main` 分支

點擊 **"Add rule"**

**設定**:
- Branch name pattern: `main`
- ✅ Require a pull request before merging
  - Require approvals: **1**
  - ✅ Dismiss stale pull request approvals when new commits are pushed
- ✅ Require status checks to pass before merging
  - ✅ Require branches to be up to date before merging
  - Status checks: `build-and-test`, `code-quality`
- ✅ Require conversation resolution before merging
- ✅ Require linear history
- ✅ Do not allow bypassing the above settings
- ❌ Allow force pushes (不勾選)
- ❌ Allow deletions (不勾選)

#### 保護 `develop` 分支

**設定** (較 main 寬鬆):
- Branch name pattern: `develop`
- ✅ Require a pull request before merging
  - Require approvals: **1**
- ✅ Require status checks to pass before merging
  - Status checks: `build-and-test`
- ✅ Require conversation resolution before merging
- ❌ Allow force pushes (不勾選)
- ❌ Allow deletions (不勾選)

---

### 2. ⚙️ GitHub Actions 設定

**URL**: https://github.com/intervalrain/TidalHabits/settings/actions

#### General
- **Actions permissions**:
  - 選擇: **"Allow all actions and reusable workflows"**
- **Workflow permissions**:
  - 選擇: **"Read and write permissions"**
  - ✅ Allow GitHub Actions to create and approve pull requests

點擊 **"Save"**

---

### 3. 🔐 Secrets 設定 (未來需要時)

**URL**: https://github.com/intervalrain/TidalHabits/settings/secrets/actions

**目前不需要設定**,等到需要時再加入:

| Secret Name | 用途 | 何時需要 |
|-------------|------|---------|
| `CODECOV_TOKEN` | Code coverage 上傳 | 整合 Codecov 時 |
| `APPLE_ID` | App Store Connect | 上傳 TestFlight 時 |
| `APP_STORE_CONNECT_API_KEY` | 自動化發布 | 使用 CI/CD 發布時 |
| `SLACK_WEBHOOK_URL` | Slack 通知 | 整合 Slack 時 |

---

### 4. 🛡️ Security 設定 (建議啟用)

**URL**: https://github.com/intervalrain/TidalHabits/settings/security_analysis

建議啟用:
- ✅ **Dependabot alerts** - 依賴套件安全警告
- ✅ **Dependabot security updates** - 自動建立安全更新 PR

點擊 **"Enable"**

---

### 5. 🔔 Notifications 設定 (個人設定)

**URL**: https://github.com/settings/notifications

**建議設定**:
- ✅ Pull Request reviews
- ✅ Pull Request pushes
- ✅ Comments on Issues and Pull Requests
- ❌ CI activity (太吵,不建議)

---

## 📋 快速檢查清單

完成以下項目後,專案即可開始開發:

### 必須完成
- [ ] 分支保護規則 (main + develop)
- [ ] GitHub Actions 權限設定
- [ ] 推送程式碼到 GitHub

### 建議完成
- [ ] Dependabot alerts 啟用
- [ ] Notifications 設定

### 可選項目
- [ ] Projects 建立 (專案管理)
- [ ] Discussions 啟用 (社群討論)

---

## 🚀 下一步行動

### 1. 完成上述手動設定

參考詳細指南: [github-manual-setup.md](github-manual-setup.md)

### 2. 推送程式碼到 GitHub

```bash
# 確認目前狀態
git status

# 加入所有變更
git add .

# Commit
git commit -m "docs: complete project setup and documentation

- Add comprehensive documentation (30+ files)
- Setup Git Flow and CI/CD workflows
- Configure project with .gitignore, .gitattributes, etc.
- Add LICENSE (MIT)
- Setup GitHub with labels, milestones, and features
- Update all repository links to intervalrain/TidalHabits

Completed:
- 21 Labels (Type, Priority, Status, Module)
- 11 Milestones (v0.2.0 - v2.0.0)
- Repository features enabled
- Topics and description set"

# 推送到 main
git push -u origin main

# 建立並推送 develop 分支
git checkout -b develop
git push -u origin develop

# 回到 main
git checkout main
```

### 3. 驗證設定

```bash
# 驗證分支保護 (應該被拒絕)
git commit --allow-empty -m "test: verify branch protection"
git push origin main
# 預期: 被拒絕,提示需要 PR

# 清理測試
git reset --hard HEAD~1
```

### 4. 建立第一個 Issue

**URL**: https://github.com/intervalrain/TidalHabits/issues/new/choose

使用 **Feature Template**:
- Title: `[FEATURE] Implement Core Foundation`
- Milestone: `v0.2.0 - Core Foundation`
- Labels: `feature`, `priority: high`, `module: core`

### 5. 開始開發!

```bash
# 從 develop 建立 feature branch
git checkout develop
git checkout -b feature/10-core-foundation

# 開始 TDD 開發
# 1. 定義規格 → 2. 撰寫測試 → 3. 實作 → 4. Review → 5. Commit
```

---

## 📚 相關文件

- [GitHub 手動設定詳細指南](github-manual-setup.md)
- [Git Flow 規範](git-flow.md)
- [開發規範](../notes/development-standards.md)
- [快速開始指南](../notes/getting-started.md)
- [Milestone 規劃](../milestones/phases/milestones.md)

---

## 🔗 重要連結

- **Repository**: https://github.com/intervalrain/TidalHabits
- **Labels**: https://github.com/intervalrain/TidalHabits/labels
- **Milestones**: https://github.com/intervalrain/TidalHabits/milestones
- **Settings**: https://github.com/intervalrain/TidalHabits/settings
- **Actions**: https://github.com/intervalrain/TidalHabits/actions

---

_最後更新: 2025-10-28_
_狀態: 自動化設定完成,等待手動設定分支保護規則_
