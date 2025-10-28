# Git Flow 快速參考卡

## 常用指令速查

### 🚀 開始新功能

```bash
# 1. 更新 develop
git checkout develop
git pull origin develop

# 2. 建立 feature branch
git checkout -b feature/12-habit-management

# 3. 開發與提交
git add .
git commit -m "feat(habit): implement habit entity"

# 4. 推送並建立 PR
git push origin feature/12-habit-management
# 然後在 GitHub 建立 PR: feature/12-habit-management → develop
```

### 🐛 修復 Bug (develop)

```bash
# 1. 從 develop 建立 bugfix branch
git checkout develop
git pull origin develop
git checkout -b bugfix/56-fix-timer-calculation

# 2. 修復並提交
git commit -m "fix(pomodoro): fix timer calculation logic"

# 3. 推送並建立 PR
git push origin bugfix/56-fix-timer-calculation
# PR: bugfix/56-fix-timer-calculation → develop
```

### 🔥 緊急修復 (hotfix)

```bash
# 1. 從 main 建立 hotfix branch
git checkout main
git pull origin main
git checkout -b hotfix/1.0.1-critical-crash

# 2. 修復並更新版本號
# 編輯 Info.plist 或 version.txt
git commit -m "fix: fix critical crash on launch"
git commit -m "chore(release): bump version to 1.0.1"

# 3. 建立兩個 PR
# PR 1: hotfix/1.0.1-critical-crash → main
# PR 2: hotfix/1.0.1-critical-crash → develop
```

### 📦 準備發布

```bash
# 1. 從 develop 建立 release branch
git checkout develop
git pull origin develop
git checkout -b release/1.0.0

# 2. 更新版本號與 CHANGELOG
echo "1.0.0" > version.txt
# 編輯 CHANGELOG.md
git commit -m "chore(release): prepare release 1.0.0"

# 3. 測試與修復小 bug (如有)
# ... 修改 ...
git commit -m "fix(release): minor UI adjustment"

# 4. 建立兩個 PR (完成測試後)
# PR 1: release/1.0.0 → main (觸發 release)
# PR 2: release/1.0.0 → develop (反向合併)
```

### 🏷️ 手動建立 Tag (如需要)

```bash
# 建立 annotated tag
git tag -a v1.0.0 -m "Release version 1.0.0 - MVP"

# 推送 tag
git push origin v1.0.0

# 列出所有 tag
git tag -l

# 刪除 tag (如需要)
git tag -d v1.0.0
git push origin --delete v1.0.0
```

## Commit 訊息範本

### 格式

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Type 類型

| Type | 說明 | 範例 |
|------|------|------|
| `feat` | 新功能 | `feat(habit): add habit creation` |
| `fix` | Bug 修復 | `fix(pomodoro): fix timer crash` |
| `docs` | 文件更新 | `docs: update README` |
| `style` | 格式調整 | `style: fix code formatting` |
| `refactor` | 重構 | `refactor(habit): extract validation` |
| `test` | 測試相關 | `test(habit): add unit tests` |
| `chore` | 建置/工具 | `chore: update dependencies` |
| `perf` | 效能優化 | `perf(pomodoro): optimize timer` |

### 完整範例

```
feat(habit): implement habit management feature

- Add Habit entity with validation
- Implement HabitRepository with CoreData
- Add CreateHabitCommand and handler
- Implement HabitListView and ViewModel
- Add unit tests with 90% coverage

Closes #12
```

## 分支命名規則

```
feature/<issue-number>-<description>
  例: feature/12-habit-management
      feature/34-pomodoro-timer

bugfix/<issue-number>-<description>
  例: bugfix/56-fix-validation
      bugfix/78-fix-ui-crash

release/<version>
  例: release/1.0.0
      release/1.1.0-beta.1

hotfix/<version>-<description>
  例: hotfix/1.0.1-critical-crash
      hotfix/1.0.2-data-loss-fix
```

## PR Title 格式

```
[類型] 簡短描述

範例:
[Feature] Implement habit management
[Bugfix] Fix timer calculation issue
[Release] Release v1.0.0
[Hotfix] Fix critical crash on launch
```

## 版本號規則

### Semantic Versioning

```
MAJOR.MINOR.PATCH[-PRERELEASE]

1.0.0       正式版本
1.1.0       新增功能
1.0.1       Bug 修復
1.0.0-beta.1    Beta 測試版
1.0.0-rc.1      Release Candidate
```

### 何時增加版本號

```
不相容的 API 變更        → MAJOR++  (1.0.0 → 2.0.0)
新增功能 (向下相容)      → MINOR++  (1.0.0 → 1.1.0)
Bug 修復               → PATCH++  (1.0.0 → 1.0.1)
```

## Git Flow 視覺化

```
main      ●──────●─────────────●───────●────→
          │      ↑             ↑       ↑
          │      │  (merge)    │       │
release   │      ●──────●      │       ●─────●
          │     ↗        ↘     │      ↗       ↘
develop   ●─●──●───●─●───●────●──●──●─────────●
           ↗ ↖ ↗   ↗ ↖  ↗      ↗  ↖
feature  ●─● ●─●  ●─●         ●──●
```

## 常見情境

### 情境 1: Feature 開發中,develop 有新的變更

```bash
# 在 feature branch 上
git checkout feature/12-habit-management
git fetch origin
git rebase origin/develop

# 如果有衝突,解決後:
git rebase --continue

# 強制推送 (因為 rebase 改變了歷史)
git push --force-with-lease origin feature/12-habit-management
```

### 情境 2: 錯誤地在 develop 直接 commit

```bash
# 1. 建立 feature branch (從當前位置)
git checkout -b feature/fix-accidental-commit

# 2. 推送 feature branch
git push origin feature/fix-accidental-commit

# 3. Reset develop 到 origin
git checkout develop
git reset --hard origin/develop

# 4. 建立 PR: feature/fix-accidental-commit → develop
```

### 情境 3: 需要撤銷最後一次 commit

```bash
# 保留變更,撤銷 commit
git reset --soft HEAD~1

# 或完全刪除變更 (危險!)
git reset --hard HEAD~1
```

### 情境 4: 查看 branch 狀態

```bash
# 列出所有 branch
git branch -a

# 查看 branch 的 commit 歷史
git log --oneline --graph --all --decorate

# 查看與 origin 的差異
git status
git fetch origin
git diff origin/develop
```

### 情境 5: 清理已合併的 branch

```bash
# 刪除本地已合併的 branch
git branch --merged develop | grep -v "\*" | grep -v "develop" | grep -v "main" | xargs -n 1 git branch -d

# 刪除遠端已刪除的本地追蹤 branch
git fetch --prune
```

## CI/CD 觸發時機

| 分支 | 事件 | 觸發的 CI/CD |
|-----|------|-------------|
| `feature/*` | push | ✅ Build & Test |
| `feature/*` | PR → develop | ✅ Build & Test |
| `develop` | PR merged | ✅ Build & Test & Integration |
| `release/*` | push | ✅ Full Test & Beta Build |
| `main` | PR merged | ✅ Full Test & **Release** & Tag |

## 檢查清單

### 提交 PR 前

- [ ] 程式碼已 self-review
- [ ] 所有測試通過 (`⌘U` in Xcode)
- [ ] 無編譯警告
- [ ] 遵循命名與編碼規範
- [ ] Commit 訊息遵循 Conventional Commits
- [ ] 已更新相關文件
- [ ] 多語系文字已本地化

### 合併 PR 前

- [ ] Code Review 完成且 Approved
- [ ] 所有 CI 檢查通過
- [ ] 無衝突
- [ ] Squash merge (保持 develop/main 歷史乾淨)

### Release 前

- [ ] 版本號已更新
- [ ] CHANGELOG.md 已更新
- [ ] 所有測試通過
- [ ] Beta 測試完成 (如適用)
- [ ] App Store 資產準備完成
- [ ] Release Notes 撰寫完成

## 實用 Git Alias

在 `~/.gitconfig` 加入:

```ini
[alias]
    # 美化 log
    lg = log --oneline --graph --all --decorate

    # 快速 status
    st = status -sb

    # 快速 commit
    cm = commit -m

    # 快速 checkout
    co = checkout

    # 快速 branch
    br = branch

    # 查看最近的 commit
    last = log -1 HEAD --stat

    # Undo 最後一次 commit (保留變更)
    undo = reset --soft HEAD~1

    # 列出所有 alias
    alias = config --get-regexp alias
```

使用:
```bash
git lg        # 美化的 log
git st        # 簡潔的 status
git last      # 查看最後一次 commit
```

## 快速連結

- [完整 Git Flow 文件](./git-flow.md)
- [Milestone 規劃](./milestones.md)
- [開發規範](./development-standards.md)
- [GitHub Repository](https://github.com/intervalrain/TidalHabits)

---

**遵循 Git Flow,保持程式碼品質!** 🚀
