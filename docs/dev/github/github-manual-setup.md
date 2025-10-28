# GitHub Repository 手動設定指南

## 概述

本文件說明需要在 GitHub Web UI 手動完成的設定項目。

**Repository**: https://github.com/intervalrain/TidalHabits

---

## 自動化腳本

首先執行自動化腳本來設定 Labels、Milestones 等:

```bash
# 1. 登入 GitHub CLI (如果還沒登入)
gh auth login

# 2. 給予腳本執行權限
chmod +x scripts/setup-github.sh

# 3. 執行設定腳本
./scripts/setup-github.sh
```

這個腳本會自動建立:
- ✅ 21 個 Labels (Type, Priority, Status, Module)
- ✅ 11 個 Milestones (v0.2.0 ~ v2.0.0)
- ✅ Repository 描述與 Topics
- ✅ 啟用 Issues, Projects, Wiki, Discussions

---

## 必須手動設定的項目

以下項目**必須**在 GitHub Web UI 手動設定,無法透過 GitHub CLI 完全自動化。

### 1. 分支保護規則 (Branch Protection Rules) ⭐ 最重要

**URL**: https://github.com/intervalrain/TidalHabits/settings/branches

#### 保護 `main` 分支

點擊 **"Add rule"** 或 **"Add branch protection rule"**

**Branch name pattern**: `main`

**設定以下規則**:

##### Protect matching branches

- ✅ **Require a pull request before merging**
  - ✅ **Require approvals**: `1` (至少需要 1 人 approve)
  - ✅ **Dismiss stale pull request approvals when new commits are pushed**
  - ✅ **Require review from Code Owners** (如果有 CODEOWNERS 檔案)

- ✅ **Require status checks to pass before merging**
  - ✅ **Require branches to be up to date before merging**
  - **Status checks that are required**:
    - 輸入並選擇: `build-and-test` (CI workflow)
    - 輸入並選擇: `code-quality` (SwiftLint check)

- ✅ **Require conversation resolution before merging**
  - 所有 PR 評論必須被解決才能合併

- ✅ **Require signed commits** (可選,建議啟用)

- ✅ **Require linear history**
  - 禁止 merge commits,只允許 squash 或 rebase

- ✅ **Do not allow bypassing the above settings**
  - 包含管理員也必須遵守規則

- ✅ **Restrict who can push to matching branches** (可選)
  - 如果是團隊開發,可以限制只有特定人員可以推送

##### Rules applied to everyone including administrators

- ✅ **Allow force pushes**: ❌ **不勾選**
- ✅ **Allow deletions**: ❌ **不勾選**

點擊 **"Create"** 或 **"Save changes"**

---

#### 保護 `develop` 分支

點擊 **"Add rule"** 再次建立規則

**Branch name pattern**: `develop`

**設定以下規則** (比 main 寬鬆一些):

- ✅ **Require a pull request before merging**
  - ✅ **Require approvals**: `1`
  - ❌ Dismiss stale pull request approvals (不勾選,允許更靈活)

- ✅ **Require status checks to pass before merging**
  - ✅ **Require branches to be up to date before merging**
  - Status checks: `build-and-test`

- ✅ **Require conversation resolution before merging**

- ❌ **Require linear history** (develop 允許 merge commits)

- ✅ **Allow force pushes**: ❌ **不勾選**
- ✅ **Allow deletions**: ❌ **不勾選**

點擊 **"Create"**

---

### 2. GitHub Actions 設定

**URL**: https://github.com/intervalrain/TidalHabits/settings/actions

#### General

- **Actions permissions**:
  - ✅ 選擇: **"Allow all actions and reusable workflows"**

- **Workflow permissions**:
  - ✅ 選擇: **"Read and write permissions"**
  - ✅ 勾選: **"Allow GitHub Actions to create and approve pull requests"**

#### Runners

- 使用 GitHub-hosted runners (預設)
- macOS runner 用於 iOS 建置

點擊 **"Save"**

---

### 3. Secrets and Variables (CI/CD 使用)

**URL**: https://github.com/intervalrain/TidalHabits/settings/secrets/actions

未來如果需要設定以下 Secrets:

#### Repository secrets

點擊 **"New repository secret"** 建立以下 secrets:

| Secret Name | 用途 | 何時需要 |
|-------------|------|---------|
| `CODECOV_TOKEN` | Code coverage 報告上傳 | 整合 Codecov 時 |
| `APPLE_ID` | App Store Connect 帳號 | 上傳到 TestFlight 時 |
| `APP_STORE_CONNECT_API_KEY` | App Store Connect API | 自動化發布時 |
| `FASTLANE_PASSWORD` | Fastlane 密碼 | 使用 Fastlane 時 |
| `MATCH_PASSWORD` | Code signing | 使用 fastlane match 時 |
| `SLACK_WEBHOOK_URL` | Slack 通知 | 整合 Slack 通知時 |

**目前不需要設定,等實際需要時再加入**

---

### 4. Code Security and Analysis

**URL**: https://github.com/intervalrain/TidalHabits/settings/security_analysis

建議啟用以下功能:

- ✅ **Dependency graph**: 已自動啟用
- ✅ **Dependabot alerts**: 建議啟用
  - 當依賴套件有安全漏洞時會發出警告
- ✅ **Dependabot security updates**: 建議啟用
  - 自動建立 PR 來更新有安全問題的依賴
- ❌ **Dependabot version updates**: 可選
  - 自動更新依賴版本 (可能產生很多 PR)

點擊各項目的 **"Enable"** 按鈕

---

### 5. Notifications 設定

**個人設定** (不是 Repository 設定)

**URL**: https://github.com/settings/notifications

#### Watching

- **Automatically watch repositories**: 建議勾選
- **Automatically watch teams**: 視需求

#### Subscriptions

- **Email**:
  - ✅ Pull Request reviews
  - ✅ Pull Request pushes
  - ✅ Comments on Issues and Pull Requests
  - ✅ Commits
  - ❌ CI activity (太吵,建議不勾選)

#### Custom routing (可選)

可設定不同類型的通知發送到不同的 email

---

### 6. Collaborators & Teams (團隊協作)

**URL**: https://github.com/intervalrain/TidalHabits/settings/access

如果是團隊開發:

#### Invite collaborators

1. 點擊 **"Add people"**
2. 輸入 GitHub username 或 email
3. 選擇權限等級:
   - **Read**: 只能閱讀
   - **Triage**: 可管理 Issues 和 PR
   - **Write**: 可推送程式碼
   - **Maintain**: 可管理 Repository (但不能刪除)
   - **Admin**: 完全控制權

建議:
- 核心開發者: **Write** 或 **Maintain**
- Code Reviewers: **Write**
- 文件貢獻者: **Triage**

---

### 7. Webhooks (可選)

**URL**: https://github.com/intervalrain/TidalHabits/settings/hooks

如果需要整合外部服務 (Slack, Discord, CI/CD 等):

#### 新增 Webhook

1. 點擊 **"Add webhook"**
2. 輸入 **Payload URL** (外部服務的 URL)
3. 選擇 **Content type**: `application/json`
4. 設定 **Secret** (可選,增加安全性)
5. 選擇觸發事件:
   - **Just the push event** (只推送時)
   - **Send me everything** (所有事件)
   - **Let me select individual events** (自選事件)

常用整合:
- **Slack**: 使用 GitHub App 更方便
- **Discord**: 使用 Discord Webhook
- **CI/CD**: GitHub Actions 已內建,不需要 webhook

---

### 8. Projects (專案管理,可選)

**URL**: https://github.com/intervalrain/TidalHabits/projects

建議建立以下 Projects:

#### 建立 Project

1. 點擊 **"New project"**
2. 選擇 **Template**:
   - **Team backlog** (推薦)
   - **Feature**
   - **Bug tracker**
3. 設定 Project name:
   - "TidalHabits MVP Development"
   - "Bug Tracking"
   - "Feature Roadmap"

#### 欄位設定

典型的看板欄位:
- **Backlog** (待處理)
- **To Do** (待執行)
- **In Progress** (進行中)
- **In Review** (審核中)
- **Done** (完成)

---

### 9. Wiki (可選)

**URL**: https://github.com/intervalrain/TidalHabits/wiki

如果想使用 Wiki 來存放額外文件:

1. 點擊 **"Create the first page"**
2. 建立 Home 頁面
3. 可加入:
   - 快速開始指南
   - FAQ
   - 開發環境設定
   - 故障排除
   - API 文件

**建議**: 目前 docs/ 目錄已有完整文件,Wiki 可暫時不使用

---

### 10. Discussions (可選)

**URL**: https://github.com/intervalrain/TidalHabits/discussions

如果想啟用 Discussions 供社群討論:

#### 分類建議

- **Announcements** (公告)
- **General** (一般討論)
- **Ideas** (功能建議)
- **Q&A** (問答)
- **Show and tell** (展示與分享)

---

## 設定檢查清單

完成設定後,請確認以下項目:

### 必須完成

- [ ] ✅ 分支保護規則已設定 (main 和 develop)
- [ ] ✅ GitHub Actions 已啟用並授權
- [ ] ✅ Labels 已建立 (透過腳本)
- [ ] ✅ Milestones 已建立 (透過腳本)
- [ ] ✅ Repository 描述已設定

### 建議完成

- [ ] Dependabot alerts 已啟用
- [ ] Notifications 已設定
- [ ] Repository topics 已設定

### 可選項目

- [ ] Collaborators 已邀請 (如果是團隊)
- [ ] Projects 已建立 (如果需要專案管理)
- [ ] Webhooks 已設定 (如果需要整合外部服務)

---

## 驗證設定

### 驗證分支保護

```bash
# 嘗試直接推送到 main (應該被拒絕)
git checkout main
git commit --allow-empty -m "test: verify branch protection"
git push origin main
# 預期結果: 被拒絕,提示需要 PR

# 清理測試 commit
git reset --hard HEAD~1
```

### 驗證 CI/CD

1. 建立 feature branch
2. 推送變更
3. 建立 PR
4. 檢查 GitHub Actions 是否自動執行

---

## 下一步

設定完成後:

1. **推送專案到 GitHub**
   ```bash
   git add .
   git commit -m "docs: complete project setup"
   git push -u origin main
   git checkout -b develop
   git push -u origin develop
   ```

2. **建立第一個 Issue**
   - 使用 Feature template
   - 指派 Milestone: v0.2.0
   - 加上適當的 Labels

3. **開始開發**
   - 從 develop 建立 feature branch
   - 遵循 TDD 流程
   - 完成後建立 PR

---

## 參考資源

- [GitHub 分支保護文件](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/defining-the-mergeability-of-pull-requests/about-protected-branches)
- [GitHub Actions 文件](https://docs.github.com/en/actions)
- [GitHub CLI 文件](https://cli.github.com/manual/)
- [Git Flow 規範](git-flow.md)
- [Repository 資訊](repository-info.md)

---

**Repository**: https://github.com/intervalrain/TidalHabits

_最後更新: 2025-10-28_
