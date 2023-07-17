import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  final DocumentSnapshot user;
  const NewMessages({super.key, required this.user});

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final messageController = TextEditingController();
  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  String chatRoomId(String me, String you) {
    if (me[0].toLowerCase().codeUnits[0] > you.toLowerCase().codeUnits[0]) {
      return '$me$you';
    } else {
      return '$you$me';
    }
  }

  void _submitMessage() async {
    final enteredMessage = messageController.text;

    if (enteredMessage.trim().isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus();
    messageController.clear();

    await FirebaseFirestore.instance
        .collection('chat')
        .doc(chatRoomId(
            FirebaseAuth.instance.currentUser!.uid, widget.user['userId']))
        .collection('messages')
        .add({
      'message': enteredMessage,
      'createdAt': Timestamp.now(),
      'me': FirebaseAuth.instance.currentUser!.uid,
      'you': widget.user['userId'],
      'username': widget.user['username'],
      'userImage': widget.user['image_url']
    }).then((value) => FirebaseFirestore.instance
          ..collection('chat')
              .doc(chatRoomId(FirebaseAuth.instance.currentUser!.uid,
                  widget.user['userId']))
              .set({
            'message': enteredMessage,
            'createdAt': Timestamp.now(),
            'me': FirebaseAuth.instance.currentUser!.uid,
            'you': widget.user['userId'],
            'username': widget.user['username'],
            'userImage': widget.user['image_url']
          }));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: const InputDecoration(labelText: 'Send a message'),
            ),
          ),
          IconButton(
              onPressed: _submitMessage,
              color: Theme.of(context).colorScheme.primary,
              icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
