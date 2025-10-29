# Phase 4: Rewards Feature - 獎勵系統

實作獎勵系統，包含星星累積、自訂獎勵項目、兌換機制等。

**目標**: 完成獎勵系統功能，與 Pomodoro Feature 整合。

**預估時間**: 3-4 天

**前置條件**: Phase 1, 2, 3 已完成

---

## Stage 4.1: Rewards Domain Layer

建立獎勵系統的領域模型。

### Checklist

#### Value Objects
- [ ] StarsBalance (TidalHabits/Features/Rewards/Domain/ValueObjects/StarsBalance.swift)
  - 依賴: Core/Domain/Common/ValueObject
- [ ] RewardCost (TidalHabits/Features/Rewards/Domain/ValueObjects/RewardCost.swift)
  - 依賴: Core/Domain/Common/ValueObject
- [ ] RewardName (TidalHabits/Features/Rewards/Domain/ValueObjects/RewardName.swift)
  - 依賴: Core/Domain/Common/ValueObject

#### Domain Events
- [ ] StarsEarnedEvent (TidalHabits/Features/Rewards/Domain/Events/StarsEarnedEvent.swift)
  - 依賴: Core/Domain/Common/IDomainEvent
- [ ] RewardCreatedEvent (TidalHabits/Features/Rewards/Domain/Events/RewardCreatedEvent.swift)
  - 依賴: Core/Domain/Common/IDomainEvent
- [ ] RewardRedeemedEvent (TidalHabits/Features/Rewards/Domain/Events/RewardRedeemedEvent.swift)
  - 依賴: Core/Domain/Common/IDomainEvent

#### Entities
- [ ] UserStarsAccount (TidalHabits/Features/Rewards/Domain/Entities/UserStarsAccount.swift)
  - 依賴: Core/Domain/Common/AggregateRoot
  - 依賴: StarsBalance, Domain Events
- [ ] Reward (TidalHabits/Features/Rewards/Domain/Entities/Reward.swift)
  - 依賴: Core/Domain/Common/AggregateRoot
  - 依賴: RewardName, RewardCost, Domain Events
- [ ] RewardRedemption (TidalHabits/Features/Rewards/Domain/Entities/RewardRedemption.swift)
  - 依賴: Core/Domain/Common/Entity
  - 依賴: Reward, UserStarsAccount

#### Domain Services
- [ ] StarsCalculationService (TidalHabits/Features/Rewards/Domain/Services/StarsCalculationService.swift)
  - 依賴: Pomodoro/Domain/Entities/PomodoroSession
- [ ] RewardRedemptionService (TidalHabits/Features/Rewards/Domain/Services/RewardRedemptionService.swift)
  - 依賴: UserStarsAccount, Reward

#### Repository Interfaces
- [ ] IUserStarsAccountRepository (TidalHabits/Features/Rewards/Domain/Repositories/IUserStarsAccountRepository.swift)
  - 依賴: Core/Domain/Interfaces/IRepository
  - 依賴: UserStarsAccount
- [ ] IRewardRepository (TidalHabits/Features/Rewards/Domain/Repositories/IRewardRepository.swift)
  - 依賴: Core/Domain/Interfaces/IRepository
  - 依賴: Reward
- [ ] IRewardRedemptionRepository (TidalHabits/Features/Rewards/Domain/Repositories/IRewardRedemptionRepository.swift)
  - 依賴: Core/Domain/Interfaces/IRepository
  - 依賴: RewardRedemption

---

## Stage 4.2: Rewards Application Layer - Commands

實作獎勵系統的寫入操作。

### Checklist

#### Earn Stars
- [ ] EarnStarsCommand (TidalHabits/Features/Rewards/Application/Commands/EarnStars/EarnStarsCommand.swift)
  - 依賴: Core/Application/Common/ICommand
- [ ] EarnStarsCommandHandler (TidalHabits/Features/Rewards/Application/Commands/EarnStars/EarnStarsCommandHandler.swift)
  - 依賴: Core/Application/Common/ICommandHandler
  - 依賴: EarnStarsCommand, IUserStarsAccountRepository, IUnitOfWork

#### Create Reward
- [ ] CreateRewardCommand (TidalHabits/Features/Rewards/Application/Commands/CreateReward/CreateRewardCommand.swift)
  - 依賴: Core/Application/Common/ICommand
- [ ] CreateRewardCommandValidator (TidalHabits/Features/Rewards/Application/Commands/CreateReward/CreateRewardCommandValidator.swift)
  - 依賴: CreateRewardCommand
- [ ] CreateRewardCommandHandler (TidalHabits/Features/Rewards/Application/Commands/CreateReward/CreateRewardCommandHandler.swift)
  - 依賴: Core/Application/Common/ICommandHandler
  - 依賴: CreateRewardCommand, IRewardRepository, IUnitOfWork

#### Update Reward
- [ ] UpdateRewardCommand (TidalHabits/Features/Rewards/Application/Commands/UpdateReward/UpdateRewardCommand.swift)
  - 依賴: Core/Application/Common/ICommand
- [ ] UpdateRewardCommandHandler (TidalHabits/Features/Rewards/Application/Commands/UpdateReward/UpdateRewardCommandHandler.swift)
  - 依賴: Core/Application/Common/ICommandHandler
  - 依賴: UpdateRewardCommand, IRewardRepository, IUnitOfWork

#### Delete Reward
- [ ] DeleteRewardCommand (TidalHabits/Features/Rewards/Application/Commands/DeleteReward/DeleteRewardCommand.swift)
  - 依賴: Core/Application/Common/ICommand
- [ ] DeleteRewardCommandHandler (TidalHabits/Features/Rewards/Application/Commands/DeleteReward/DeleteRewardCommandHandler.swift)
  - 依賴: Core/Application/Common/ICommandHandler
  - 依賴: DeleteRewardCommand, IRewardRepository, IUnitOfWork

#### Redeem Reward
- [ ] RedeemRewardCommand (TidalHabits/Features/Rewards/Application/Commands/RedeemReward/RedeemRewardCommand.swift)
  - 依賴: Core/Application/Common/ICommand
- [ ] RedeemRewardCommandHandler (TidalHabits/Features/Rewards/Application/Commands/RedeemReward/RedeemRewardCommandHandler.swift)
  - 依賴: Core/Application/Common/ICommandHandler
  - 依賴: RedeemRewardCommand, IUserStarsAccountRepository, IRewardRepository, IRewardRedemptionRepository
  - 依賴: RewardRedemptionService

---

## Stage 4.3: Rewards Application Layer - Queries

實作獎勵系統的讀取操作。

### Checklist

#### DTOs
- [ ] StarsBalanceDto (TidalHabits/Features/Rewards/Application/DTOs/StarsBalanceDto.swift)
- [ ] RewardDto (TidalHabits/Features/Rewards/Application/DTOs/RewardDto.swift)
- [ ] RewardListItemDto (TidalHabits/Features/Rewards/Application/DTOs/RewardListItemDto.swift)
- [ ] RewardRedemptionDto (TidalHabits/Features/Rewards/Application/DTOs/RewardRedemptionDto.swift)

#### Get Stars Balance
- [ ] GetStarsBalanceQuery (TidalHabits/Features/Rewards/Application/Queries/GetStarsBalance/GetStarsBalanceQuery.swift)
  - 依賴: Core/Application/Common/IQuery
- [ ] GetStarsBalanceQueryHandler (TidalHabits/Features/Rewards/Application/Queries/GetStarsBalance/GetStarsBalanceQueryHandler.swift)
  - 依賴: Core/Application/Common/IQueryHandler
  - 依賴: GetStarsBalanceQuery, IUserStarsAccountRepository
  - 依賴: StarsBalanceDto

#### Get Rewards
- [ ] GetRewardsQuery (TidalHabits/Features/Rewards/Application/Queries/GetRewards/GetRewardsQuery.swift)
  - 依賴: Core/Application/Common/IQuery
- [ ] GetRewardsQueryHandler (TidalHabits/Features/Rewards/Application/Queries/GetRewards/GetRewardsQueryHandler.swift)
  - 依賴: Core/Application/Common/IQueryHandler
  - 依賴: GetRewardsQuery, IRewardRepository
  - 依賴: RewardListItemDto

#### Get Reward By Id
- [ ] GetRewardByIdQuery (TidalHabits/Features/Rewards/Application/Queries/GetRewardById/GetRewardByIdQuery.swift)
  - 依賴: Core/Application/Common/IQuery
- [ ] GetRewardByIdQueryHandler (TidalHabits/Features/Rewards/Application/Queries/GetRewardById/GetRewardByIdQueryHandler.swift)
  - 依賴: Core/Application/Common/IQueryHandler
  - 依賴: GetRewardByIdQuery, IRewardRepository
  - 依賴: RewardDto

#### Get Redemption History
- [ ] GetRedemptionHistoryQuery (TidalHabits/Features/Rewards/Application/Queries/GetRedemptionHistory/GetRedemptionHistoryQuery.swift)
  - 依賴: Core/Application/Common/IQuery
- [ ] GetRedemptionHistoryQueryHandler (TidalHabits/Features/Rewards/Application/Queries/GetRedemptionHistory/GetRedemptionHistoryQueryHandler.swift)
  - 依賴: Core/Application/Common/IQueryHandler
  - 依賴: GetRedemptionHistoryQuery, IRewardRedemptionRepository
  - 依賴: RewardRedemptionDto

---

## Stage 4.4: Rewards Infrastructure Layer

實作 Repository 和 CoreData 配置。

### Checklist

#### CoreData Configuration
- [ ] UserStarsAccountEntity.xcdatamodel (TidalHabits/TidalHabits.xcdatamodeld/UserStarsAccountEntity.xcdatamodel)
- [ ] RewardEntity.xcdatamodel (TidalHabits/TidalHabits.xcdatamodeld/RewardEntity.xcdatamodel)
- [ ] RewardRedemptionEntity.xcdatamodel (TidalHabits/TidalHabits.xcdatamodeld/RewardRedemptionEntity.xcdatamodel)
- [ ] RewardsConfiguration (TidalHabits/Features/Rewards/Infrastructure/Configurations/RewardsConfiguration.swift)

#### Repository Implementations
- [ ] UserStarsAccountRepository (TidalHabits/Features/Rewards/Infrastructure/Repositories/UserStarsAccountRepository.swift)
  - 依賴: BaseRepository, IUserStarsAccountRepository, AppDbContext
- [ ] RewardRepository (TidalHabits/Features/Rewards/Infrastructure/Repositories/RewardRepository.swift)
  - 依賴: BaseRepository, IRewardRepository, AppDbContext
- [ ] RewardRedemptionRepository (TidalHabits/Features/Rewards/Infrastructure/Repositories/RewardRedemptionRepository.swift)
  - 依賴: BaseRepository, IRewardRedemptionRepository, AppDbContext

---

## Stage 4.5: Rewards Presentation Layer

實作獎勵系統的 UI 層。

### Checklist

#### ViewModels
- [ ] StarsBalanceViewModel (TidalHabits/Features/Rewards/Presentation/ViewModels/StarsBalanceViewModel.swift)
  - 依賴: GetStarsBalanceQueryHandler
  - 依賴: StarsBalanceDto
- [ ] RewardListViewModel (TidalHabits/Features/Rewards/Presentation/ViewModels/RewardListViewModel.swift)
  - 依賴: GetRewardsQueryHandler, DeleteRewardCommandHandler, RedeemRewardCommandHandler
  - 依賴: RewardListItemDto
- [ ] RewardFormViewModel (TidalHabits/Features/Rewards/Presentation/ViewModels/RewardFormViewModel.swift)
  - 依賴: CreateRewardCommandHandler, UpdateRewardCommandHandler
- [ ] RedemptionHistoryViewModel (TidalHabits/Features/Rewards/Presentation/ViewModels/RedemptionHistoryViewModel.swift)
  - 依賴: GetRedemptionHistoryQueryHandler
  - 依賴: RewardRedemptionDto

#### Views
- [ ] StarsBalanceView (TidalHabits/Features/Rewards/Presentation/Views/StarsBalanceView.swift)
  - 依賴: StarsBalanceViewModel
- [ ] RewardListView (TidalHabits/Features/Rewards/Presentation/Views/RewardListView.swift)
  - 依賴: RewardListViewModel
- [ ] RewardFormView (TidalHabits/Features/Rewards/Presentation/Views/RewardFormView.swift)
  - 依賴: RewardFormViewModel
- [ ] RedemptionHistoryView (TidalHabits/Features/Rewards/Presentation/Views/RedemptionHistoryView.swift)
  - 依賴: RedemptionHistoryViewModel

#### Components
- [ ] StarsDisplayView (TidalHabits/Features/Rewards/Presentation/Views/Components/StarsDisplayView.swift)
- [ ] RewardCardView (TidalHabits/Features/Rewards/Presentation/Views/Components/RewardCardView.swift)
- [ ] RedeemButtonView (TidalHabits/Features/Rewards/Presentation/Views/Components/RedeemButtonView.swift)

---

## Stage 4.6: 測試

為 Rewards Feature 建立完整測試。

### Checklist

#### Domain Tests
- [ ] UserStarsAccountTests (TidalHabitsTests/Unit/Features/Rewards/Domain/Entities/UserStarsAccountTests.swift)
- [ ] RewardTests (TidalHabitsTests/Unit/Features/Rewards/Domain/Entities/RewardTests.swift)
- [ ] RewardRedemptionServiceTests (TidalHabitsTests/Unit/Features/Rewards/Domain/Services/RewardRedemptionServiceTests.swift)

#### Application Tests - Commands
- [ ] EarnStarsCommandHandlerTests (TidalHabitsTests/Unit/Features/Rewards/Application/Commands/EarnStarsCommandHandlerTests.swift)
- [ ] CreateRewardCommandHandlerTests (TidalHabitsTests/Unit/Features/Rewards/Application/Commands/CreateRewardCommandHandlerTests.swift)
- [ ] RedeemRewardCommandHandlerTests (TidalHabitsTests/Unit/Features/Rewards/Application/Commands/RedeemRewardCommandHandlerTests.swift)

#### Application Tests - Queries
- [ ] GetStarsBalanceQueryHandlerTests (TidalHabitsTests/Unit/Features/Rewards/Application/Queries/GetStarsBalanceQueryHandlerTests.swift)
- [ ] GetRewardsQueryHandlerTests (TidalHabitsTests/Unit/Features/Rewards/Application/Queries/GetRewardsQueryHandlerTests.swift)

#### Infrastructure Tests
- [ ] UserStarsAccountRepositoryTests (TidalHabitsTests/Integration/Features/Rewards/Infrastructure/UserStarsAccountRepositoryTests.swift)
- [ ] RewardRepositoryTests (TidalHabitsTests/Integration/Features/Rewards/Infrastructure/RewardRepositoryTests.swift)

#### Presentation Tests
- [ ] RewardListViewModelTests (TidalHabitsTests/Unit/Features/Rewards/Presentation/ViewModels/RewardListViewModelTests.swift)

#### UI Tests
- [ ] RewardListUITests (TidalHabitsUITests/Features/Rewards/RewardListUITests.swift)

---

## 完成標準

- [ ] 所有 Rewards Feature 檔案已建立
- [ ] 所有檔案編譯無錯誤
- [ ] Domain 層單元測試覆蓋率 ≥ 90%
- [ ] Application 層單元測試覆蓋率 ≥ 80%
- [ ] Presentation 層單元測試覆蓋率 ≥ 60%
- [ ] 所有測試通過
- [ ] UI 功能正常運作
- [ ] 與 Pomodoro Feature 整合正常（自動賺取星星）
- [ ] SwiftLint 檢查通過
- [ ] 程式碼已 Code Review
- [ ] 文件已更新

---

## 下一步

完成 Phase 4 後，進入 **Phase 5: Statistics Feature** - 統計分析功能
