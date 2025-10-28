#!/bin/bash

# TidalHabits - GitHub Project 設定腳本
# 建立 GitHub Project 並將所有 Issues 加入

REPO="intervalrain/TidalHabits"
OWNER="intervalrain"

echo "🚀 開始設定 TidalHabits GitHub Project..."
echo ""

# 檢查授權
echo "📋 檢查 GitHub CLI 授權狀態..."
if ! gh auth status 2>&1 | grep -q "project"; then
    echo "⚠️  需要授權 project scope"
    echo "請執行以下命令授權："
    echo "  gh auth refresh -s project"
    echo ""
    read -p "是否現在執行授權? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        gh auth refresh -s project
    else
        echo "❌ 授權已取消，請手動執行: gh auth refresh -s project"
        exit 1
    fi
fi

echo "✅ 授權檢查完成"
echo ""

# 建立 Project
echo "📊 建立 GitHub Project..."
PROJECT_OUTPUT=$(gh project create \
    --owner "$OWNER" \
    --title "TidalHabits Development" \
    --format json 2>&1)

if [ $? -ne 0 ]; then
    echo "❌ 建立 Project 失敗"
    echo "$PROJECT_OUTPUT"
    exit 1
fi

PROJECT_NUMBER=$(echo "$PROJECT_OUTPUT" | jq -r '.number')
PROJECT_URL=$(echo "$PROJECT_OUTPUT" | jq -r '.url')

echo "✅ Project 建立成功!"
echo "   Project Number: $PROJECT_NUMBER"
echo "   URL: $PROJECT_URL"
echo ""

# 取得 Project ID (用於 GraphQL API)
echo "🔍 取得 Project ID..."
PROJECT_ID=$(gh api graphql -f query='
query($owner: String!, $number: Int!) {
  user(login: $owner) {
    projectV2(number: $number) {
      id
    }
  }
}' -f owner="$OWNER" -F number="$PROJECT_NUMBER" --jq '.data.user.projectV2.id')

echo "   Project ID: $PROJECT_ID"
echo ""

# 取得所有 Issues
echo "📝 取得所有 Issues..."
ISSUES=$(gh issue list --repo "$REPO" --limit 100 --json number,id --jq '.[] | "\(.id)"')
ISSUE_COUNT=$(echo "$ISSUES" | wc -l | tr -d ' ')

echo "   找到 $ISSUE_COUNT 個 Issues"
echo ""

# 將 Issues 加入 Project
echo "➕ 將 Issues 加入 Project..."
ADDED_COUNT=0
FAILED_COUNT=0

for ISSUE_ID in $ISSUES; do
    RESULT=$(gh api graphql -f query='
    mutation($project: ID!, $item: ID!) {
      addProjectV2ItemById(input: {projectId: $project, contentId: $item}) {
        item {
          id
        }
      }
    }' -f project="$PROJECT_ID" -f item="$ISSUE_ID" 2>&1)

    if [ $? -eq 0 ]; then
        ((ADDED_COUNT++))
        echo "   ✓ Issue 已加入 ($ADDED_COUNT/$ISSUE_COUNT)"
    else
        ((FAILED_COUNT++))
        echo "   ✗ Issue 加入失敗"
    fi
done

echo ""
echo "✅ Issues 加入完成!"
echo "   成功: $ADDED_COUNT"
echo "   失敗: $FAILED_COUNT"
echo ""

# 建立自訂欄位
echo "🎨 設定 Project 欄位..."

# 1. Priority 欄位
echo "   建立 Priority 欄位..."
gh api graphql -f query='
mutation($project: ID!) {
  createProjectV2Field(input: {
    projectId: $project
    dataType: SINGLE_SELECT
    name: "Priority"
    singleSelectOptions: [
      {name: "Critical", color: RED, description: "Critical priority"},
      {name: "High", color: ORANGE, description: "High priority"},
      {name: "Medium", color: YELLOW, description: "Medium priority"},
      {name: "Low", color: GREEN, description: "Low priority"}
    ]
  }) {
    projectV2Field {
      ... on ProjectV2SingleSelectField {
        id
        name
      }
    }
  }
}' -f project="$PROJECT_ID" > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "   ✓ Priority 欄位建立成功"
else
    echo "   ✗ Priority 欄位建立失敗 (可能已存在)"
fi

# 2. Phase 欄位
echo "   建立 Phase 欄位..."
gh api graphql -f query='
mutation($project: ID!) {
  createProjectV2Field(input: {
    projectId: $project
    dataType: SINGLE_SELECT
    name: "Phase"
    singleSelectOptions: [
      {name: "Phase 1 - MVP", color: BLUE, description: "Phase 1"},
      {name: "Phase 2 - Enhancement", color: PURPLE, description: "Phase 2"},
      {name: "Phase 3 - Watch", color: PINK, description: "Phase 3"}
    ]
  }) {
    projectV2Field {
      ... on ProjectV2SingleSelectField {
        id
        name
      }
    }
  }
}' -f project="$PROJECT_ID" > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "   ✓ Phase 欄位建立成功"
else
    echo "   ✗ Phase 欄位建立失敗 (可能已存在)"
fi

echo ""
echo "🎉 GitHub Project 設定完成!"
echo ""
echo "📊 專案資訊:"
echo "   Project: TidalHabits Development"
echo "   Number: #$PROJECT_NUMBER"
echo "   URL: $PROJECT_URL"
echo "   Issues: $ADDED_COUNT/$ISSUE_COUNT"
echo ""
echo "📝 下一步:"
echo "1. 訪問 Project: $PROJECT_URL"
echo "2. 調整 Issues 的 Status (Todo/In Progress/Done)"
echo "3. 設定 Priority 和 Phase"
echo "4. 開始開發第一個 Issue!"
echo ""
echo "🚀 Ready to start development!"
