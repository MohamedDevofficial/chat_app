import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/views/chtPage.dart';
import 'package:chat_app/views/login.dart';
import 'package:chat_app/views/register_screan.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChatApp());
}
class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginScrean.id: (context) => LoginScrean(),
        RegisterScrean.id: (context) => RegisterScrean(),
        Chtpage.id: (context) => Chtpage(),

      },

      initialRoute:LoginScrean.id,
      // LoginScrean.id ,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:LoginScrean(),
      //Chtpage(),
    );
  }
}