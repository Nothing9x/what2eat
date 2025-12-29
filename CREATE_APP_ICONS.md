# App Icon Generation Guide

## Package Name Updated ✅

The app package name has been changed to **`com.toinx.what2eat`** for both Android and iOS.

## Creating App Icons from the Spin Wheel

To create app icons from your spin wheel design, follow these steps:

### Option 1: Automated Icon Generation (Recommended)

Use **flutter_launcher_icons** package to automatically generate all icon sizes:

1. **Add the package** (already in pubspec.yaml):
```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.13.1
```

2. **Add configuration to `pubspec.yaml`**:
```yaml
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icon/app_icon.png"
  adaptive_icon_background: "#FFFDF5"  # Warm cream color
  adaptive_icon_foreground: "assets/icon/app_icon_foreground.png"
```

3. **Prepare your icon image**:
   - Create a 1024x1024px PNG image of just the spin wheel circle
   - Save it as `assets/icon/app_icon.png`
   - For Android adaptive icon, create `app_icon_foreground.png` with the wheel on transparent background

4. **Run the generator**:
```bash
flutter pub get
flutter pub run flutter_launcher_icons
```

### Option 2: Manual Icon Creation

#### Required Icon Sizes:

**Android:**
- mipmap-mdpi: 48x48
- mipmap-hdpi: 72x72
- mipmap-xhdpi: 96x96
- mipmap-xxhdpi: 144x144
- mipmap-xxxhdpi: 192x192

**iOS:**
- 20x20 @1x, @2x, @3x
- 29x29 @1x, @2x, @3x
- 40x40 @1x, @2x, @3x
- 60x60 @2x, @3x
- 76x76 @1x, @2x
- 83.5x83.5 @2x
- 1024x1024 @1x (App Store)

#### Steps:

1. **Extract the wheel design** from your HTML:
   - Take a screenshot of just the spin wheel circle
   - Or recreate it as a vector graphic in Figma/Sketch/Illustrator
   - The wheel should have:
     - Orange border (#EC9213)
     - Alternating light/dark orange sections
     - White center circle
     - Clean, circular shape

2. **Create master icon** (1024x1024px):
   - Place the wheel in the center
   - Add padding around edges (80px minimum)
   - Use warm cream background (#FFFDF5) or make transparent
   - Export as PNG with high quality

3. **Resize for all platforms**:
   Use an online tool or ImageMagick:
   ```bash
   # Install ImageMagick
   sudo apt-get install imagemagick

   # Generate Android icons
   convert app_icon.png -resize 48x48 android/app/src/main/res/mipmap-mdpi/ic_launcher.png
   convert app_icon.png -resize 72x72 android/app/src/main/res/mipmap-hdpi/ic_launcher.png
   convert app_icon.png -resize 96x96 android/app/src/main/res/mipmap-xhdpi/ic_launcher.png
   convert app_icon.png -resize 144x144 android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png
   convert app_icon.png -resize 192x192 android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
   ```

4. **For iOS**, open Xcode and:
   - Navigate to `ios/Runner/Assets.xcassets/AppIcon.appiconset`
   - Drag and drop your icon images into the correct slots
   - Or use flutter_launcher_icons (recommended)

### Option 3: Use Online Icon Generator

1. Visit **appicon.co** or **icon.kitchen**
2. Upload your 1024x1024 wheel image
3. Download the generated icon pack
4. Extract and copy to:
   - Android: `android/app/src/main/res/mipmap-*/`
   - iOS: `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

## Design Tips for the Icon

- **Simplify the wheel**: For small sizes, reduce details
- **High contrast**: Make sure the orange wheel stands out
- **Center the design**: Leave padding on all sides
- **Test at small sizes**: View at 48x48 to ensure it's recognizable
- **Keep it circular**: The round wheel shape works great for app icons

## Verification

After creating icons, verify they work:

```bash
# Clean build
flutter clean

# Run on device
flutter run
```

Check that the new icon appears on:
- Android home screen
- iOS home screen
- App drawer/switcher
- Settings/About app

## Current Status

✅ Package name changed to: `com.toinx.what2eat`
⏳ App icons need to be created from spin wheel design
⏳ Icons need to be placed in respective directories

## Next Steps

1. Create or screenshot the 1024x1024 wheel icon
2. Use flutter_launcher_icons (easiest) or manual method
3. Build and verify on both platforms
