import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_th.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ja'),
    Locale('ko'),
    Locale('th'),
    Locale('vi'),
    Locale('zh')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'What to Eat?'**
  String get appTitle;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'What should we eat today? 🤔'**
  String get homeTitle;

  /// No description provided for @spinButton.
  ///
  /// In en, this message translates to:
  /// **'SPIN NOW'**
  String get spinButton;

  /// No description provided for @spinning.
  ///
  /// In en, this message translates to:
  /// **'SPINNING...'**
  String get spinning;

  /// No description provided for @spinHint.
  ///
  /// In en, this message translates to:
  /// **'Tap to choose randomly'**
  String get spinHint;

  /// No description provided for @noCategoryTitle.
  ///
  /// In en, this message translates to:
  /// **'No food lists yet'**
  String get noCategoryTitle;

  /// No description provided for @noCategoryButton.
  ///
  /// In en, this message translates to:
  /// **'Create now'**
  String get noCategoryButton;

  /// No description provided for @noItemsInCategory.
  ///
  /// In en, this message translates to:
  /// **'This list has no food items. Please add some!'**
  String get noItemsInCategory;

  /// No description provided for @selectCategoryFirst.
  ///
  /// In en, this message translates to:
  /// **'Please select a list first'**
  String get selectCategoryFirst;

  /// No description provided for @categoryBreakfast.
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get categoryBreakfast;

  /// No description provided for @categoryLunch.
  ///
  /// In en, this message translates to:
  /// **'Lunch'**
  String get categoryLunch;

  /// No description provided for @categoryDinner.
  ///
  /// In en, this message translates to:
  /// **'Dinner'**
  String get categoryDinner;

  /// No description provided for @categoryParty.
  ///
  /// In en, this message translates to:
  /// **'Party'**
  String get categoryParty;

  /// No description provided for @categoryCafe.
  ///
  /// In en, this message translates to:
  /// **'Cafe'**
  String get categoryCafe;

  /// No description provided for @foodBanhMi.
  ///
  /// In en, this message translates to:
  /// **'Banh Mi'**
  String get foodBanhMi;

  /// No description provided for @foodBanhMiDesc.
  ///
  /// In en, this message translates to:
  /// **'Vietnamese Baguette'**
  String get foodBanhMiDesc;

  /// No description provided for @foodPho.
  ///
  /// In en, this message translates to:
  /// **'Pho'**
  String get foodPho;

  /// No description provided for @foodPhoDesc.
  ///
  /// In en, this message translates to:
  /// **'Beef Pho'**
  String get foodPhoDesc;

  /// No description provided for @foodXoi.
  ///
  /// In en, this message translates to:
  /// **'Sticky Rice'**
  String get foodXoi;

  /// No description provided for @foodXoiDesc.
  ///
  /// In en, this message translates to:
  /// **'Savory Sticky Rice'**
  String get foodXoiDesc;

  /// No description provided for @foodChao.
  ///
  /// In en, this message translates to:
  /// **'Porridge'**
  String get foodChao;

  /// No description provided for @foodChaoDesc.
  ///
  /// In en, this message translates to:
  /// **'Chicken Porridge'**
  String get foodChaoDesc;

  /// No description provided for @foodBunBo.
  ///
  /// In en, this message translates to:
  /// **'Bun Bo Hue'**
  String get foodBunBo;

  /// No description provided for @foodBunBoDesc.
  ///
  /// In en, this message translates to:
  /// **'Spicy Beef Noodle Soup'**
  String get foodBunBoDesc;

  /// No description provided for @foodHuTieu.
  ///
  /// In en, this message translates to:
  /// **'Hu Tieu'**
  String get foodHuTieu;

  /// No description provided for @foodHuTieuDesc.
  ///
  /// In en, this message translates to:
  /// **'Pork Noodle Soup'**
  String get foodHuTieuDesc;

  /// No description provided for @foodComTam.
  ///
  /// In en, this message translates to:
  /// **'Broken Rice'**
  String get foodComTam;

  /// No description provided for @foodComTamDesc.
  ///
  /// In en, this message translates to:
  /// **'Broken Rice with Grilled Pork'**
  String get foodComTamDesc;

  /// No description provided for @foodMiQuang.
  ///
  /// In en, this message translates to:
  /// **'Mi Quang'**
  String get foodMiQuang;

  /// No description provided for @foodMiQuangDesc.
  ///
  /// In en, this message translates to:
  /// **'Quang Noodles'**
  String get foodMiQuangDesc;

  /// No description provided for @foodComRang.
  ///
  /// In en, this message translates to:
  /// **'Fried Rice'**
  String get foodComRang;

  /// No description provided for @foodComRangDesc.
  ///
  /// In en, this message translates to:
  /// **'Yang Chow Fried Rice'**
  String get foodComRangDesc;

  /// No description provided for @foodBunCha.
  ///
  /// In en, this message translates to:
  /// **'Bun Cha'**
  String get foodBunCha;

  /// No description provided for @foodBunChaDesc.
  ///
  /// In en, this message translates to:
  /// **'Grilled Pork with Noodles'**
  String get foodBunChaDesc;

  /// No description provided for @foodLau.
  ///
  /// In en, this message translates to:
  /// **'Hot Pot'**
  String get foodLau;

  /// No description provided for @foodLauDesc.
  ///
  /// In en, this message translates to:
  /// **'Thai Hot Pot'**
  String get foodLauDesc;

  /// No description provided for @foodNuong.
  ///
  /// In en, this message translates to:
  /// **'Grilled'**
  String get foodNuong;

  /// No description provided for @foodNuongDesc.
  ///
  /// In en, this message translates to:
  /// **'BBQ Grilled Meat'**
  String get foodNuongDesc;

  /// No description provided for @foodGaRan.
  ///
  /// In en, this message translates to:
  /// **'Fried Chicken'**
  String get foodGaRan;

  /// No description provided for @foodGaRanDesc.
  ///
  /// In en, this message translates to:
  /// **'Crispy Fried Chicken'**
  String get foodGaRanDesc;

  /// No description provided for @foodPizza.
  ///
  /// In en, this message translates to:
  /// **'Pizza'**
  String get foodPizza;

  /// No description provided for @foodPizzaDesc.
  ///
  /// In en, this message translates to:
  /// **'Seafood Pizza'**
  String get foodPizzaDesc;

  /// No description provided for @foodBurger.
  ///
  /// In en, this message translates to:
  /// **'Burger'**
  String get foodBurger;

  /// No description provided for @foodBurgerDesc.
  ///
  /// In en, this message translates to:
  /// **'Cheese Burger'**
  String get foodBurgerDesc;

  /// No description provided for @foodMiY.
  ///
  /// In en, this message translates to:
  /// **'Pasta'**
  String get foodMiY;

  /// No description provided for @foodMiYDesc.
  ///
  /// In en, this message translates to:
  /// **'Spaghetti Bolognese'**
  String get foodMiYDesc;

  /// No description provided for @foodPizzaL.
  ///
  /// In en, this message translates to:
  /// **'Pizza'**
  String get foodPizzaL;

  /// No description provided for @foodPizzaLDesc.
  ///
  /// In en, this message translates to:
  /// **'Large Pizza'**
  String get foodPizzaLDesc;

  /// No description provided for @foodBurgerSet.
  ///
  /// In en, this message translates to:
  /// **'Burger'**
  String get foodBurgerSet;

  /// No description provided for @foodBurgerSetDesc.
  ///
  /// In en, this message translates to:
  /// **'Burger Set'**
  String get foodBurgerSetDesc;

  /// No description provided for @foodGaRanL.
  ///
  /// In en, this message translates to:
  /// **'Fried Chicken'**
  String get foodGaRanL;

  /// No description provided for @foodGaRanLDesc.
  ///
  /// In en, this message translates to:
  /// **'Large Fried Chicken Bucket'**
  String get foodGaRanLDesc;

  /// No description provided for @foodNemRan.
  ///
  /// In en, this message translates to:
  /// **'Spring Rolls'**
  String get foodNemRan;

  /// No description provided for @foodNemRanDesc.
  ///
  /// In en, this message translates to:
  /// **'Crispy Spring Rolls'**
  String get foodNemRanDesc;

  /// No description provided for @foodSushi.
  ///
  /// In en, this message translates to:
  /// **'Sushi'**
  String get foodSushi;

  /// No description provided for @foodSushiDesc.
  ///
  /// In en, this message translates to:
  /// **'Mixed Sushi'**
  String get foodSushiDesc;

  /// No description provided for @foodSalad.
  ///
  /// In en, this message translates to:
  /// **'Salad'**
  String get foodSalad;

  /// No description provided for @foodSaladDesc.
  ///
  /// In en, this message translates to:
  /// **'Mixed Salad'**
  String get foodSaladDesc;

  /// No description provided for @foodCafe.
  ///
  /// In en, this message translates to:
  /// **'Coffee'**
  String get foodCafe;

  /// No description provided for @foodCafeDesc.
  ///
  /// In en, this message translates to:
  /// **'Iced Black Coffee'**
  String get foodCafeDesc;

  /// No description provided for @foodTraSua.
  ///
  /// In en, this message translates to:
  /// **'Milk Tea'**
  String get foodTraSua;

  /// No description provided for @foodTraSuaDesc.
  ///
  /// In en, this message translates to:
  /// **'Bubble Milk Tea'**
  String get foodTraSuaDesc;

  /// No description provided for @foodBanhNgot.
  ///
  /// In en, this message translates to:
  /// **'Cupcake'**
  String get foodBanhNgot;

  /// No description provided for @foodBanhNgotDesc.
  ///
  /// In en, this message translates to:
  /// **'Sweet Cupcake'**
  String get foodBanhNgotDesc;

  /// No description provided for @foodSmoothie.
  ///
  /// In en, this message translates to:
  /// **'Smoothie'**
  String get foodSmoothie;

  /// No description provided for @foodSmoothieDesc.
  ///
  /// In en, this message translates to:
  /// **'Strawberry Smoothie'**
  String get foodSmoothieDesc;

  /// No description provided for @foodCroissant.
  ///
  /// In en, this message translates to:
  /// **'Croissant'**
  String get foodCroissant;

  /// No description provided for @foodCroissantDesc.
  ///
  /// In en, this message translates to:
  /// **'Butter Croissant'**
  String get foodCroissantDesc;

  /// No description provided for @foodTraTraiCay.
  ///
  /// In en, this message translates to:
  /// **'Fruit Tea'**
  String get foodTraTraiCay;

  /// No description provided for @foodTraTraiCayDesc.
  ///
  /// In en, this message translates to:
  /// **'Peach Orange Tea'**
  String get foodTraTraiCayDesc;

  /// No description provided for @resultTitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s choice is'**
  String get resultTitle;

  /// No description provided for @resultSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s enjoy this delicious meal!'**
  String get resultSubtitle;

  /// No description provided for @orderOn.
  ///
  /// In en, this message translates to:
  /// **'Order on {platform}'**
  String orderOn(String platform);

  /// No description provided for @spinAgain.
  ///
  /// In en, this message translates to:
  /// **'Spin Again'**
  String get spinAgain;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @notificationSettings.
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get notificationSettings;

  /// No description provided for @enableNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable Notifications'**
  String get enableNotifications;

  /// No description provided for @notifyOnceOnly.
  ///
  /// In en, this message translates to:
  /// **'Notify only once'**
  String get notifyOnceOnly;

  /// No description provided for @selectDays.
  ///
  /// In en, this message translates to:
  /// **'Select Days'**
  String get selectDays;

  /// No description provided for @selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get selectTime;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @manageLists.
  ///
  /// In en, this message translates to:
  /// **'Manage Lists'**
  String get manageLists;

  /// No description provided for @addNewList.
  ///
  /// In en, this message translates to:
  /// **'Add New List'**
  String get addNewList;

  /// No description provided for @listName.
  ///
  /// In en, this message translates to:
  /// **'List Name'**
  String get listName;

  /// No description provided for @selectIcon.
  ///
  /// In en, this message translates to:
  /// **'Select Icon'**
  String get selectIcon;

  /// No description provided for @selectColor.
  ///
  /// In en, this message translates to:
  /// **'Select Color'**
  String get selectColor;

  /// No description provided for @addItem.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get addItem;

  /// No description provided for @itemName.
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get itemName;

  /// No description provided for @itemIcon.
  ///
  /// In en, this message translates to:
  /// **'Item Icon'**
  String get itemIcon;

  /// No description provided for @itemDescription.
  ///
  /// In en, this message translates to:
  /// **'Item Description (Optional)'**
  String get itemDescription;

  /// No description provided for @itemImageUrl.
  ///
  /// In en, this message translates to:
  /// **'Image URL (Optional)'**
  String get itemImageUrl;

  /// No description provided for @editList.
  ///
  /// In en, this message translates to:
  /// **'Edit List'**
  String get editList;

  /// No description provided for @deleteList.
  ///
  /// In en, this message translates to:
  /// **'Delete List'**
  String get deleteList;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this list?'**
  String get confirmDelete;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @noItems.
  ///
  /// In en, this message translates to:
  /// **'No items yet'**
  String get noItems;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'de',
        'en',
        'es',
        'fr',
        'ja',
        'ko',
        'th',
        'vi',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'th':
      return AppLocalizationsTh();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
