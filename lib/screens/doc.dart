import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'doc_messages.dart';
import 'new_doc_messages.dart';

class DocScreen extends StatelessWidget {
  final DocumentSnapshot message;
  const DocScreen({
    Key? key,
    required this.message,
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
          Expanded(child: DocMessages(message: message)),
          NewDocMessages(message: message),
        ],
      ),
    );
  }
}
