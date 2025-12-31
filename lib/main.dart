import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'l10n/app_localizations.dart';
import 'providers/category_provider.dart';
import 'services/storage_service.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  final prefs = await SharedPreferences.getInstance();
  final storage = StorageService(prefs);

  runApp(What2EatApp(storage: storage));
}

class What2EatApp extends StatelessWidget {
  final StorageService storage;

  const What2EatApp({super.key, required this.storage});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(storage)..loadCategories(),
        ),
      ],
      child: MaterialApp(
        onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('vi'), // Vietnamese
          Locale('zh'), // Chinese
          Locale('ja'), // Japanese
          Locale('ko'), // Korean
          Locale('es'), // Spanish
          Locale('fr'), // French
          Locale('de'), // German
          Locale('th'), // Thai
          Locale('it'), // Italian
          Locale('pt'), // Portuguese
          Locale('ru'), // Russian
          Locale('hi'), // Hindi
          Locale('id'), // Indonesian
          Locale('ar'), // Arabic
          Locale('tr'), // Turkish
          Locale('pl'), // Polish
          Locale('nl'), // Dutch
          Locale('sv'), // Swedish
          Locale('uk'), // Ukrainian
          Locale('el'), // Greek
          Locale('hu'), // Hungarian
          Locale('cs'), // Czech
          Locale('ro'), // Romanian
        ],
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFEC9213),
            brightness: Brightness.light,
          ),
          textTheme: GoogleFonts.plusJakartaSansTextTheme(),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFEC9213),
            brightness: Brightness.dark,
          ),
          textTheme: GoogleFonts.plusJakartaSansTextTheme(
            ThemeData.dark().textTheme,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
