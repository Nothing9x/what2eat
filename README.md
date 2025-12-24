# What2Eat - Lucky Wheel Food Selector 🎡

A beautiful Flutter application that helps you decide what to eat using a lucky wheel spinner!

## Features ✨

- 🎰 **Lucky Wheel**: Spin the wheel to randomly select a food item
- ⚙️ **Settings**: Customize your app preferences
- 🎨 **Beautiful UI**: Modern design with light/dark theme support
- 📱 **Responsive**: Works great on all screen sizes
- 🌟 **Smooth Animations**: Engaging spin animations and transitions

## Screenshots

The app includes three main screens:
1. **Home Screen**: Features the lucky wheel with 6 food options
2. **Settings Screen**: Manage app preferences and food list
3. **Result Screen**: Shows the selected food with ordering options

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd What2Eat
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Food Items

The app includes 6 delicious Vietnamese food options:
- 🍚 Cơm Tấm (Broken Rice)
- 🥖 Bánh Mì (Vietnamese Baguette)
- 🍜 Bún Bò (Spicy Beef Noodle Soup)
- 🍔 Burger
- 🍲 Phở Bò (Beef Noodle Soup)
- 🍕 Pizza

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── food_item.dart       # Food data model
├── screens/
│   ├── home_screen.dart     # Main screen with lucky wheel
│   ├── settings_screen.dart # Settings and preferences
│   └── result_screen.dart   # Result display screen
└── widgets/
    └── lucky_wheel.dart     # Lucky wheel widget
```

## Dependencies

- `google_fonts`: For beautiful typography
- `flutter`: Flutter SDK

## How to Use

1. **Spin the Wheel**: Tap the "QUAY NGAY" button to spin the lucky wheel
2. **View Result**: After the wheel stops, see your randomly selected food
3. **Order Food**: Choose to order from ShopeeFood or GrabFood
4. **Customize**: Go to Settings to adjust your preferences

## Contributing

Feel free to submit issues and enhancement requests!

## License

This project is licensed under the MIT License.

## Made with ❤️ in Vietnam
