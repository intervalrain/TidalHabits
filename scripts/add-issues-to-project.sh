#!/bin/bash

# TidalHabits - 將 Issues 加入 Project 腳本

PROJECT_ID="PVT_kwHOBBLams4BGoM4"
REPO="intervalrain/TidalHabits"

echo "🚀 開始將 Issues 加入 Project..."
echo ""

# 取得所有 Issues
echo "📝 取得所有 Issues..."
ISSUES_JSON=$(gh issue list --repo "$REPO" --limit 100 --json id,number,title)
ISSUE_COUNT=$(echo "$ISSUES_JSON" | jq 'length')

echo "找到 $ISSUE_COUNT 個 Issues"
echo ""

# 加入 Issues
echo "➕ 加入 Issues 到 Project..."
ADDED=0
FAILED=0

echo "$ISSUES_JSON" | jq -c '.[]' | while read -r issue; do
    ISSUE_ID=$(echo "$issue" | jq -r '.id')
    ISSUE_NUMBER=$(echo "$issue" | jq -r '.number')
    ISSUE_TITLE=$(echo "$issue" | jq -r '.title')

    # 使用 GraphQL mutation 加入 Issue
    RESULT=$(gh api graphql -f query="
        mutation {
          addProjectV2ItemById(input: {projectId: \"$PROJECT_ID\", contentId: \"$ISSUE_ID\"}) {
            item {
              id
            }
          }
        }
    " 2>&1)

    if echo "$RESULT" | jq -e '.data.addProjectV2ItemById.item.id' > /dev/null 2>&1; then
        ((ADDED++))
        echo "✓ #$ISSUE_NUMBER: $ISSUE_TITLE"
    else
        ((FAILED++))
        echo "✗ #$ISSUE_NUMBER: Failed"
    fi
done

echo ""
echo "✅ 完成!"
echo "   成功: $ADDED"
echo "   失敗: $FAILED"
echo ""
echo "🔗 查看 Project: https://github.com/users/intervalrain/projects/4"
