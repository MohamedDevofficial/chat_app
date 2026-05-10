import 'package:chat_app/views/chtPage.dart';
import 'package:chat_app/views/register_screan.dart';
import 'package:chat_app/widjets/custom_Bouton.dart';
import 'package:chat_app/widjets/custom_text_fild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScrean extends StatefulWidget {
  const LoginScrean({super.key});
  static const primarycolor = Color(0xff2b475e);
  static const id = "login";

  @override
  State<LoginScrean> createState() => _LoginScreanState();
}

class _LoginScreanState extends State<LoginScrean> {
  final _formKey = GlobalKey<FormState>();

  String? emailAddress;
  String? password;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: LoginScrean.primarycolor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  'Cahat App',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                Image(image: AssetImage("assets/images/logo.png")),
                SizedBox(height: 20),
                Text(
                  'Sign in ',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: "Enter your email",
                  onChanged: (value) {
                    emailAddress = value;
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: "Enter your password",
                  onChanged: (value) {
                    password = value;
                  },
                ),
                SizedBox(height: 40),
                CustomButton(
                  Name: "Login",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });

                      try {
                        await SignIn();
                        Navigator.pushNamed(
                          context,
                          Chtpage.id,
                          arguments: emailAddress,
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          CusomSnackBar(
                            context,
                            'No user found for that email.',
                          );
                        } else if (e.code == 'wrong-password') {
                          CusomSnackBar(
                            context,
                            'Wrong password provided for that user.',
                          );
                        } else {
                          CusomSnackBar(context, 'Error: ${e.message}');
                        }
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "dont have an account",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RegisterScrean.id,
                          arguments: emailAddress,
                        );
                      },
                      child: Text(
                        "    Sign up",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void CusomSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> SignIn() async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress!,
      password: password!,
    );
  }
}
