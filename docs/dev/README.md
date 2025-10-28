# TidalHabits 開發文件

本目錄包含所有開發相關的文件,依類別組織如下:

## 📁 目錄結構

```
docs/dev/
├── github/              # GitHub 相關設定文件
│   ├── git-flow.md                  # Git Flow 規範
│   ├── git-flow-cheatsheet.md       # Git Flow 快速參考
│   ├── github-manual-setup.md       # GitHub 手動設定指南
│   ├── github-setup-todo.md         # GitHub 設定檢查清單
│   └── repository-info.md           # Repository 資訊
│
├── notes/               # 開發筆記與指南
│   ├── development-standards.md     # 開發規範與 TDD 流程
│   ├── getting-started.md           # 快速開始指南
│   └── setup-complete.md            # 專案設定完成報告
│
└── milestones/          # Milestone 與 Phase 規劃
    └── phases/
        └── milestones.md            # 詳細 Milestone 規劃
```

## 📚 文件索引

### GitHub 相關 (github/)

| 文件 | 說明 |
|-----|------|
| [git-flow.md](github/git-flow.md) | Git Flow 完整規範,包含分支策略、版本控制、CI/CD、Tag 策略 |
| [git-flow-cheatsheet.md](github/git-flow-cheatsheet.md) | Git Flow 常用命令快速參考 |
| [github-manual-setup.md](github/github-manual-setup.md) | GitHub Repository 手動設定詳細指南 |
| [github-setup-todo.md](github/github-setup-todo.md) | GitHub 設定檢查清單 |
| [repository-info.md](github/repository-info.md) | Repository 基本資訊與連結 |

### 開發筆記 (notes/)

| 文件 | 說明 |
|-----|------|
| [development-standards.md](notes/development-standards.md) | 完整開發規範,包含 TDD 流程、程式碼風格、Commit 規範 |
| [getting-started.md](notes/getting-started.md) | 開發環境設定與快速開始指南 |
| [setup-complete.md](notes/setup-complete.md) | 專案初始設定完成報告 |

### Milestone 規劃 (milestones/phases/)

| 文件 | 說明 |
|-----|------|
| [milestones.md](milestones/phases/milestones.md) | Phase 1-3 詳細 Milestone 規劃與 Issue 追蹤 |

## 🔗 相關文件

### 核心文件 (docs/)
- [架構設計](../architecture.md) - Clean Architecture + CQRS
- [專案結構](../project-structure.md) - 目錄組織與命名慣例
- [專案總結](../SUMMARY.md) - 專案概覽

### 功能規格 (docs/features/)
- [功能概述](../features/overview.md)
- [習慣管理](../features/habit/spec.md)
- [番茄鐘](../features/checkin/spec.md)
- [設定與獎勵](../features/settings/spec.md)

## 📖 快速導航

### 開始開發
1. 閱讀 [開發規範](notes/development-standards.md) 了解 TDD 流程
2. 參考 [快速開始](notes/getting-started.md) 設定環境
3. 查看 [Milestone 規劃](milestones/phases/milestones.md) 了解開發計畫

### Git 工作流程
1. 閱讀 [Git Flow 規範](github/git-flow.md) 了解分支策略
2. 使用 [Git Flow 快速參考](github/git-flow-cheatsheet.md) 查詢常用命令
3. 參考 [Repository 資訊](github/repository-info.md) 查看連結

### GitHub 設定
1. 查看 [GitHub 設定檢查清單](github/github-setup-todo.md)
2. 參考 [GitHub 手動設定指南](github/github-manual-setup.md) 完成設定

---

**TidalHabits** - 潮汐般穩定的習慣養成 🌊

_最後更新: 2025-10-28_
