#!/bin/bash
set -e

echo "🔧 Rebuilding Xcode project from project.yml..."

# 檢查 xcodegen 是否安裝
if ! command -v xcodegen &> /dev/null; then
    echo "❌ xcodegen not found. Installing..."
    brew install xcodegen
fi

# 刪除舊專案
if [ -d "TidalHabits.xcodeproj" ]; then
    echo "🗑️  Removing old project..."
    rm -rf TidalHabits.xcodeproj
fi

# 生成新專案
echo "⚙️  Generating project..."
xcodegen generate

# 修正專案格式版本
echo "🔧 Fixing project format version..."
sed -i '' 's/objectVersion = 77;/objectVersion = 56;/' TidalHabits.xcodeproj/project.pbxproj

echo "✅ Project regenerated successfully!"
echo "📂 Open with: open TidalHabits.xcodeproj"
