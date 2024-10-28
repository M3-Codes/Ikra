import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // الانتقال إلى صفحة تسجيل الدخول بعد ثلاث ثوانٍ
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.of(context).pushReplacementNamed('/welcome');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141B24),
      body: Column(
        children: [
          Expanded(
            child: Lottie.asset(
              'images/bookAnime6.json',
              fit: BoxFit.contain, // سيضمن احتواء الرسوم المتحركة بالكامل
            ),
          ),
        ],
      ),
    );
  }
}
