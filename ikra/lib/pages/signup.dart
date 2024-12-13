// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ikra/design/welcome_signup_login/BG_w.dart';
import 'package:ikra/design/welcome_signup_login/logo_ikraW.dart';
import '../design/welcome_signup_login/BG_text.dart';
import '../design/welcome_signup_login/buttonauth.dart';
import '../design/welcome_signup_login/changepage.dart';
import '../design/welcome_signup_login/textform.dart';
import '../design/welcome_signup_login/textformpassword.dart';
import '../generated/l10n.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Column(children: [
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
                        Column(children: [
                          TextForm(
                              hinttext: S.of(context).username,
                              ccontroller: username,
                              icon: Icons.person,
                              validator: (val) {
                                if (val == "") {
                                  return S.of(context).filed;
                                }
                                return null;
                              }),
                          const SizedBox(height: 18),
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
                          const SizedBox(height: 43),
                        ]),
                        ButtonAtuh(
                            title: "  ${S.of(context).signup}  ",
                            horizontal: 0,
                            colorbackround: const Color(0xFFA28D4F),
                            colorfont: const Color.fromARGB(255, 255, 255, 255),
                            onPressed: () {
                              if (formState.currentState!.validate()) {
                                // عرض Snackbar عند نجاح التسجيل
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Registration successful!"),
                                    duration: Duration(
                                        seconds: 2), // مدة العرض: ثانيتان
                                    backgroundColor:
                                        Color(0xFF141B24), // لون خلفية Snackbar
                                  ),
                                );
                              } else {
                                // في حالة وجود أخطاء في الحقول
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Please fill in all required fields."),
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Color(
                                        0xFF141B24), // لون خلفية Snackbar للأخطاء
                                  ),
                                );
                              }
                            }),
                        const SizedBox(height: 19),
                        ChangePage(
                            path: '/login',
                            firstText: S.of(context).pageswitchS,
                            lastText: S.of(context).login)
                      ],
                    )),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
