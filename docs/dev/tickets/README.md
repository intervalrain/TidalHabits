# TidalHabits 開發票務 (Development Tickets)

本目錄包含 TidalHabits 專案的分階段開發 checklist，依照依賴關係組織。

---

## 📋 票務概覽

### Phase 1: Core Foundation - 核心基礎建設
**檔案**: [phase-1-core-foundation.md](phase-1-core-foundation.md)

**目標**: 建立整個架構的基礎設施
- Stage 1.1: Domain 基礎介面與例外處理
- Stage 1.2: Domain 介面層
- Stage 1.3: Application CQRS 基礎
- Stage 1.4: Infrastructure 持久化層
- Stage 1.5: Shared 工具類別
- Stage 1.6: 單元測試

**預估時間**: 2-3 天

---

### Phase 2: Habits Feature - 習慣管理功能
**檔案**: [phase-2-habits-feature.md](phase-2-habits-feature.md)

**目標**: 實作第一個完整的 Feature
- Stage 2.1: Habits Domain Layer
- Stage 2.2: Habits Application Layer - Commands
- Stage 2.3: Habits Application Layer - Queries
- Stage 2.4: Habits Infrastructure Layer
- Stage 2.5: Habits Presentation Layer
- Stage 2.6: 測試

**預估時間**: 4-5 天
**前置條件**: Phase 1 完成

---

### Phase 3: Pomodoro Feature - 番茄鐘功能
**檔案**: [phase-3-pomodoro-feature.md](phase-3-pomodoro-feature.md)

**目標**: 實作番茄鐘計時功能
- Stage 3.1: Pomodoro Domain Layer
- Stage 3.2: Pomodoro Application Layer - Commands
- Stage 3.3: Pomodoro Application Layer - Queries
- Stage 3.4: Pomodoro Infrastructure Layer
- Stage 3.5: Pomodoro Presentation Layer
- Stage 3.6: 測試

**預估時間**: 4-5 天
**前置條件**: Phase 1, 2 完成

---

### Phase 4: Rewards Feature - 獎勵系統
**檔案**: [phase-4-rewards-feature.md](phase-4-rewards-feature.md)

**目標**: 實作獎勵系統功能
- Stage 4.1: Rewards Domain Layer
- Stage 4.2: Rewards Application Layer - Commands
- Stage 4.3: Rewards Application Layer - Queries
- Stage 4.4: Rewards Infrastructure Layer
- Stage 4.5: Rewards Presentation Layer
- Stage 4.6: 測試

**預估時間**: 3-4 天
**前置條件**: Phase 1, 2, 3 完成

---

### Phase 5: Statistics Feature - 統計分析功能
**檔案**: [phase-5-statistics-feature.md](phase-5-statistics-feature.md)

**目標**: 實作統計分析功能
- Stage 5.1: Statistics Domain Layer
- Stage 5.2: Statistics Application Layer - Queries
- Stage 5.3: Statistics Infrastructure Layer
- Stage 5.4: Statistics Presentation Layer
- Stage 5.5: 測試

**預估時間**: 4-5 天
**前置條件**: Phase 1, 2, 3, 4 完成

---

## 🎯 開發順序建議

```
Phase 1 (Core Foundation)
    ↓
Phase 2 (Habits)
    ↓
Phase 3 (Pomodoro)
    ↓
Phase 4 (Rewards)
    ↓
Phase 5 (Statistics)
```

---

## 📊 整體進度追蹤

### Phase 1: Core Foundation
- [ ] Stage 1.1: Domain 基礎介面與例外處理
- [ ] Stage 1.2: Domain 介面層
- [ ] Stage 1.3: Application CQRS 基礎
- [ ] Stage 1.4: Infrastructure 持久化層
- [ ] Stage 1.5: Shared 工具類別
- [ ] Stage 1.6: 單元測試

### Phase 2: Habits Feature
- [ ] Stage 2.1: Habits Domain Layer
- [ ] Stage 2.2: Habits Application Layer - Commands
- [ ] Stage 2.3: Habits Application Layer - Queries
- [ ] Stage 2.4: Habits Infrastructure Layer
- [ ] Stage 2.5: Habits Presentation Layer
- [ ] Stage 2.6: 測試

### Phase 3: Pomodoro Feature
- [ ] Stage 3.1: Pomodoro Domain Layer
- [ ] Stage 3.2: Pomodoro Application Layer - Commands
- [ ] Stage 3.3: Pomodoro Application Layer - Queries
- [ ] Stage 3.4: Pomodoro Infrastructure Layer
- [ ] Stage 3.5: Pomodoro Presentation Layer
- [ ] Stage 3.6: 測試

### Phase 4: Rewards Feature
- [ ] Stage 4.1: Rewards Domain Layer
- [ ] Stage 4.2: Rewards Application Layer - Commands
- [ ] Stage 4.3: Rewards Application Layer - Queries
- [ ] Stage 4.4: Rewards Infrastructure Layer
- [ ] Stage 4.5: Rewards Presentation Layer
- [ ] Stage 4.6: 測試

### Phase 5: Statistics Feature
- [ ] Stage 5.1: Statistics Domain Layer
- [ ] Stage 5.2: Statistics Application Layer - Queries
- [ ] Stage 5.3: Statistics Infrastructure Layer
- [ ] Stage 5.4: Statistics Presentation Layer
- [ ] Stage 5.5: 測試

---

## 🔧 使用方式

1. **選擇當前 Phase**: 從 Phase 1 開始
2. **開啟對應票務檔案**: 查看詳細的 checklist
3. **按照 Stage 順序實作**: 每個 Stage 內按照依賴順序執行
4. **完成後打勾**: 在對應的 checkbox 打勾
5. **進入下一階段**: 完成當前 Phase 的所有 Stages 後，進入下一個 Phase

---

## 📝 Checklist 格式說明

每個項目的格式為:
```
- [ ] 物件名稱 (檔案路徑)
  - 依賴: 依賴項目列表
```

範例:
```
- [ ] IEntity (TidalHabits/Core/Domain/Common/IEntity.swift)
- [ ] AggregateRoot (TidalHabits/Core/Domain/Common/AggregateRoot.swift)
  - 依賴: IEntity, IDomainEvent
```

---

## 🎓 開發原則

1. **遵循依賴順序**: 先完成被依賴的項目
2. **TDD 流程**: 先寫測試，再寫實作
3. **每個 Stage 一次 Commit**: 完成一個 Stage 後提交
4. **Code Review**: 每個 Phase 完成後進行 Review
5. **文件同步更新**: 實作時同步更新相關文件

---

## 📚 相關文件

- [架構設計](../../architecture.md) - 詳細的架構說明
- [CLAUDE.md](../../../CLAUDE.md) - 專案完整指南
- [開發規範](../notes/development-standards.md) - TDD 流程與編碼規範

---

**最後更新**: 2025-10-29
