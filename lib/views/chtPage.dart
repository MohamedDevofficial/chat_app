import 'package:chat_app/Const.dart';
import 'package:chat_app/Models/masseg.dart';
import 'package:chat_app/views/login.dart';
import 'package:chat_app/widjets/chatbubl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Chtpage extends StatelessWidget {
  CollectionReference Messegs = FirebaseFirestore.instance.collection(
    KMessagescollection,
  );
  TextEditingController messegecontroller = TextEditingController();
  static const id = "chatpage";
  List<Message> messagesList = [];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)?.settings.arguments as String;
    return StreamBuilder(
      stream: Messegs.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        // ✅ حوّل الداتا مباشرة من الـ snapshot
        List<Message> messagesList = snapshot.data!.docs
            .map((doc) => Message.fromJson(doc))
            .toList();
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyActions: false,
            backgroundColor: primarycolor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Chat    '),
                Image.asset("assets/images/logo.png", height: 50),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    return messagesList[index].id == email
                        ? ChatBuble(message: messagesList[index].message)
                        : ChatBubleFrind(message: messagesList[index].message);
                  },
                  itemCount: messagesList.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: messegecontroller,
                  onSubmitted: (value) {
                    Messegs.add({
                      KMessage: value,
                      kCreatedAt: DateTime.now(),
                      kEmail: email,
                    });
                    messegecontroller.clear();
                    _scrollController.animateTo(
                      0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                    );
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: primarycolor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: LoginScrean.primarycolor),
                    ),
                    hintText: "Type your message here",
                    suffixIcon: Icon(
                      Icons.send,
                      color: LoginScrean.primarycolor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

        // ListView(
        //   children: [
        //     ChatBuble(),
        //     ChatBuble(),
        //   ],
      },
    );
  }
}
