# GitHub Project 手動建立指南

由於 GitHub CLI 需要特定權限，以下是兩種建立 Project 的方法：

## 方法 1: 使用 GitHub CLI (需要授權)

### 1. 授權 project scope

在 terminal 中執行：

\`\`\`bash
gh auth refresh -h github.com -s project
\`\`\`

這會開啟瀏覽器，請登入並授權 `project` scope。

### 2. 執行設定腳本

\`\`\`bash
./scripts/setup-project.sh
\`\`\`

## 方法 2: 使用 GitHub Web UI (最簡單，推薦)

### 1. 前往 Projects 頁面

訪問: https://github.com/intervalrain/TidalHabits/projects

### 2. 建立新的 Project

1. 點擊 **"New project"** 按鈕
2. 選擇 **"Board"** 模板 (或 Table)
3. 命名: **"TidalHabits Development"**
4. 點擊 **"Create"**

### 3. 設定 Project 欄位

預設會有以下欄位：
- **Status**: Todo, In Progress, Done

建議新增以下欄位：

#### Priority (Single select)
- Critical (紅色)
- High (橙色)
- Medium (黃色)
- Low (綠色)

#### Phase (Single select)
- Phase 1 - MVP (藍色)
- Phase 2 - Enhancement (紫色)
- Phase 3 - Watch (粉紅色)

### 4. 加入 Issues

#### 方法 A: 批次加入所有 Issues

1. 在 Project 頁面點擊 **"+ Add item"**
2. 點擊 **"Add item from repository"**
3. 選擇 repository: `intervalrain/TidalHabits`
4. 使用篩選器：
   - 輸入 `is:issue is:open`
   - 按 Enter
5. 點擊 **"Select all"** (選擇所有)
6. 點擊 **"Add selected items"**

#### 方法 B: 使用 Milestone 篩選

對每個 Milestone 分別加入：

1. 篩選器輸入: `is:issue is:open milestone:"v0.3.0 - Habit Feature"`
2. 選擇所有並加入
3. 重複其他 Milestones:
   - `milestone:"v0.4.0 - Pomodoro Feature"`
   - `milestone:"v0.5.0 - Settings & Reward"`
   - `milestone:"v0.6.0 - Home & Navigation"`
   - `milestone:"v1.0.0-beta.1 - MVP Beta"`
   - `milestone:"v1.0.0 - MVP Release"`

### 5. 組織 Issues

#### 依 Status 組織

- **Todo**: 所有未開始的 Issues
- **In Progress**: 正在進行的 Issues
- **Done**: 已完成的 Issues

#### 依 Priority 排序

1. 點擊 Priority 欄位
2. 根據重要性設定:
   - Critical: 核心功能、阻塞性問題
   - High: 重要功能
   - Medium: 次要功能
   - Low: 可選功能

#### 依 Phase 分類

- **Phase 1 - MVP**: v0.3.0 到 v1.0.0 的 Issues
- **Phase 2 - Enhancement**: v1.1.0 到 v1.3.0
- **Phase 3 - Watch**: v2.0.0

### 6. 使用 Views 組織

建立不同的視圖來追蹤進度：

#### View 1: By Milestone (預設)
- Group by: Milestone
- Sort by: Created date

#### View 2: By Priority
- Group by: Priority
- Sort by: Priority (Critical → Low)

#### View 3: By Status
- Group by: Status
- Filter: is:open

#### View 4: Current Sprint
- Filter: milestone:"v0.3.0 - Habit Feature" status:"In Progress"

## 方法 3: 使用 API Token (進階)

如果您想使用自動化腳本但 CLI 授權有問題，可以：

### 1. 建立 Personal Access Token

1. 前往: https://github.com/settings/tokens
2. 點擊 "Generate new token" → "Generate new token (classic)"
3. 選擇以下 scopes:
   - `repo` (完整)
   - `project` (完整)
4. 複製 token

### 2. 設定環境變數

\`\`\`bash
export GH_TOKEN="your_token_here"
\`\`\`

### 3. 執行腳本

\`\`\`bash
./scripts/setup-project.sh
\`\`\`

## 完成檢查清單

- [ ] Project 已建立
- [ ] 90 個 Issues 已加入
- [ ] Status 欄位已設定 (Todo/In Progress/Done)
- [ ] Priority 欄位已建立
- [ ] Phase 欄位已建立
- [ ] Issues 已依 Milestone 組織
- [ ] 建立了不同的 Views

## 參考資源

- [GitHub Projects 文件](https://docs.github.com/en/issues/planning-and-tracking-with-projects)
- [Projects V2 API](https://docs.github.com/en/graphql/reference/objects#projectv2)

---

建立完成後，您的 Project 應該看起來像這樣：

\`\`\`
TidalHabits Development
├── Todo (70+ Issues)
├── In Progress (0)
└── Done (0)

依 Milestone 組織:
├── v0.3.0 - Habit Feature (22)
├── v0.4.0 - Pomodoro Feature (21)
├── v0.5.0 - Settings & Reward (24)
├── v0.6.0 - Home & Navigation (15)
├── v1.0.0-beta.1 - MVP Beta (4)
└── v1.0.0 - MVP Release (4)
\`\`\`

開始開發時，只需要將 Issue 從 Todo 拖到 In Progress 即可！
