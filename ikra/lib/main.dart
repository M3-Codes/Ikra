import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ikra/pages/splash.dart';
import 'package:provider/provider.dart';
import 'generated/l10n.dart';
import 'language_provider.dart';
import 'pages/login.dart';
import 'pages/signup.dart';
import 'pages/welecome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final bool _isLoading = false;
  Locale _locale = const Locale('en');
  void _setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return MaterialApp(
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''), // English
              Locale('tr', ''), // Turkish
            ],
            locale: languageProvider.locale, // Active locale
            navigatorKey: MyApp.navigatorKey,
            debugShowCheckedModeBanner: false,
            home: const Splash(),
            routes: {
              '/welcome': (context) => const Welcome(),
              '/login': (context) => const Login(),
              '/signup': (context) => const Signup(),
              // '/homepage': (context) => const HomePage(),
            },
          );
        },
      ),
    );
  }
}
