import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ikra/API/AuthService.dart';
import 'package:ikra/Db/bookData.dart';
import 'package:ikra/design/welcome_signup_login/BG_w.dart';
import 'package:ikra/design/welcome_signup_login/logo_ikraW.dart';
import 'package:ikra/pages/home.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../design/welcome_signup_login/BG_text.dart';
import '../design/welcome_signup_login/buttonauth.dart';
import '../design/welcome_signup_login/changepage.dart';
import '../design/welcome_signup_login/divider_login.dart';
import '../design/welcome_signup_login/forgetpass.dart';
import '../design/welcome_signup_login/textform.dart';
import '../design/welcome_signup_login/textformpassword.dart';
import '../generated/l10n.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        "606334008047-a9s88l8jertscat1gkrm6p7aroe08mc9.apps.googleusercontent.com",
    scopes: ['email'],
    hostedDomain: "",
    signInOption: SignInOption.standard,
  );
  bool _loading = false; // Fixed: Changed from `final` to `bool`

  // Handle Login Method
  void handleLogin() async {
    if (!formState.currentState!.validate()) return; // Validate fields

    setState(() {
      _loading = true; // Show spinner
    });

    try {
      String? token =
          await AuthService.login(email.text.trim(), password.text.trim());

      if (token != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } else {
        _showErrorDialog('Login Failed', 'Invalid email or password');
      }
    } catch (e) {
      _showErrorDialog('Error', e.toString());
    } finally {
      setState(() {
        _loading = false; // Hide spinner
      });
    }
  }

  Future<void> loginWithGoogle() async {
    await _googleSignIn.signOut();
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // المستخدم ألغى تسجيل الدخول
        print("User canceled login.");
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // أرسل Google Token إلى API Laravel
      final response = await http.post(
        Uri.parse('https://f4f0-85-105-61-128.ngrok-free.app/api/login/google'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': googleAuth.idToken}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        print(data);
        // احفظ Token المستخدم في SharedPreferences
        String userToken = data['token'];

        int userID = data['user']['id'];

        TokenStorage.saveToken(userToken, userID);
        // مثال على حفظه:
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // await prefs.setString('userToken', userToken);

        // انتقل إلى الشاشة الرئيسية
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        print("Login failed: ${response.body}");
      }
    } catch (e) {
      print("Error logging in with Google: $e");
    }
  }

  // Show Error Dialog
  void _showErrorDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.center,
          children: [
            const BG_w(),
            const Logo_ikra_M(
              isWhite: false,
            ),
            const BG_text(),
            SizedBox(
              width: 345,
              child: Form(
                key: formState,
                child: Column(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 2,
                      child: ListView(
                        padding: const EdgeInsets.only(top: 0),
                        children: [
                          const SizedBox(height: 43),
                          Column(
                            children: [
                              TextForm(
                                hinttext: S.of(context).email,
                                ccontroller: email,
                                icon: Icons.email,
                                validator: (val) {
                                  if (val == "") {
                                    return S.of(context).filed;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 18),
                              TextForm_Password(
                                ccontroller: password,
                                validator: (val) {
                                  if (val == "") {
                                    return S.of(context).filed;
                                  }
                                  return null;
                                },
                              ),
                              const forgetpass(),
                              const SizedBox(height: 18),
                            ],
                          ),
                          ButtonAtuh(
                            title: "  ${S.of(context).login}  ",
                            horizontal: 0,
                            colorbackround: const Color(0xFFA28D4F),
                            colorfont: const Color.fromARGB(255, 255, 255, 255),
                            onPressed:
                                handleLogin, // Use the handleLogin method
                          ),
                          const SizedBox(height: 14),
                          const Column(children: [Divider_login()]),
                          const SizedBox(height: 14),
                          ElevatedButton(
                            onPressed: () {
                              print("Google login button pressed");
                              loginWithGoogle();
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFFA28D4F)),
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 155, vertical: 10),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            ),
                            child: Image.asset("images/google.png", width: 30),
                          ),
                          const SizedBox(height: 19),
                          ChangePage(
                            path: '/signup',
                            firstText: S.of(context).pageswitchL,
                            lastText: S.of(context).signup,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:ikra/API/AuthService.dart';
// import 'package:ikra/design/welcome_signup_login/BG_w.dart';
// import 'package:ikra/design/welcome_signup_login/logo_ikraW.dart';
// import 'package:ikra/pages/home.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import '../design/welcome_signup_login/BG_text.dart';
// import '../design/welcome_signup_login/buttonauth.dart';
// import '../design/welcome_signup_login/changepage.dart';
// import '../design/welcome_signup_login/divider_login.dart';
// import '../design/welcome_signup_login/forgetpass.dart';
// import '../design/welcome_signup_login/textform.dart';
// import '../design/welcome_signup_login/textformpassword.dart';
// import '../generated/l10n.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   TextEditingController email = TextEditingController();
//   TextEditingController password = TextEditingController();
//   GlobalKey<FormState> formState = GlobalKey<FormState>();


//   final bool _loading = false;

//   void handleLogin() async {
//     String email = email.text.trim();
//     String password = password.text.trim();

//     // استدعاء وظيفة تسجيل الدخول
//     String? token = await AuthService.login(email, password);

//     if (token != null) {
//       // الانتقال إلى الصفحة الرئيسية عند النجاح
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const Home()),
//       );
//     } else {
//       // عرض رسالة خطأ عند الفشل
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text('Login Failed'),
//             content: Text('Invalid email or password'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }}

//   @override
//   Widget build(BuildContext context) {
//     return ModalProgressHUD(
//       inAsyncCall: _loading,
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Stack(
//           alignment: Alignment.center,
//           children: [
//             const BG_w(),
//             const Logo_ikra_M(
//               isWhite: false,
//             ),
//             const BG_text(),
//             SizedBox(
//               width: 345,
//               child: Form(
//                 key: formState,
//                 child: Column(
//                   children: [
//                     const Expanded(
//                       flex: 1,
//                       child: SizedBox(),
//                     ),
//                     Expanded(
//                         flex: 2,
//                         child: ListView(
//                           padding: const EdgeInsets.only(top: 0),
//                           children: [
//                             Container(height: 43),
//                             Column(
//                               children: [
//                                 TextForm(
//                                     hinttext: S.of(context).email,
//                                     ccontroller: email,
//                                     icon: Icons.email,
//                                     validator: (val) {
//                                       if (val == "") {
//                                         return S.of(context).filed;
//                                       }
//                                       return null;
//                                     }),
//                                 const SizedBox(height: 18),
//                                 TextForm_Password(
//                                     ccontroller: password,
//                                     validator: (val) {
//                                       if (val == "") {
//                                         return S.of(context).filed;
//                                       }
//                                       return null;
//                                     }),
//                                 const forgetpass(),
//                                 const SizedBox(height: 18),
//                               ],
//                             ),
//                             ButtonAtuh(
//                               title: "  ${S.of(context).login}  ",
//                               horizontal: 0,
//                               colorbackround: const Color(0xFFA28D4F),
//                               colorfont:
//                                   const Color.fromARGB(255, 255, 255, 255),
//                               onPressed: () async  {
//                                 await AuthService.login(
//                                                   email.text,
//                                                   password.text,
//                                                 );
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => const Home()));
//                               },
//                             ),
//                             const SizedBox(height: 14),
//                             const Column(children: [Divider_login()]),
//                             const SizedBox(height: 14),
//                             ElevatedButton(
//                               onPressed: () {

                             
//                               },
//                               style: ButtonStyle(
//                                 backgroundColor: WidgetStateProperty.all(
//                                     const Color(0xFFA28D4F)),
//                                 padding: WidgetStateProperty.all(
//                                     const EdgeInsets.symmetric(
//                                         horizontal: 155, vertical: 10)),
//                                 shape: WidgetStateProperty.all(
//                                     RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(15))),
//                               ),
//                               child:
//                                   Image.asset("images/google.png", width: 30),
//                             ),
//                             const SizedBox(height: 19),
//                             ChangePage(
//                                 path: '/signup',
//                                 firstText: S.of(context).pageswitchL,
//                                 lastText: S.of(context).signup)
//                           ],
//                         )),
//                   ],
//                 ),
//               ),
//             ),
//             // const Logo_M3_CODE_1(path: "images/yslogo.png")
//           ],
//         ),
//       ),
//     );
//   }
// }
