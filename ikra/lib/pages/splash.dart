import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Db/bookData.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      if (mounted) {
        setState(() {
          _isLoading = true;
          _isError = false;
        });
      }

      await Future.delayed(const Duration(seconds: 3));

      await BookData.initializeData();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (mounted) {
        if (token != null) {
          Navigator.of(context).pushReplacementNamed('/home');
        } else {
          Navigator.of(context).pushReplacementNamed('/welcome');
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141B24),
      body: Center(
        child: _isLoading
            ? Lottie.asset(
                'images/bookAnime6.json',
                fit: BoxFit.contain,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 80),
                  const SizedBox(height: 16),
                  const Text(
                    'An error occurred during initialization. Please try again.',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // إعادة تحميل شاشة Splash
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const Splash()),
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
      ),
    );
  }
}
