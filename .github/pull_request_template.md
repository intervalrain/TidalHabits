# Pull Request

## 類型

請勾選適當的類型:

- [ ] Feature (新功能)
- [ ] Bugfix (Bug 修復)
- [ ] Refactor (重構)
- [ ] Docs (文件更新)
- [ ] Test (測試相關)
- [ ] Chore (建置工具、依賴更新等)

## 描述

### 這個 PR 做了什麼?

簡要描述這個 PR 的目的與變更內容。

### 關聯的 Issue

Closes #(issue number)

## 變更清單

- [ ] 變更項目 1
- [ ] 變更項目 2
- [ ] 變更項目 3

## 測試

### 測試涵蓋

- [ ] Unit Tests
- [ ] Integration Tests
- [ ] UI Tests
- [ ] Manual Testing

### 測試覆蓋率

- Domain Layer: X%
- Application Layer: X%
- Presentation Layer: X%
- Overall: X%

### 測試情境

描述你測試了哪些情境:

1. 測試情境 1
2. 測試情境 2
3. 邊界情況測試

## Code Review Checklist

### 架構

- [ ] 遵循 Clean Architecture 分層
- [ ] 依賴方向正確
- [ ] CQRS 模式正確使用
- [ ] Domain 邏輯在正確的層級

### 程式碼品質

- [ ] 命名清晰且有意義
- [ ] 函數職責單一 (SRP)
- [ ] 沒有重複程式碼 (DRY)
- [ ] 錯誤處理完整
- [ ] 沒有不安全的 force unwrap

### 測試

- [ ] 所有測試通過
- [ ] 測試覆蓋率達標 (≥ 75%)
- [ ] 測試命名清晰
- [ ] 測試有意義且不脆弱

### 文件

- [ ] Public API 有文件註解
- [ ] 複雜邏輯有說明註解
- [ ] README 或相關文件已更新 (如需要)

### 多語系

- [ ] UI 文字已本地化
- [ ] 支援所有指定語言

### 其他

- [ ] 無編譯警告
- [ ] SwiftLint 檢查通過 (如有使用)
- [ ] 遵循專案編碼規範
- [ ] 沒有 TODO 或 FIXME 未處理

## 截圖 / 錄影 (UI 變更時必填)

如果這個 PR 包含 UI 變更,請提供截圖或錄影。

### Before
<!-- 變更前的截圖 -->

### After
<!-- 變更後的截圖 -->

## 效能影響

- [ ] 無效能影響
- [ ] 效能改善
- [ ] 可能有效能影響 (請說明)

說明:

## Breaking Changes

- [ ] 無 Breaking Changes
- [ ] 有 Breaking Changes (請詳細說明)

說明:

## 部署注意事項

是否需要特殊的部署步驟或資料遷移?

- [ ] 不需要
- [ ] 需要 (請說明)

說明:

## 額外資訊

其他需要 reviewer 注意的事項。

---

## Reviewer 注意事項

請 reviewer 特別注意:

1. 項目 1
2. 項目 2

## 自我檢查

提交前請確認:

- [ ] 我已經在本地執行並通過所有測試
- [ ] 我已經自我 review 過程式碼
- [ ] 我已經更新相關文件
- [ ] 我的 commit 訊息遵循 Conventional Commits 規範
- [ ] 我已經在相關的 Issue 中加上這個 PR 的連結
