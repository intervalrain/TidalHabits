#!/bin/bash

# TidalHabits GitHub Repository Setup Script
# 使用 GitHub CLI 自動設定 Repository

set -e  # 遇到錯誤立即停止

REPO="intervalrain/TidalHabits"

echo "🚀 TidalHabits GitHub Repository Setup"
echo "======================================="
echo ""

# 檢查 GitHub CLI 是否已安裝
if ! command -v gh &> /dev/null; then
    echo "❌ Error: GitHub CLI (gh) is not installed."
    echo "Please install it first: brew install gh"
    exit 1
fi

# 檢查是否已登入
if ! gh auth status &> /dev/null; then
    echo "📝 GitHub CLI is not authenticated."
    echo "Please run: gh auth login"
    exit 1
fi

echo "✅ GitHub CLI is authenticated"
echo ""

# =============================================================================
# 1. 建立 Labels
# =============================================================================

echo "📌 Step 1: Creating Labels..."
echo ""

# Type Labels
gh label create "feature" --description "New feature" --color "0E8A16" --repo $REPO --force 2>/dev/null || echo "  ℹ️  Label 'feature' already exists"
gh label create "bug" --description "Bug fix" --color "D73A4A" --repo $REPO --force 2>/dev/null || echo "  ℹ️  Label 'bug' already exists"
gh label create "enhancement" --description "Enhancement to existing feature" --color "A2EEEF" --repo $REPO --force 2>/dev/null || echo "  ℹ️  Label 'enhancement' already exists"
gh label create "refactor" --description "Code refactoring" --color "FBCA04" --repo $REPO --force 2>/dev/null || echo "  ℹ️  Label 'refactor' already exists"
gh label create "docs" --description "Documentation" --color "0075CA" --repo $REPO --force 2>/dev/null || echo "  ℹ️  Label 'docs' already exists"
gh label create "test" --description "Testing related" --color "1D76DB" --repo $REPO --force 2>/dev/null || echo "  ℹ️  Label 'test' already exists"
gh label create "chore" --description "Maintenance and chores" --color "FEF2C0" --repo $REPO --force 2>/dev/null || echo "  ℹ️  Label 'chore' already exists"

# Priority Labels
gh label create "priority: critical" --description "Critical priority" --color "B60205" --repo $REPO --force 2>/dev/null || echo "  ℹ️  Label 'priority: critical' already exists"
gh label create "priority: high" --description "High priority" --color "D93F0B" --repo $REPO --force 2>/dev/null || echo "  ℹ️  Label 'priority: high' already exists"
gh label create "priority: medium" --description "Medium priority" --color "FBCA04" --repo $REPO --force 2>/dev/null || echo "  ℹ️  Label 'priority: medium' already exists"
gh label create "priority: low" --description "Low priority" --color "0E8A16" --repo $REPO --force 2>/dev/null || echo "  ℹ️  Label 'priority: low' already exists"

# Status Labels
gh label create "status: planning" --description "In planning phase" --color "EDEDED" --repo $REPO --force 2>/dev/null || echo "  ℹ️  Label 'status: planning' already exists"
gh label create "status: in-progress" --description "Currently in progress" --color "0052CC" --repo $REPO --force 2>/dev/null || echo "  ℹ️  Label 'status: in-progress' already exists"
gh label create "status: blocked" --description "Blocked by dependencies" --color "B60205" --repo $REPO --force 2>/dev/null || echo "  ℹ️  Label 'status: blocked' already exists"
gh label create "status: review" --description "In code review" --color "5319E7" --repo $REPO --force 2>/dev/null || echo "  ℹ️  Label 'status: review' already exists"

# Module Labels
gh label create "module: habit" --description "Habit management module" --color "C5DEF5" --repo $REPO --force 2>/dev/null || echo "  ℹ️  Label 'module: habit' already exists"
gh label create "module: pomodoro" --description "Pomodoro timer module" --color "C5DEF5" --repo $REPO --force 2>/dev/null || echo "  ℹ️  Label 'module: pomodoro' already exists"
gh label create "module: statistics" --description "Statistics module" --color "C5DEF5" --repo $REPO --force 2>/dev/null || echo "  ℹ️  Label 'module: statistics' already exists"
gh label create "module: calendar" --description "Calendar module" --color "C5DEF5" --repo $REPO --force 2>/dev/null || echo "  ℹ️  Label 'module: calendar' already exists"
gh label create "module: settings" --description "Settings module" --color "C5DEF5" --repo $REPO --force 2>/dev/null || echo "  ℹ️  Label 'module: settings' already exists"
gh label create "module: reward" --description "Reward system module" --color "C5DEF5" --repo $REPO --force 2>/dev/null || echo "  ℹ️  Label 'module: reward' already exists"

echo "✅ Labels created successfully"
echo ""

# =============================================================================
# 2. 建立 Milestones
# =============================================================================

echo "🎯 Step 2: Creating Milestones..."
echo ""

# Phase 1 Milestones
gh api repos/$REPO/milestones -f title="v0.2.0 - Core Foundation" -f state="open" -f description="建立核心基礎模組 (DDD, Extensions, Utilities)" -f due_on="2025-11-15T23:59:59Z" 2>/dev/null || echo "  ℹ️  Milestone 'v0.2.0' already exists"
gh api repos/$REPO/milestones -f title="v0.3.0 - Habit Feature" -f state="open" -f description="實作習慣管理完整功能 (CRUD)" -f due_on="2025-11-30T23:59:59Z" 2>/dev/null || echo "  ℹ️  Milestone 'v0.3.0' already exists"
gh api repos/$REPO/milestones -f title="v0.4.0 - Pomodoro Feature" -f state="open" -f description="實作番茄鐘核心功能" -f due_on="2025-12-15T23:59:59Z" 2>/dev/null || echo "  ℹ️  Milestone 'v0.4.0' already exists"
gh api repos/$REPO/milestones -f title="v0.5.0 - Settings & Reward" -f state="open" -f description="實作設定與獎勵系統" -f due_on="2025-12-25T23:59:59Z" 2>/dev/null || echo "  ℹ️  Milestone 'v0.5.0' already exists"
gh api repos/$REPO/milestones -f title="v0.6.0 - Home & Navigation" -f state="open" -f description="實作首頁與導航整合" -f due_on="2025-12-31T23:59:59Z" 2>/dev/null || echo "  ℹ️  Milestone 'v0.6.0' already exists"
gh api repos/$REPO/milestones -f title="v1.0.0-beta.1 - MVP Beta" -f state="open" -f description="Beta 測試版本" -f due_on="2026-01-15T23:59:59Z" 2>/dev/null || echo "  ℹ️  Milestone 'v1.0.0-beta.1' already exists"
gh api repos/$REPO/milestones -f title="v1.0.0 - MVP Release" -f state="open" -f description="正式發布 MVP 版本" -f due_on="2026-01-31T23:59:59Z" 2>/dev/null || echo "  ℹ️  Milestone 'v1.0.0' already exists"

# Phase 2 Milestones
gh api repos/$REPO/milestones -f title="v1.1.0 - Statistics" -f state="open" -f description="統計分析功能" -f due_on="2026-02-28T23:59:59Z" 2>/dev/null || echo "  ℹ️  Milestone 'v1.1.0' already exists"
gh api repos/$REPO/milestones -f title="v1.2.0 - Calendar" -f state="open" -f description="行事曆與熱度圖" -f due_on="2026-03-31T23:59:59Z" 2>/dev/null || echo "  ℹ️  Milestone 'v1.2.0' already exists"
gh api repos/$REPO/milestones -f title="v1.3.0 - Widget Support" -f state="open" -f description="iOS Widget 支援" -f due_on="2026-04-30T23:59:59Z" 2>/dev/null || echo "  ℹ️  Milestone 'v1.3.0' already exists"

# Phase 3 Milestones
gh api repos/$REPO/milestones -f title="v2.0.0 - Apple Watch" -f state="open" -f description="Apple Watch 整合" -f due_on="2026-06-30T23:59:59Z" 2>/dev/null || echo "  ℹ️  Milestone 'v2.0.0' already exists"

echo "✅ Milestones created successfully"
echo ""

# =============================================================================
# 3. 啟用功能
# =============================================================================

echo "⚙️  Step 3: Enabling Repository Features..."
echo ""

# 啟用 Issues
gh api -X PATCH repos/$REPO -f has_issues=true 2>/dev/null || echo "  ℹ️  Issues already enabled"

# 啟用 Projects
gh api -X PATCH repos/$REPO -f has_projects=true 2>/dev/null || echo "  ℹ️  Projects already enabled"

# 啟用 Discussions
gh api -X PATCH repos/$REPO -f has_discussions=true 2>/dev/null || echo "  ℹ️  Discussions already enabled"

# 啟用 Wiki
gh api -X PATCH repos/$REPO -f has_wiki=true 2>/dev/null || echo "  ℹ️  Wiki already enabled"

echo "✅ Repository features enabled"
echo ""

# =============================================================================
# 4. 設定 Repository 基本資訊
# =============================================================================

echo "📝 Step 4: Setting Repository Information..."
echo ""

gh api -X PATCH repos/$REPO \
  -f description="專注於自律習慣養成的 iOS App,採用 Clean Architecture + CQRS,支援番茄鐘計時、習慣追蹤與獎勵系統" \
  -f homepage="https://github.com/intervalrain/TidalHabits" \
  -F has_issues=true \
  -F has_projects=true \
  -F has_wiki=true \
  -F has_discussions=true \
  2>/dev/null || echo "  ℹ️  Repository info already set"

echo "✅ Repository information updated"
echo ""

# =============================================================================
# 5. 設定 Topics (標籤)
# =============================================================================

echo "🏷️  Step 5: Setting Repository Topics..."
echo ""

gh api -X PUT repos/$REPO/topics \
  -f names[]="ios" \
  -f names[]="swift" \
  -f names[]="swiftui" \
  -f names[]="clean-architecture" \
  -f names[]="cqrs" \
  -f names[]="tdd" \
  -f names[]="pomodoro" \
  -f names[]="habit-tracker" \
  -f names[]="productivity" \
  -f names[]="ios-app" \
  2>/dev/null || echo "  ℹ️  Topics already set"

echo "✅ Repository topics set"
echo ""

# =============================================================================
# 完成提示
# =============================================================================

echo ""
echo "✅ GitHub Repository Setup Complete!"
echo "===================================="
echo ""
echo "📋 Summary:"
echo "  ✓ Labels created (21 labels)"
echo "  ✓ Milestones created (11 milestones)"
echo "  ✓ Repository features enabled"
echo "  ✓ Repository information updated"
echo "  ✓ Topics set"
echo ""
echo "⚠️  Manual Steps Required (在 GitHub Web UI 操作):"
echo ""
echo "  1. 設定分支保護規則 (Branch Protection Rules)"
echo "     URL: https://github.com/$REPO/settings/branches"
echo ""
echo "     保護 'main' 分支:"
echo "     - Require a pull request before merging"
echo "     - Require approvals (1)"
echo "     - Require status checks to pass"
echo "     - Require conversation resolution"
echo "     - Require linear history"
echo ""
echo "     保護 'develop' 分支:"
echo "     - Require a pull request before merging"
echo "     - Require status checks to pass"
echo ""
echo "  2. 設定 Secrets (如需要 CI/CD)"
echo "     URL: https://github.com/$REPO/settings/secrets/actions"
echo "     - CODECOV_TOKEN (for code coverage)"
echo ""
echo "  3. 啟用 GitHub Actions"
echo "     URL: https://github.com/$REPO/settings/actions"
echo "     - Allow all actions and reusable workflows"
echo ""
echo "  4. 設定 Notifications"
echo "     URL: https://github.com/$REPO/settings/notifications"
echo ""
echo "📚 Next Steps:"
echo "  1. git push -u origin main"
echo "  2. git checkout -b develop && git push -u origin develop"
echo "  3. 在 GitHub 設定分支保護規則"
echo "  4. 建立第一個 Issue 並開始開發!"
echo ""
echo "🔗 Repository URL: https://github.com/$REPO"
echo ""
