import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../design/home/background box.dart';
import '../design/home/searchbox.dart';
import '../design/iconbar.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> bookCovers = [
    'images/book1.jpg',
    'images/book2.jpg',
    'images/book3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141B24),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 130,
        flexibleSpace: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/ikraicon.png',
                height: 50,
              ),
              const SizedBox(height: 8),
              const Text(
                "Welcome Back, Mert",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const searchbox(),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const backgroundbox(),
                Positioned(
                  top: 120,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 320,
                    child: CarouselSlider.builder(
                      itemCount: bookCovers.length,
                      itemBuilder: (context, index, realIndex) {
                        final String image = (bookCovers[index]);
                        return bulidImage(image, index);
                      },
                      options: CarouselOptions(
                          height: 300,
                          enlargeCenterPage: true,
                          viewportFraction: 0.6,
                          enableInfiniteScroll: true,
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
      bottomNavigationBar: const Iconbar(),
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
