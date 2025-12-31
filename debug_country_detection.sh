#!/bin/bash

echo "==================================="
echo "Debug Country Detection"
echo "==================================="

# Uninstall old app
echo "1. Uninstalling old app..."
adb uninstall com.toinx.what2eat 2>/dev/null
echo "   ✓ Done"

# Install debug APK
echo "2. Installing debug APK..."
adb install build/app/outputs/flutter-apk/app-debug.apk
echo "   ✓ Done"

# Clear logcat
echo "3. Clearing logcat..."
adb logcat -c
echo "   ✓ Done"

# Launch app
echo "4. Launching app..."
adb shell am start -n com.toinx.what2eat/.MainActivity
sleep 3

# Show country detection logs
echo "5. Country Detection Logs:"
echo "-----------------------------------"
adb logcat -d | grep -A 10 "Country Detection Debug"
echo "-----------------------------------"

echo ""
echo "App is now running. To see live logs, run:"
echo "  adb logcat | grep 'Country Detection'"
