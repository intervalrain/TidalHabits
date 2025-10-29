# Phase 1: Core Foundation - 核心基礎建設

建立整個架構的基礎設施，包含 DDD 基礎類別、CQRS 介面、Repository Pattern 等。

**目標**: 完成 Core 層的所有基礎建構，為 Feature 開發做準備。

**預估時間**: 2-3 天

---

## Stage 1.1: Domain 基礎介面與例外處理

建立 Domain 層最基礎的協定和例外類別，這些是其他所有類別的基礎。

### Checklist

#### 基礎類別
- [ ] Entity (TidalHabits/Core/Domain/Common/Entity.swift)
- [ ] ValueObject (TidalHabits/Core/Domain/Common/ValueObject.swift)

#### Domain 例外
- [ ] DomainException (TidalHabits/Core/Domain/Exceptions/DomainException.swift)

#### Aggregate Root
- [ ] AggregateRoot (TidalHabits/Core/Domain/Common/AggregateRoot.swift)
  - 依賴: Entity

---

## Stage 1.2: Domain 介面層

建立 Repository 和 Unit of Work 的介面定義。

### Checklist

#### Repository 介面
- [ ] IRepository (TidalHabits/Core/Domain/Interfaces/IRepository.swift)
  - 依賴: Entity

#### Unit of Work 介面
- [ ] IUnitOfWork (TidalHabits/Core/Domain/Interfaces/IUnitOfWork.swift)

---

## Stage 1.3: Application CQRS 基礎

建立 CQRS 模式的基礎介面。

### Checklist

#### Command 相關
- [ ] ICommand (TidalHabits/Core/Application/Common/ICommand.swift)
- [ ] ICommandHandler (TidalHabits/Core/Application/Common/ICommandHandler.swift)
  - 依賴: ICommand

#### Query 相關
- [ ] IQuery (TidalHabits/Core/Application/Common/IQuery.swift)
- [ ] IQueryHandler (TidalHabits/Core/Application/Common/IQueryHandler.swift)
  - 依賴: IQuery

#### Result 型別
- [ ] Result (TidalHabits/Core/Application/Common/Result.swift)

#### Application 例外
- [ ] ApplicationException (TidalHabits/Core/Application/Exceptions/ApplicationException.swift)

---

## Stage 1.4: Infrastructure 持久化層

實作 CoreData 的封裝與 Repository 基礎實作。

### Checklist

#### CoreData Context
- [ ] AppDbContext (TidalHabits/Core/Infrastructure/Persistence/AppDbContext.swift)
  - 依賴: Persistence.swift (現有的 CoreData stack)

#### Repository 實作
- [ ] BaseRepository (TidalHabits/Core/Infrastructure/Persistence/BaseRepository.swift)
  - 依賴: IRepository, AppDbContext, Entity

#### Unit of Work 實作
- [ ] UnitOfWork (TidalHabits/Core/Infrastructure/Persistence/UnitOfWork.swift)
  - 依賴: IUnitOfWork, AppDbContext

---

## Stage 1.5: Shared 工具類別

建立共用的擴充功能和工具類別。

### Checklist

#### Extensions
- [ ] Date+Extensions (TidalHabits/Core/Shared/Extensions/Date+Extensions.swift)
- [ ] String+Extensions (TidalHabits/Core/Shared/Extensions/String+Extensions.swift)
- [ ] Collection+Extensions (TidalHabits/Core/Shared/Extensions/Collection+Extensions.swift)
- [ ] UUID+Extensions (TidalHabits/Core/Shared/Extensions/UUID+Extensions.swift)

#### Utilities
- [ ] Logger (TidalHabits/Core/Shared/Utilities/Logger.swift)
- [ ] Validator (TidalHabits/Core/Shared/Utilities/Validator.swift)

---

## Stage 1.6: 單元測試

為 Core 層建立單元測試。

### Checklist

#### Domain Tests
- [ ] EntityTests (TidalHabitsTests/Unit/Core/Domain/EntityTests.swift)
- [ ] ValueObjectTests (TidalHabitsTests/Unit/Core/Domain/ValueObjectTests.swift)
- [ ] AggregateRootTests (TidalHabitsTests/Unit/Core/Domain/AggregateRootTests.swift)
- [ ] DomainEventTests (TidalHabitsTests/Unit/Core/Domain/DomainEventTests.swift)

#### Application Tests
- [ ] ResultTests (TidalHabitsTests/Unit/Core/Application/ResultTests.swift)

#### Infrastructure Tests
- [ ] BaseRepositoryTests (TidalHabitsTests/Integration/Core/Infrastructure/BaseRepositoryTests.swift)
- [ ] UnitOfWorkTests (TidalHabitsTests/Integration/Core/Infrastructure/UnitOfWorkTests.swift)

---

## 完成標準

- [ ] 所有 Core 層檔案已建立
- [ ] 所有檔案編譯無錯誤
- [ ] 單元測試覆蓋率 ≥ 80%
- [ ] 所有測試通過
- [ ] SwiftLint 檢查通過
- [ ] 程式碼已 Code Review
- [ ] 文件已更新

---

## 依賴關係圖

```
Stage 1.1 (Domain 基礎)
├── Entity
├── ValueObject
├── DomainException
└── AggregateRoot (依賴 Entity)

Stage 1.2 (Domain 介面)
├── IRepository (依賴 Entity)
└── IUnitOfWork

Stage 1.3 (Application CQRS)
├── ICommand
├── ICommandHandler (依賴 ICommand)
├── IQuery
├── IQueryHandler (依賴 IQuery)
├── Result
└── ApplicationException

Stage 1.4 (Infrastructure)
├── AppDbContext
├── BaseRepository (依賴 IRepository, AppDbContext, IEntity)
└── UnitOfWork (依賴 IUnitOfWork, AppDbContext)

Stage 1.5 (Shared)
├── Extensions (獨立)
└── Utilities (獨立)

Stage 1.6 (Tests)
└── 所有測試 (依賴前面的實作)
```

---

## 下一步

完成 Phase 1 後，進入 **Phase 2: Habits Feature** 實作第一個功能模組。
