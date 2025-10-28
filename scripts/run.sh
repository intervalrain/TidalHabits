#!/bin/bash
set -e

SIMULATOR="iPhone 15 Pro"
BUNDLE_ID="com.intervalrain.TidalHabits"

echo "🔨 Building TidalHabits..."

# 建置
xcodebuild \
  -project TidalHabits.xcodeproj \
  -scheme TidalHabits \
  -destination "platform=iOS Simulator,name=$SIMULATOR" \
  -configuration Debug \
  build 2>&1 | grep -E "(Build|error|warning|SUCCEEDED|FAILED)" || echo "Building..."

echo "📱 Launching on $SIMULATOR..."

# 找出 App 路徑
APP_PATH=$(find ~/Library/Developer/Xcode/DerivedData/TidalHabits-*/Build/Products/Debug-iphonesimulator -name "TidalHabits.app" 2>/dev/null | head -1)

if [ -z "$APP_PATH" ]; then
    echo "❌ Build failed: App not found"
    exit 1
fi

# 啟動模擬器
xcrun simctl boot "$SIMULATOR" 2>/dev/null || true
open -a Simulator

# 等待模擬器啟動
sleep 2

# 安裝並啟動
xcrun simctl install booted "$APP_PATH"
xcrun simctl launch booted "$BUNDLE_ID"

echo "✅ App launched successfully!"
echo "📱 Simulator: $SIMULATOR"
echo "📦 Bundle ID: $BUNDLE_ID"
