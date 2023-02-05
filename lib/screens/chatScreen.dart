import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bubble_loader/bubble_loader.dart';
import 'package:chat_application/screens/auth_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

late User signedInUser;
final _firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const id = 'ChatScreen';
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;

  String? msg;
  late TextEditingController textEditingController;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void getMessageStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var msg in snapshot.docs) {
        print(msg.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffeacded),
        leading: Icon(
          Icons.arrow_back_ios,
          color: Color(0xff9e59aa),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Color(0xff9e59aa),
            ),
            onPressed: () {
              _auth.signOut();
              exit(0);
              // Navigator.pushNamedAndRemoveUntil(
              //     context, AuthScreen.id, (route) => false);
            },
          ),
        ],
        title: Row(
          children: [
            Image.asset(
              'images/s1.png',
              height: 30,
            ),
            Text(
              'Chat',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xff9e59aa),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('messages')
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  // List<Text> messageWidgets = [];

                  if (snapshot.hasData) {
                    List<dynamic> messages = snapshot.data!.docs;

                    return Expanded(
                      child: ListView.builder(
                          reverse: true,
                          shrinkWrap: true,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final currentUser = signedInUser.email;
                            return MessageBubble(
                                messages: messages,
                                index: index,
                                sender: messages[index]['sender'],
                                isMe: messages[index]['sender'] == currentUser);
                          }),
                    );
                  }
                  return BubbleLoader(
                    color1: Colors.deepPurple,
                    color2: Color(0xff9e59aa),
                    bubbleGap: 10,
                    bubbleScalingFactor: 1,
                    duration: Duration(milliseconds: 1500),
                  );

                  // final msgs = snapshot.data!.docs;
                  // for (var msg in msgs) {
                  //   final txt = msg.get('text');
                  //   final sender = msg.get('sender');
                  //   final messageWidget = Text('$txt -- $sender');
                  //   messageWidgets.add(messageWidget);
                  // }
                }),
            // return ListView(
            //   children: messageWidgets,
            // );

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xff9e59aa),
                      width: 2,
                    ),
                    right: BorderSide(
                      color: Color(0xff9e59aa),
                      width: 2,
                    ),
                    left: BorderSide(
                      color: Color(0xff9e59aa),
                      width: 2,
                    ),
                    top: BorderSide(
                      color: Color(0xff9e59aa),
                      width: 2,
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          msg = value;
                        },
                        controller: textEditingController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          hintText: 'Write your message here...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          textEditingController.clear();

                          _firestore.collection('messages').add({
                            'text': msg,
                            'sender': signedInUser.email,
                            'time': FieldValue.serverTimestamp(),
                          });
                          getMessageStream();
                        },
                        icon: Icon(
                          Icons.send,
                          size: 18,
                          color: Color(0xff9e59aa),
                        )),
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

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key,
      required this.messages,
      required this.index,
      required this.sender,
      required this.isMe})
      : super(key: key);

  final List messages;
  final int index;
  final String sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(
            '$sender',
            style: TextStyle(fontSize: 12, color: Color(0xff9e59aa)),
          ),
          SizedBox(
            height: 8,
          ),
          Material(
            color: isMe ? Color(0xff5d3464) : Color(0xffba68c8),
            borderRadius: isMe
                ? BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${messages[index]['text']}',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
