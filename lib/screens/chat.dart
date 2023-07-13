import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:chat_application/screens/chat_messages.dart';

import 'new_messages.dart';

class ChatScreen extends StatelessWidget {
  final DocumentSnapshot user;
  const ChatScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          )
        ],
        title: const Text('FlutterChat'),
      ),
      body: Column(
        children: [
          Expanded(child: ChatMessages(user: user)),
          NewMessages(user: user),
        ],
      ),
    );
  }
}
