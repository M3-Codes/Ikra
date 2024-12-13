import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ikra/Db/bookData.dart';
import 'package:ikra/pages/home.dart';
import 'package:ikra/pages/splash.dart';
import 'package:provider/provider.dart';
import 'Db/search_provider.dart';
import 'generated/l10n.dart';
import 'language_provider.dart';
import 'pages/login.dart';
import 'pages/signup.dart';
import 'pages/welecome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize BookData
  await BookData.initializeData();

  // Run the app with Splash screen as the initial page
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteData()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return MaterialApp(
            title: 'Flutter Auth',
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
            home: const Splash(), // Set Splash as the initial page
            routes: {
              '/welcome': (context) => const Welcome(),
              '/login': (context) => const Login(),
              '/signup': (context) => const Signup(),
              '/home': (context) => const Home(),
            },
          );
        },
      ),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:ikra/Db/bookData.dart';
// import 'package:ikra/pages/home.dart';
// import 'package:ikra/pages/splash.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'generated/l10n.dart';
// import 'language_provider.dart';
// import 'pages/login.dart';
// import 'pages/signup.dart';
// import 'pages/welecome.dart';


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Retrieve the token from SharedPreferences
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? token = prefs.getString('token');

//   // Initialize BookData before running the app
//   await BookData.initializeData();

//   // Launch the app with the appropriate initial page
//   runApp(MyApp(initialPage: token != null ? const Home() : Login()));
// }



// class MyApp extends StatelessWidget {
//   //const MyApp({super.key});

//    final Widget initialPage;

//  // const MyApp({Key? key, required this.initialPage}) : super(key: key);
//     const MyApp({super.key, required this.initialPage});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Auth',
//       home: initialPage,
//     );
//   }

//   static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//   @override
//   State<MyApp> createState() => _MyAppState();
// }


// class _MyAppState extends State<MyApp> {
//   final bool _isLoading = false;
//   Locale _locale = const Locale('en');
//   void _setLocale(Locale locale) {
//     setState(() {
//       _locale = locale;
//     });
//   }

//   @override
//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => FavoriteData()),
//         ChangeNotifierProvider(create: (_) => LanguageProvider()),
        

//       ],
//       child: Consumer<LanguageProvider>(
//         builder: (context, languageProvider, child) {
//           return MaterialApp(
//             localizationsDelegates: const [
//               S.delegate,
//               GlobalMaterialLocalizations.delegate,
//               GlobalWidgetsLocalizations.delegate,
//               GlobalCupertinoLocalizations.delegate,
//             ],
//             supportedLocales: const [
//               Locale('en', ''), // English
//               Locale('tr', ''), // Turkish
//             ],
//             locale: languageProvider.locale, // Active locale
//             navigatorKey: MyApp.navigatorKey,
//             debugShowCheckedModeBanner: false,
//             home: const Splash(),
//             routes: {
//               '/welcome': (context) => const Welcome(),
//               '/login': (context) => const Login(),
//               '/signup': (context) => const Signup(),
//               // '/homepage': (context) => const HomePage(),
//             },
//           );
//         },
//       ),
//     );
//   }
// }
