import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewDocMessages extends StatefulWidget {
  final DocumentSnapshot message;
  const NewDocMessages({super.key, required this.message});

  @override
  State<NewDocMessages> createState() => _NewDocMessagesState();
}

class _NewDocMessagesState extends State<NewDocMessages> {
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
        .doc(chatRoomId(widget.message['me'], widget.message['you']))
        .collection('messages')
        .add({
          ''
              'message': enteredMessage,
          'createdAt': Timestamp.now(),
          'me': FirebaseAuth.instance.currentUser!.uid,
          'you': widget.message['you'],
          'username': widget.message['username'],
          'userImage': widget.message['userImage']
        })
        .then((value) => FirebaseFirestore.instance
                .collection('chat')
                .doc(chatRoomId(widget.message['you'], widget.message['me']))
                .set({
              'message': enteredMessage,
              'createdAt': Timestamp.now(),
              'me': FirebaseAuth.instance.currentUser!.uid,
              'you': widget.message['you'],
              'username': widget.message['username'],
              'userImage': widget.message['userImage']
            }))
        .catchError((e) {
          print(e.toString());
        });
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
