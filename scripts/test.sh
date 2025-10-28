#!/bin/bash
set -e

echo "🧪 Running TidalHabits Tests..."

xcodebuild \
  -project TidalHabits.xcodeproj \
  -scheme TidalHabits \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro' \
  -only-testing:TidalHabitsTests \
  test 2>&1 | grep -E "(Test Case|Test Suite|PASSED|FAILED|error|warning)" || \
xcodebuild \
  -project TidalHabits.xcodeproj \
  -scheme TidalHabits \
  -destination 'platform=iOS Simulator,name=iPhone 15 Pro' \
  -only-testing:TidalHabitsTests \
  test

echo "✅ Tests completed!"
