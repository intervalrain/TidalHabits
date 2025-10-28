# TidalHabits Repository 資訊

## GitHub Repository

- **Repository URL**: https://github.com/intervalrain/TidalHabits
- **Owner**: intervalrain
- **Project Name**: TidalHabits

## Git Remote 設定

```bash
# 檢視 remote 設定
git remote -v

# 輸出:
# origin  git@github.com:intervalrain/TidalHabits.git (fetch)
# origin  git@github.com:intervalrain/TidalHabits.git (push)
```

## Clone Repository

### SSH (推薦)
```bash
git clone git@github.com:intervalrain/TidalHabits.git
```

### HTTPS
```bash
git clone https://github.com/intervalrain/TidalHabits.git
```

## Repository 連結

### 主要連結
- **Repository**: https://github.com/intervalrain/TidalHabits
- **Issues**: https://github.com/intervalrain/TidalHabits/issues
- **Pull Requests**: https://github.com/intervalrain/TidalHabits/pulls
- **Milestones**: https://github.com/intervalrain/TidalHabits/milestones
- **Projects**: https://github.com/intervalrain/TidalHabits/projects
- **Releases**: https://github.com/intervalrain/TidalHabits/releases
- **Discussions**: https://github.com/intervalrain/TidalHabits/discussions

### Actions (CI/CD)
- **All Workflows**: https://github.com/intervalrain/TidalHabits/actions
- **CI Workflow**: https://github.com/intervalrain/TidalHabits/actions/workflows/ci.yml
- **Release Workflow**: https://github.com/intervalrain/TidalHabits/actions/workflows/release.yml

### Insights
- **Contributors**: https://github.com/intervalrain/TidalHabits/graphs/contributors
- **Commit Activity**: https://github.com/intervalrain/TidalHabits/graphs/commit-activity
- **Code Frequency**: https://github.com/intervalrain/TidalHabits/graphs/code-frequency
- **Network**: https://github.com/intervalrain/TidalHabits/network

## 分支管理

### 主要分支
- **main**: https://github.com/intervalrain/TidalHabits/tree/main
- **develop**: https://github.com/intervalrain/TidalHabits/tree/develop

### 檢視所有分支
```
https://github.com/intervalrain/TidalHabits/branches
```

## 標籤 (Tags)

### 檢視所有 Tags
```
https://github.com/intervalrain/TidalHabits/tags
```

### 最新 Release
```
https://github.com/intervalrain/TidalHabits/releases/latest
```

## GitHub CLI 快速指令

### Repository 操作
```bash
# Clone repository
gh repo clone intervalrain/TidalHabits

# 檢視 repository 資訊
gh repo view intervalrain/TidalHabits

# 在瀏覽器開啟 repository
gh repo view intervalrain/TidalHabits --web
```

### Issue 操作
```bash
# 建立 Issue
gh issue create --repo intervalrain/TidalHabits

# 列出所有 Issues
gh issue list --repo intervalrain/TidalHabits

# 檢視特定 Issue
gh issue view 1 --repo intervalrain/TidalHabits
```

### Pull Request 操作
```bash
# 建立 PR
gh pr create --repo intervalrain/TidalHabits

# 列出所有 PRs
gh pr list --repo intervalrain/TidalHabits

# 檢視特定 PR
gh pr view 1 --repo intervalrain/TidalHabits

# Checkout PR
gh pr checkout 1 --repo intervalrain/TidalHabits
```

### Milestone 操作
```bash
# 建立 Milestone
gh milestone create "v0.2.0 - Core Foundation" \
  --due-date 2025-11-15 \
  --description "建立核心基礎模組" \
  --repo intervalrain/TidalHabits

# 列出所有 Milestones
gh milestone list --repo intervalrain/TidalHabits
```

### Release 操作
```bash
# 建立 Release
gh release create v1.0.0 \
  --title "Release v1.0.0" \
  --notes "MVP 正式發布" \
  --repo intervalrain/TidalHabits

# 列出所有 Releases
gh release list --repo intervalrain/TidalHabits
```

## 貢獻者資訊

### Owner/Maintainer
- **GitHub**: [@intervalrain](https://github.com/intervalrain)

### Contributors
檢視所有貢獻者:
```
https://github.com/intervalrain/TidalHabits/graphs/contributors
```

## Repository 設定

### 分支保護規則

建議設定以下分支保護規則:

#### main 分支
- ✅ Require pull request reviews before merging (1 approval)
- ✅ Require status checks to pass before merging
- ✅ Require conversation resolution before merging
- ✅ Require linear history
- ✅ Do not allow bypassing the above settings

#### develop 分支
- ✅ Require pull request reviews before merging
- ✅ Require status checks to pass before merging
- ✅ Require conversation resolution before merging

### Secrets 設定 (CI/CD)

在 Repository Settings → Secrets and variables → Actions 中設定:

```
# 未來可能需要的 Secrets:
CODECOV_TOKEN          # Codecov 整合
APPLE_ID              # App Store 上傳
APP_STORE_CONNECT_KEY # TestFlight 上傳
SLACK_WEBHOOK_URL     # Slack 通知
```

## Labels 建議

建議在 Repository 中建立以下 Labels:

### Type
- `feature` - 新功能
- `bug` - Bug 修復
- `enhancement` - 功能增強
- `refactor` - 重構
- `docs` - 文件
- `test` - 測試
- `chore` - 維護工作

### Priority
- `priority: critical` - 緊急
- `priority: high` - 高
- `priority: medium` - 中
- `priority: low` - 低

### Status
- `status: planning` - 規劃中
- `status: in-progress` - 進行中
- `status: blocked` - 阻塞
- `status: review` - 審核中

### Feature Modules
- `module: habit` - 習慣管理
- `module: pomodoro` - 番茄鐘
- `module: statistics` - 統計
- `module: calendar` - 行事曆
- `module: settings` - 設定
- `module: reward` - 獎勵

## 專案管理

### GitHub Projects (建議)

可建立以下 Projects:

1. **MVP Development** (v1.0.0)
   - Backlog
   - In Progress
   - In Review
   - Done

2. **Roadmap**
   - Phase 1 - MVP
   - Phase 2 - Enhancement
   - Phase 3 - Watch Integration

3. **Bug Tracking**
   - Reported
   - Confirmed
   - In Progress
   - Fixed
   - Verified

## 通知設定

### Watch Repository
建議設定:
- **All Activity**: 接收所有通知 (適合 Owner/Maintainer)
- **Participating and @mentions**: 只接收相關通知 (適合 Contributors)

### Email Notifications
在 GitHub Settings 中配置:
- Pull request reviews
- Issue comments
- CI/CD failures

## 備份策略

### 定期備份
```bash
# 備份整個 repository (包含所有分支與 tags)
git clone --mirror git@github.com:intervalrain/TidalHabits.git

# 備份到指定位置
cd TidalHabits.git
git remote set-url --push origin /path/to/backup/TidalHabits.git
```

## 相關文件

- [Git Flow 規範](./git-flow.md)
- [Milestone 規劃](./milestones.md)
- [開發規範](./development-standards.md)
- [README](../README.md)

---

**Repository**: https://github.com/intervalrain/TidalHabits

_最後更新: 2025-10-28_
