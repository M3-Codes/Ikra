import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:ikra/Db/bookData.dart';
import 'package:ikra/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';




class AuthService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';


   static Future<bool> register(String username, String email, String password) async {
    try {
      // Prepare the API request
      final response = await http.post(
        Uri.parse('$baseUrl/register'), // Adjust endpoint as per your backend
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': username,
          'email': email,
          'password': password,
        }),
      );

      // Handle the response
      if (response.statusCode == 201) {
        // Registration successful
        return true;
      } else {
        // Log error details for debugging
        print('Registration failed: ${response.body}');
        return false;
      }
    } catch (e) {
      // Handle exceptions like network errors
      print('Exception during registration: $e');
      return false;
    }
  }

  static Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String token = data['token'];
        int ID = data['id'];
        
       TokenStorage.saveToken(token,ID);
        return token; // ارجع التوكن

         
      } else {
        print('Error: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }
}


  
class TokenStorage {
  static Future<void> saveToken(String token,int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setInt('id', id);
      List<int> list =await BookData.fetchFavorites();
        FavoriteData.fillList(list);

  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
  static Future<int?> getID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id');
  }

   static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // Clear the token on logout
    await prefs.remove('id');
  }
}

Future<void> fetchUserProfile() async {
  final token = await TokenStorage.getToken();

  final response = await http.get(
    Uri.parse('http://10.0.2.2:8000/api/user'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    var user = jsonDecode(response.body);
    print('User: $user');
  } else {
    print('Error: ${response.body}');
  }
}

// Future<String> fetchUserID() async {
//   final token = await TokenStorage.getToken();

//   final response = await http.get(
//     Uri.parse('http://10.0.2.2:8000/api/user'),
//     headers: {'Authorization': 'Bearer $token'},
//   );

//   if (response.statusCode == 200) {
//     var user = jsonDecode(response.body);
//     String ID = user["data"];
//     return ID;
//   } else {
//     return 'Error: ${response.body}';
//   }
// }

void handleLogout(BuildContext context) async {
  await TokenStorage.logout(); // Clear the token
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const Login()),
    (route) => false,
  );
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