import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:ikra/Db/bookData.dart';
import 'package:ikra/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchService {
  Future<List<Book>> searchBooks(String inputStr) async {
    final response = await http.get(Uri.parse(
        'https://f4f0-85-105-61-128.ngrok-free.app/api/v1/books?title[con]=$inputStr'));

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      if (responseData['data'] is List) {
        return (responseData['data'] as List)
            .map((json) => Book.fromJson(json))
            .toList();
      } else {
        throw Exception('Data is not a list');
      }
    } else {
      throw Exception('Failed to load books');
    }
  }
}





  // Future<void> loginWithGoogle(GoogleSignIn googleSignIn,BuildContext context) async {
    
  //   try {
  //     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  //     if (googleUser == null) {
  //       // المستخدم ألغى تسجيل الدخول
  //       return;
  //     }

  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;

  //     // أرسل Google Token إلى API Laravel
  //     final response = await http.post(
  //       Uri.parse('https://10.0.2.2:8000/api/login/google'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({'token': googleAuth.idToken}),
  //     );

  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);

  //       // احفظ Token المستخدم في SharedPreferences
  //       final userToken = data['token'];
  //       TokenStorage.saveToken(userToken);
     

  //       // انتقل إلى الشاشة الرئيسية
  //       Navigator.pushReplacementNamed(context, '/home');
  //     } else {
  //       print("Login failed: ${response.body}");
  //     }
  //   } catch (e) {
  //     print("Error logging in with Google: $e");
  //   }
  // }