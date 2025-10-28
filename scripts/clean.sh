#!/bin/bash
set -e

echo "🧹 Cleaning TidalHabits project..."

# 清理建置
xcodebuild \
  -project TidalHabits.xcodeproj \
  -scheme TidalHabits \
  clean

# 刪除 DerivedData
echo "🗑️  Removing DerivedData..."
rm -rf ~/Library/Developer/Xcode/DerivedData/TidalHabits-*

# 關閉所有模擬器
echo "📱 Shutting down simulators..."
xcrun simctl shutdown all 2>/dev/null || true

echo "✅ Clean completed!"
