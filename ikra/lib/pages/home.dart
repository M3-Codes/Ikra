import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

import '../design/textfont.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> bookCovers = [
    'images/book1.jpg', // استبدل هذه المسارات بالصور التي لديك
    'images/book2.jpg',
    'images/book3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141B24), // لون الخلفية الداكن
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 130,
        title: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'images/ikraicon.png', // تأكد من وضع الصورة في مجلد assets
              height: 50,
            ),
            const SizedBox(height: 1), // مساحة بين الصورة والنص
            const Textdesign(
              "Welcome Back, Mert",
              24,
              color: Colors.white,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: '  Search for books...',
                hintStyle: const TextStyle(color: Colors.grey),
                suffixIcon:
                    const Icon(Icons.search_rounded, color: Colors.grey),
                filled: true,
                fillColor: Colors.white.withOpacity(0.2), // شفافية للخلفية
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Stack(
              clipBehavior: Clip.none, // للسماح للصور بالخروج من الحواف
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: 130, // تقليل الحشو في الأسفل
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'Come to a book as you \n would come to an\n unexplored land',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 60), // مساحة بين النص والشريط
                    ],
                  ),
                ),
                Positioned(
                  top:
                      120, // ضبط موضع الشريط بحيث يخرج من الحافة السفلية للمربع الأبيض
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 240, // ارتفاع شريط الصور
                    child: InfiniteCarousel.builder(
                      itemCount: bookCovers.length,
                      itemExtent: 200,
                      center: true,
                      anchor: 0.5,
                      velocityFactor: 0.5,
                      loop: false,
                      itemBuilder: (context, index, realIndex) {
                        // حساب التكبير بناءً على موقع العنصر النسبي
                        double distanceToCenter =
                            (realIndex - index).abs().toDouble();
                        double scale = 1.0 - (distanceToCenter * 0.25);
                        scale = scale.clamp(0.8, 1.2); // التحكم بالحدود

                        return Transform.scale(
                          scale: scale,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage(bookCovers[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
