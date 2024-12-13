import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ikra/API/AuthService.dart';
import 'package:ikra/design/textfont.dart';
import '../design/home/background box.dart';
import '../design/home/searchbox.dart';
import '../design/iconbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

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
        actions: [
           
         IconButton(icon: const Icon(Icons.logout_rounded),color: Colors.white, onPressed: () { handleLogout(context) ;},) 

        ],
         
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 100,
        flexibleSpace: Center(
          
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/ikraicon.png',
                height: 50,
              ),
              const SizedBox(height: 8),
              const Textdesign(
                "Welcome Back, Mert",
                24,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [

            
          SearchBox(
            onSuggestionSelected: (suggestion) {
              // Handle suggestion selection
            },
          ),
          const SizedBox(
            height: 10,
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
                        final String image = bookCovers[index];
                        return buildImage(image, index);
                      },
                      options: CarouselOptions(
                        height: 300,
                        enlargeCenterPage: true,
                        viewportFraction: 0.6,
                        enableInfiniteScroll: true,
                        initialPage: 0,
                        autoPlay: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const Iconbar(
        index: 1,
      ),
    );
  }

  Widget buildImage(String image, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Image.asset(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}
