import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:ikra/pages/favPage.dart';
import '../pages/home.dart';
import '../pages/view.dart';

class Iconbar extends StatelessWidget {
  final int index;
  const Iconbar({
    super.key,
    required this.index,
  });

  void _showdilog() {}
  @override
  Widget build(BuildContext context) {
    // لون الأيقونات حسب الصفحة
    Color getIconColor(int buttonIndex) {
      if (index == 1) {
        // إذا كانت الصفحة هي Home، اجعل الأيقونات بيضاء باستثناء الأيقونة الحالية
        return buttonIndex == index ? const Color(0xFFA28D4F) : Colors.white;
      } else {
        // إذا كانت الصفحة ليست Home، استخدم اللون الافتراضي
        return buttonIndex == index ? const Color(0xFFA28D4F) : Colors.black87;
      }
    }

    // دالة للتنقل بين الصفحات
    void navigateTo(int buttonIndex) {
      if (buttonIndex != index) {
        // تجنب إعادة التنقل لنفس الصفحة
        Widget page;
        switch (buttonIndex) {
          case 1:
            page = const Home(); // الصفحة الرئيسية
            break;
          case 2:
            page = const ViewPage(); // صفحة الكتب
            break;
          case 3:
            page = const Favpage(); // صفحة المفضلة
            break;
          case 4:
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("About us"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'images/M3Logo.png', // مسار الصورة
                        height: 100,
                        width: 100,
                      ),
                      const SizedBox(height: 16), // مسافة بين الصورة والنص
                      const Text(
                        "The application was made by the m3code team.",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // إغلاق النافذة
                      },
                      child: const Text("close"),
                    ),
                  ],
                );
              },
            ); // صفحة حول
            return;
          default:
            return; // إذا لم يكن هناك صفحة مقابلة
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      }
    }

    return SafeArea(
      child: Container(
        height: 70,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: const BorderRadius.all(Radius.circular(24)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.menu_book,
                color: getIconColor(1),
                size: 40,
              ),
              onPressed: () {
                navigateTo(1); // التنقل إلى الصفحة الرئيسية
              },
            ),
            IconButton(
              icon: Icon(
                Bootstrap.book_half,
                color: getIconColor(2),
                size: 40,
              ),
              onPressed: () {
                navigateTo(2); // التنقل إلى صفحة الكتب
              },
            ),
            IconButton(
              icon: Icon(
                Bootstrap.bookmark_heart,
                color: getIconColor(3),
                size: 40,
              ),
              onPressed: () {
                navigateTo(3); // التنقل إلى صفحة المفضلة
              },
            ),
            IconButton(
              icon: Icon(
                Bootstrap.info_circle,
                color: getIconColor(4),
                size: 40,
              ),
              onPressed: () {
                navigateTo(4); // التنقل إلى صفحة حول
              },
            ),
          ],
        ),
      ),
    );
  }
}
