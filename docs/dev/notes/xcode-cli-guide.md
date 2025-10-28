# Xcode Command Line 操作指南

本指南說明如何使用 command line 進行專案的測試、建置和執行。

## 目錄
- [前置準備](#前置準備)
- [專案配置](#專案配置)
- [測試 (Test)](#測試-test)
- [建置 (Build)](#建置-build)
- [執行 (Run)](#執行-run)
- [清理 (Clean)](#清理-clean)
- [常用組合指令](#常用組合指令)
- [疑難排解](#疑難排解)

---

## 前置準備

### 1. 確認 Xcode Command Line Tools 已安裝
```bash
xcode-select --install
```

### 2. 確認 Xcode 版本
```bash
xcodebuild -version
# 應該顯示: Xcode 15.4 或以上
```

### 3. 確認可用的模擬器
```bash
# 列出所有可用的 iOS 模擬器
xcrun simctl list devices available | grep iPhone

# 常用模擬器名稱:
# - iPhone 15
# - iPhone 15 Pro
# - iPhone 15 Pro Max
# - iPhone 14
```

### 4. 重新生成 Xcode 專案（如果 project.yml 有更新）
```bash
# 安裝 xcodegen (只需執行一次)
brew install xcodegen

# 生成 Xcode 專案
xcodegen generate

# 修正專案格式版本（針對 Xcode 15.4）
sed -i '' 's/objectVersion = 77;/objectVersion = 56;/' TidalHabits.xcodeproj/project.pbxproj
```

---

## 專案配置

### 查看專案資訊
```bash
# 列出專案的所有 schemes 和 targets
xcodebuild -list -project TidalHabits.xcodeproj

# 輸出範例:
# Targets:
#     TidalHabits
#     TidalHabitsTests
#     TidalHabitsUITests
# Schemes:
#     TidalHabits
```

### 查看可用的 SDK
```bash
xcodebuild -showsdks

# 常用 SDK:
# iOS SDK: -sdk iphoneos
# iOS Simulator SDK: -sdk iphonesimulator
```

---

## 測試 (Test)

### 1. 執行所有測試（單元測試 + UI 測試）
```bash
xcodebuild \
  -project TidalHabits.xcodeproj \
  -scheme TidalHabits \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro' \
  test
```

### 2. 只執行單元測試
```bash
xcodebuild \
  -project TidalHabits.xcodeproj \
  -scheme TidalHabits \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro' \
  -only-testing:TidalHabitsTests \
  test
```

### 3. 只執行特定測試類別
```bash
# 執行 HabitTests 類別的所有測試
xcodebuild \
  -project TidalHabits.xcodeproj \
  -scheme TidalHabits \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro' \
  -only-testing:TidalHabitsTests/HabitTests \
  test
```

### 4. 只執行特定測試方法
```bash
# 執行單一測試方法
xcodebuild \
  -project TidalHabits.xcodeproj \
  -scheme TidalHabits \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro' \
  -only-testing:TidalHabitsTests/HabitTests/testHabit_ShouldInitializeWithValidValues \
  test
```

### 5. 測試並產生程式碼覆蓋率報告
```bash
xcodebuild \
  -project TidalHabits.xcodeproj \
  -scheme TidalHabits \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro' \
  -enableCodeCoverage YES \
  test

# 查看覆蓋率報告位置
# ~/Library/Developer/Xcode/DerivedData/TidalHabits-*/Logs/Test/*.xcresult
```

### 6. 測試並輸出 JUnit XML 格式（適合 CI/CD）
```bash
xcodebuild \
  -project TidalHabits.xcodeproj \
  -scheme TidalHabits \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro' \
  -resultBundlePath TestResults.xcresult \
  test

# 轉換成 JUnit XML (需要安裝 xcpretty)
# brew install xcpretty
xcodebuild test ... | xcpretty --report junit
```

### 7. 簡化輸出（只顯示重要資訊）
```bash
xcodebuild \
  -project TidalHabits.xcodeproj \
  -scheme TidalHabits \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro' \
  test 2>&1 | grep -E "(Test Case|Test Suite|PASSED|FAILED|error)"
```

---

## 建置 (Build)

### 1. 建置專案（Debug 模式）
```bash
xcodebuild \
  -project TidalHabits.xcodeproj \
  -scheme TidalHabits \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro' \
  -configuration Debug \
  build
```

### 2. 建置專案（Release 模式）
```bash
xcodebuild \
  -project TidalHabits.xcodeproj \
  -scheme TidalHabits \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro' \
  -configuration Release \
  build
```

### 3. 建置實機版本（需要開發者憑證）
```bash
xcodebuild \
  -project TidalHabits.xcodeproj \
  -scheme TidalHabits \
  -destination 'generic/platform=iOS' \
  -configuration Release \
  build
```

### 4. 建置並輸出到指定目錄
```bash
xcodebuild \
  -project TidalHabits.xcodeproj \
  -scheme TidalHabits \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro' \
  -configuration Debug \
  -derivedDataPath ./build \
  build
```

### 5. 只編譯不連結（檢查語法錯誤）
```bash
xcodebuild \
  -project TidalHabits.xcodeproj \
  -scheme TidalHabits \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro' \
  build-for-testing
```

---

## 執行 (Run)

### 1. 啟動模擬器
```bash
# 列出可用的模擬器 UDID
xcrun simctl list devices available | grep "iPhone 15 Pro"

# 啟動指定模擬器
xcrun simctl boot "iPhone 15 Pro"

# 或使用 UDID 啟動
xcrun simctl boot <DEVICE_UDID>

# 開啟 Simulator.app
open -a Simulator
```

### 2. 建置並安裝到模擬器
```bash
# 先建置專案
xcodebuild \
  -project TidalHabits.xcodeproj \
  -scheme TidalHabits \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro' \
  -configuration Debug \
  build

# 找出建置的 .app 路徑
APP_PATH=$(find ~/Library/Developer/Xcode/DerivedData/TidalHabits-*/Build/Products/Debug-iphonesimulator -name "TidalHabits.app" | head -1)

# 安裝到模擬器
xcrun simctl install booted "$APP_PATH"
```

### 3. 啟動 App
```bash
# 取得 Bundle Identifier
BUNDLE_ID="com.intervalrain.TidalHabits"

# 啟動 App
xcrun simctl launch booted "$BUNDLE_ID"
```

### 4. 一鍵建置並執行（推薦）
```bash
# 建置專案
xcodebuild \
  -project TidalHabits.xcodeproj \
  -scheme TidalHabits \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro' \
  -configuration Debug \
  build

# 找出 App 路徑並安裝、啟動
APP_PATH=$(find ~/Library/Developer/Xcode/DerivedData/TidalHabits-*/Build/Products/Debug-iphonesimulator -name "TidalHabits.app" | head -1) && \
xcrun simctl boot "iPhone 15 Pro" 2>/dev/null && \
open -a Simulator && \
xcrun simctl install booted "$APP_PATH" && \
xcrun simctl launch booted com.intervalrain.TidalHabits
```

### 5. 關閉 App
```bash
xcrun simctl terminate booted com.intervalrain.TidalHabits
```

### 6. 解除安裝 App
```bash
xcrun simctl uninstall booted com.intervalrain.TidalHabits
```

### 7. 查看 App 日誌
```bash
# 即時查看 App 日誌
xcrun simctl spawn booted log stream --predicate 'processImagePath contains "TidalHabits"'

# 或使用 Console.app 查看
```

---

## 清理 (Clean)

### 1. 清理建置快取
```bash
xcodebuild \
  -project TidalHabits.xcodeproj \
  -scheme TidalHabits \
  clean
```

### 2. 刪除 DerivedData
```bash
# 刪除所有 DerivedData
rm -rf ~/Library/Developer/Xcode/DerivedData

# 只刪除此專案的 DerivedData
rm -rf ~/Library/Developer/Xcode/DerivedData/TidalHabits-*
```

### 3. 重置模擬器
```bash
# 關閉所有模擬器
xcrun simctl shutdown all

# 清除特定模擬器
xcrun simctl erase "iPhone 15 Pro"

# 清除所有模擬器
xcrun simctl erase all
```

### 4. 完整清理（從頭開始）
```bash
# 刪除生成的 Xcode 專案
rm -rf TidalHabits.xcodeproj

# 刪除 DerivedData
rm -rf ~/Library/Developer/Xcode/DerivedData/TidalHabits-*

# 重新生成專案
xcodegen generate
sed -i '' 's/objectVersion = 77;/objectVersion = 56;/' TidalHabits.xcodeproj/project.pbxproj
```

---

## 常用組合指令

### 快速測試腳本（推薦）
將以下內容儲存為 `scripts/test.sh`:

```bash
#!/bin/bash
set -e

echo "🧪 Running TidalHabits Tests..."

xcodebuild \
  -project TidalHabits.xcodeproj \
  -scheme TidalHabits \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro' \
  -only-testing:TidalHabitsTests \
  test 2>&1 | xcpretty --color || \
xcodebuild \
  -project TidalHabits.xcodeproj \
  -scheme TidalHabits \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro' \
  -only-testing:TidalHabitsTests \
  test 2>&1 | grep -E "(Test Case|Test Suite|PASSED|FAILED|error)"

echo "✅ Tests completed!"
```

使用方式:
```bash
chmod +x scripts/test.sh
./scripts/test.sh
```

### 快速執行腳本
將以下內容儲存為 `scripts/run.sh`:

```bash
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
  build | xcpretty --color || echo "Build output shown above"

echo "📱 Launching on $SIMULATOR..."

# 找出 App 路徑
APP_PATH=$(find ~/Library/Developer/Xcode/DerivedData/TidalHabits-*/Build/Products/Debug-iphonesimulator -name "TidalHabits.app" | head -1)

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
```

使用方式:
```bash
chmod +x scripts/run.sh
./scripts/run.sh
```

### CI/CD 用完整測試腳本
將以下內容儲存為 `scripts/ci-test.sh`:

```bash
#!/bin/bash
set -e

echo "🔧 Regenerating Xcode project..."
xcodegen generate
sed -i '' 's/objectVersion = 77;/objectVersion = 56;/' TidalHabits.xcodeproj/project.pbxproj

echo "🧪 Running Unit Tests..."
xcodebuild \
  -project TidalHabits.xcodeproj \
  -scheme TidalHabits \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro' \
  -only-testing:TidalHabitsTests \
  -enableCodeCoverage YES \
  test | xcpretty --report junit --output build/reports/junit.xml

echo "✅ All tests passed!"
```

---

## 疑難排解

### 問題 1: "Unable to read project" 或 "future Xcode project file format"
```bash
# 解決方式: 降級專案格式版本
sed -i '' 's/objectVersion = 77;/objectVersion = 56;/' TidalHabits.xcodeproj/project.pbxproj
```

### 問題 2: "Cannot code sign" 錯誤
```bash
# 原因: 測試 target 缺少 Info.plist
# 解決方式: 已在 project.yml 中設定 GENERATE_INFOPLIST_FILE: YES

# 如果仍有問題，重新生成專案:
rm -rf TidalHabits.xcodeproj
xcodegen generate
sed -i '' 's/objectVersion = 77;/objectVersion = 56;/' TidalHabits.xcodeproj/project.pbxproj
```

### 問題 3: 模擬器無法啟動
```bash
# 關閉所有模擬器並重試
xcrun simctl shutdown all
killall Simulator 2>/dev/null || true
xcrun simctl boot "iPhone 15 Pro"
open -a Simulator
```

### 問題 4: DerivedData 佔用空間過大
```bash
# 定期清理 DerivedData
rm -rf ~/Library/Developer/Xcode/DerivedData
```

### 問題 5: SwiftLint 警告過多
```bash
# 暫時停用 SwiftLint（不建議）
# 編輯 project.yml，將 preBuildScripts 中的 SwiftLint 腳本移除

# 或者只在特定檔案忽略 SwiftLint
# 在 Swift 檔案中加入: // swiftlint:disable rule_name
```

### 問題 6: 測試執行過慢
```bash
# 使用較快的模擬器（如 iPhone SE）
xcodebuild ... -destination 'platform=iOS Simulator,name=iPhone SE (3rd generation)' test

# 或只執行特定測試
xcodebuild ... -only-testing:TidalHabitsTests/HabitTests test
```

---

## 參考資源

- [xcodebuild 官方文件](https://developer.apple.com/library/archive/technotes/tn2339/_index.html)
- [simctl 指令參考](https://nshipster.com/simctl/)
- [xcodegen 文件](https://github.com/yonaskolb/XcodeGen)
- [xcpretty GitHub](https://github.com/xcpretty/xcpretty)

---

**最後更新:** 2025-10-28
**適用版本:** Xcode 15.4, iOS 16.0+
