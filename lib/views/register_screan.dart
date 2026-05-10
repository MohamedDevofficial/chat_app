import 'package:chat_app/views/chtPage.dart';
import 'package:chat_app/views/login.dart';
import 'package:chat_app/widjets/custom_Bouton.dart';
import 'package:chat_app/widjets/custom_text_fild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScrean extends StatefulWidget {
  RegisterScrean({super.key});
  static const id = "register";
  @override
  State<RegisterScrean> createState() => _RegisterScreanState();
}

class _RegisterScreanState extends State<RegisterScrean> {
  String? emailAddress;

  String? password;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

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
                  'Register',
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
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });

                      try {
                        await registerUser();
                        Navigator.pushNamed(
                          context,
                          Chtpage.id,
                          arguments: emailAddress,
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          CusomSnackBar(
                            context,
                            'The password provided is too weak.',
                          );
                        } else if (e.code == 'email-already-in-use') {
                          CusomSnackBar(
                            context,
                            'The account already exists for that email.',
                          );
                        } else {
                          CusomSnackBar(
                            context,
                            'An error occurred. Please try again.',
                          );
                        }
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                  },
                  Name: "Register",
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "already have an account",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "    Login",
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

  Future<void> registerUser() async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: emailAddress!,
          password: password!,
        );
  }
}
