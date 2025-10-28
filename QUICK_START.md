# TidalHabits 快速開始指南

## 📋 目錄
- [專案結構](#專案結構)
- [快速指令](#快速指令)
- [開發工作流程](#開發工作流程)
- [更多資訊](#更多資訊)

---

## 專案結構

```
TidalHabits/
├── TidalHabits.xcodeproj/    # Xcode 專案（由 project.yml 生成）
├── project.yml               # xcodegen 配置檔
├── src/                      # 所有原始碼
│   ├── App/                  # App 進入點和資源
│   ├── Core/                 # 核心層
│   ├── Feature/              # 功能模組
│   └── Shared/               # 共享元件
├── test/                     # 所有測試
│   ├── TidalHabitsTests/     # 單元測試
│   └── TidalHabitsUITests/   # UI 測試
├── docs/                     # 文件
└── scripts/                  # 實用腳本
```

---

## 快速指令

### 🧪 執行測試
```bash
# 使用腳本（推薦）
./scripts/test.sh

# 或使用完整指令
xcodebuild \
  -project TidalHabits.xcodeproj \
  -scheme TidalHabits \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro' \
  -only-testing:TidalHabitsTests \
  test
```

### 🔨 建置專案
```bash
xcodebuild \
  -project TidalHabits.xcodeproj \
  -scheme TidalHabits \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro' \
  build
```

### 📱 執行 App（在模擬器）
```bash
# 使用腳本（推薦）
./scripts/run.sh

# 腳本會自動：
# 1. 建置專案
# 2. 啟動模擬器
# 3. 安裝並執行 App
```

### 🧹 清理專案
```bash
# 使用腳本
./scripts/clean.sh

# 會清理：
# - Build 快取
# - DerivedData
# - 關閉所有模擬器
```

### 🔧 重新生成 Xcode 專案
```bash
# 當 project.yml 有變更時使用
./scripts/rebuild-project.sh
```

---

## 開發工作流程

### 1️⃣ 開始新功能
```bash
# 從 develop 建立 feature branch
git checkout develop
git pull origin develop
git checkout -b feature/N-feature-name

# 在 GitHub 上 assign Issue 給自己
gh issue edit N --add-assignee @me
```

### 2️⃣ TDD 開發流程
```bash
# 1. 寫測試（Red phase）
#    - 在 test/TidalHabitsTests/ 建立測試檔案
#    - 執行測試，確認失敗

./scripts/test.sh

# 2. 寫實作（Green phase）
#    - 在 src/ 實作功能
#    - 執行測試，確認通過

./scripts/test.sh

# 3. 重構（Refactor phase）
#    - 優化程式碼
#    - 確保測試仍然通過

./scripts/test.sh
```

### 3️⃣ 提交變更
```bash
# 查看變更
git status
git diff

# 新增檔案
git add .

# 提交（使用語意化 commit message）
git commit -m "feat: Add feature description (#N)

詳細說明...

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"

# 推送到遠端
git push origin feature/N-feature-name
```

### 4️⃣ 建立 Pull Request
```bash
# 使用 gh CLI
gh pr create \
  --title "feat: Feature description (#N)" \
  --body "$(cat <<'EOF'
## Summary
- 功能說明

## Test plan
- [ ] 單元測試通過
- [ ] 手動測試通過

🤖 Generated with [Claude Code](https://claude.com/claude-code)
EOF
)"
```

### 5️⃣ 程式碼審查與合併
```bash
# 查看 PR
gh pr view

# 合併 PR（在 GitHub 上審查通過後）
gh pr merge --squash
```

---

## 常用腳本

### 測試相關
```bash
# 執行所有單元測試
./scripts/test.sh

# 執行特定測試類別
xcodebuild ... -only-testing:TidalHabitsTests/HabitTests test

# 執行特定測試方法
xcodebuild ... -only-testing:TidalHabitsTests/HabitTests/testHabit_ShouldInitializeWithValidValues test
```

### 專案管理
```bash
# 重新生成 Xcode 專案
./scripts/rebuild-project.sh

# 清理專案
./scripts/clean.sh

# 執行 App
./scripts/run.sh
```

### Git 操作
```bash
# 查看當前分支狀態
git status

# 查看提交歷史
git log --oneline --graph --all

# 查看遠端分支
git branch -r

# 切換分支
git checkout branch-name
```

### GitHub 操作
```bash
# 查看 Issues
gh issue list

# 查看特定 Issue
gh issue view N

# 查看 Pull Requests
gh pr list

# 查看特定 PR
gh pr view N
```

---

## 模擬器管理

### 查看可用模擬器
```bash
xcrun simctl list devices available | grep iPhone
```

### 啟動模擬器
```bash
# 啟動特定模擬器
xcrun simctl boot "iPhone 15 Pro"

# 開啟 Simulator.app
open -a Simulator
```

### 安裝 App 到模擬器
```bash
# 先建置
xcodebuild ... build

# 找出 App 路徑
APP_PATH=$(find ~/Library/Developer/Xcode/DerivedData/TidalHabits-*/Build/Products/Debug-iphonesimulator -name "TidalHabits.app" | head -1)

# 安裝到模擬器
xcrun simctl install booted "$APP_PATH"

# 啟動 App
xcrun simctl launch booted com.intervalrain.TidalHabits
```

### 重置模擬器
```bash
# 關閉所有模擬器
xcrun simctl shutdown all

# 清除特定模擬器
xcrun simctl erase "iPhone 15 Pro"
```

---

## 疑難排解

### ❌ "Unable to read project" 錯誤
```bash
# 重新生成專案並修正格式
./scripts/rebuild-project.sh
```

### ❌ 測試失敗
```bash
# 清理並重新測試
./scripts/clean.sh
./scripts/test.sh
```

### ❌ 模擬器無法啟動
```bash
# 關閉所有模擬器並重試
xcrun simctl shutdown all
killall Simulator 2>/dev/null || true
./scripts/run.sh
```

### ❌ DerivedData 問題
```bash
# 刪除 DerivedData
rm -rf ~/Library/Developer/Xcode/DerivedData
./scripts/clean.sh
```

---

## 更多資訊

### 📚 詳細文件
- [Xcode CLI 完整指南](docs/dev/notes/xcode-cli-guide.md) - Command line 操作完整說明
- [CLAUDE.md](CLAUDE.md) - 專案架構與規範
- [開發標準](docs/dev/notes/development-standards.md) - 程式碼規範
- [Git Flow](docs/dev/github/git-flow.md) - 分支管理策略

### 🔗 相關連結
- [GitHub Repository](https://github.com/intervalrain/TidalHabits)
- [GitHub Project](https://github.com/users/intervalrain/projects/4)
- [Issues](https://github.com/intervalrain/TidalHabits/issues)

### 🛠️ 工具
- [xcodegen](https://github.com/yonaskolb/XcodeGen) - 專案生成工具
- [SwiftLint](https://github.com/realm/SwiftLint) - Swift 程式碼檢查
- [GitHub CLI](https://cli.github.com/) - GitHub 命令列工具

---

**專案版本:** v0.2.0-dev
**iOS 最低版本:** 16.0+
**Swift 版本:** 5.9+
**最後更新:** 2025-10-28
