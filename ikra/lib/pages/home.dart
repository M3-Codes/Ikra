import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
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
    int selectedIndex = 0;
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
                    height: 320, // ارتفاع شريط الصور
                    child: CarouselSlider.builder(
                      itemCount: bookCovers.length,
                      itemBuilder: (context, index, realIndex) {
                        // حساب التكبير بناءً على موقع العنصر النسبي
                        final String Image = (bookCovers[index]);
                        return bulidImage(Image, index);
                      },
                      options: CarouselOptions(
                          height: 300, // ارتفاع شريط الصور
                          enlargeCenterPage: true, // تكبير العنصر في المركز
                          viewportFraction: 0.6, // نسبة عرض العنصر الواحد
                          enableInfiniteScroll: true, // تعطيل التكرار اللانهائي
                          initialPage: 0,
                          autoPlay: true),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          height: 60,
          padding: const EdgeInsets.all(6),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.home,
                  color: Color(0xFFA28D4F),
                  size: 40,
                ),
                onPressed: () {
                  // الإجراء عند الضغط على زر Home
                },
              ),
              IconButton(
                icon: const Icon(Icons.menu_book_sharp,
                    color: Colors.white, size: 40),
                onPressed: () {
                  // الإجراء عند الضغط على زر الكتاب
                },
              ),
              IconButton(
                icon: const Icon(Icons.bookmark, color: Colors.white, size: 40),
                onPressed: () {
                  // الإجراء عند الضغط على زر المفضلة
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.info_outline,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () {
                  // الإجراء عند الضغط على زر حول
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bulidImage(String image, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Image.asset(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}
