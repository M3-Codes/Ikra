import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _checkTokenAndNavigate();
  }

  Future<void> _checkTokenAndNavigate() async {
    // الانتظار لمدة 6 ثوانٍ لإظهار شاشة التحميل
    await Future.delayed(const Duration(seconds: 6));

    // التحقق من وجود التوكن
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      // إذا كان التوكن موجودًا، الانتقال إلى صفحة الرئيسية
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      // إذا لم يكن التوكن موجودًا، الانتقال إلى صفحة تسجيل الدخول
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacementNamed('/login');
    }
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
