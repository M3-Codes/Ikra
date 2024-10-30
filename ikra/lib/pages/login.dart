import 'package:flutter/material.dart';
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

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool _loading = false;

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
                            Container(height: 43),
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
                                    }),
                                const SizedBox(height: 18),
                                TextForm_Password(
                                    ccontroller: password,
                                    validator: (val) {
                                      if (val == "") {
                                        return S.of(context).filed;
                                      }
                                      return null;
                                    }),
                                const forgetpass(),
                                const SizedBox(height: 18),
                              ],
                            ),
                            ButtonAtuh(
                              title: "  ${S.of(context).login}  ",
                              horizontal: 0,
                              colorbackround: const Color(0xFFA28D4F),
                              colorfont:
                                  const Color.fromARGB(255, 255, 255, 255),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()));
                              },
                            ),
                            const SizedBox(height: 14),
                            const Column(children: [Divider_login()]),
                            const SizedBox(height: 14),
                            ElevatedButton(
                              onPressed: () {
                                // إجراءات تسجيل الدخول بواسطة Google بدون Firebase
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                    const Color(0xFFA28D4F)),
                                padding: WidgetStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        horizontal: 155, vertical: 10)),
                                shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                              ),
                              child:
                                  Image.asset("images/google.png", width: 30),
                            ),
                            const SizedBox(height: 19),
                            ChangePage(
                                path: '/signup',
                                firstText: S.of(context).pageswitchL,
                                lastText: S.of(context).signup)
                          ],
                        )),
                  ],
                ),
              ),
            ),
            // const Logo_M3_CODE_1(path: "images/yslogo.png")
          ],
        ),
      ),
    );
  }
}
