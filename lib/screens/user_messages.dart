import 'package:chat_application/screens/message_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserMessages extends StatefulWidget {
  final DocumentSnapshot user;
  const UserMessages({super.key, required this.user});

  @override
  State<UserMessages> createState() => _UserMessagesState();
}

class _UserMessagesState extends State<UserMessages> {
  String chatRoomId(String me, String you) {
    if (me[0].toLowerCase().codeUnits[0] > you.toLowerCase().codeUnits[0]) {
      return '$me$you';
    } else {
      return '$you$me';
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        QuerySnapshot<Map<String, dynamic>>? loadedMessages = snapshot.data;
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 40, left: 13, right: 13),
          itemBuilder: (context, index) {
            Map<String, dynamic> message = loadedMessages.docs[index].data();
            return MessageBubble(
                userImage: message['userImage'],
                username: message['username'],
                message: message['message'],
                isMe: currentUser == message['me']);
          },
          itemCount: loadedMessages!.docs.length,
          reverse: true,
        );
      },
      stream: FirebaseFirestore.instance
          .collection('chat')
          .doc(chatRoomId(
              FirebaseAuth.instance.currentUser!.uid, widget.user['you']))
          .collection('messages')
          .orderBy('createdAt', descending: true)
          .snapshots(),
    );
  }
}
