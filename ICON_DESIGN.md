# App Icon Design

## Design Concept
The app icon features a **spinning wheel** design that represents the core functionality of the "What2Eat" app - helping users decide what to eat by spinning a wheel.

## Icon Features

### Main Elements
1. **Spinning Wheel**: Smooth orange gradient circle (#EC9213 to #FFB84D)
   - Radius: 380px (on 1024x1024 canvas)
   - Multi-layered gradient (20 layers) for smooth color transition
   - Represents the lucky wheel/decision maker

2. **8 Divider Lines**: Bold white lines
   - Width: 8px (thicker for better visibility)
   - Creates 8 equal sections on the wheel
   - Separates different food options visually
   - Angles: 0°, 45°, 90°, 135°, 180°, 225°, 270°, 315°

3. **Food Item Circles**: 8 vibrant colored circles with white borders
   - Radius: 40px (larger for better visibility)
   - White background (44px) for contrast
   - Each represents a different food category:
     * 🍕 Pizza (Red #FF6B6B)
     * 🍔 Burger (Teal #4ECDC4)
     * 🍜 Noodles (Yellow #FFE66D)
     * 🍱 Bento (Green #A8E6CF)
     * 🍰 Cake (Pink #FF8B94)
     * ☕ Coffee (Purple #B4A7D6)
     * 🍲 Stew (Peach #FFDAC1)
     * 🥗 Salad (Light Green #9EE493)
   - Positioned at 280px from center

4. **Center Hub**:
   - Orange gradient circle with smooth transition
   - Radius: 120px
   - White border: 10px (thicker for prominence)
   - Contains a white "?" symbol with drop shadow

5. **Outer Decorative Circle**:
   - Radius: 440px
   - Light cream color (#FFF5E6)
   - Width: 8px
   - Adds a polished, finished look

6. **Background**: Warm cream color (#FFFDF5)
   - Matches the app's overall theme
   - Provides soft, appetizing feel

## Platform-Specific Icons

### Android
- **Standard Icons**: Generated for all densities (mdpi, hdpi, xhdpi, xxhdpi, xxxhdpi)
- **Adaptive Icon**:
  - Background: Solid cream color (#FFFDF5)
  - Foreground: Transparent PNG with the wheel design
  - Follows Android 8.0+ adaptive icon guidelines

### iOS
- **Standard Icon**: 1024x1024 PNG
- **Rounded corners**: Applied automatically by iOS
- **Alpha channel removed**: For App Store compliance

## Files Generated

```
assets/icon/
├── app_icon.png (1024x1024) - Main icon
├── app_icon_foreground.png (1024x1024) - Android adaptive foreground
└── icon_design.svg - Original SVG design

android/app/src/main/res/
├── mipmap-mdpi/ic_launcher.png (48x48)
├── mipmap-hdpi/ic_launcher.png (72x72)
├── mipmap-xhdpi/ic_launcher.png (96x96)
├── mipmap-xxhdpi/ic_launcher.png (144x144)
├── mipmap-xxxhdpi/ic_launcher.png (192x192)
└── mipmap-anydpi-v26/
    ├── ic_launcher.xml (Adaptive icon descriptor)
    └── ic_launcher_round.xml (Round adaptive icon descriptor)

ios/Runner/Assets.xcassets/AppIcon.appiconset/
└── Icon-App-1024x1024@1x.png
```

## Design Rationale

1. **Circular Theme**: The spinning wheel is inherently circular, making it perfect for app icons which are typically displayed in circular or rounded square formats.

2. **Clear Visual Hierarchy**: 
   - Large outer wheel (most prominent)
   - Food items distributed evenly (secondary)
   - Center hub with "?" (focal point)

3. **Color Scheme**:
   - Primary orange (#EC9213) matches the app's brand color
   - Warm cream background creates appetizing feel
   - Colorful food circles add vibrancy without overwhelming

4. **Scalability**: Design works well at all sizes due to:
   - Clear, bold shapes
   - High contrast elements
   - No small details that would be lost at small sizes

## Usage

To regenerate icons after changes:
```bash
flutter pub get
flutter pub run flutter_launcher_icons
```

## Tools Used
- Python PIL/Pillow for PNG generation
- flutter_launcher_icons for platform-specific icon generation
