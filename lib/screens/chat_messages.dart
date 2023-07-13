import 'package:chat_application/screens/message_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  final DocumentSnapshot user;
  const ChatMessages({super.key, required this.user});

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
          .doc('${currentUser}_${user['userId']}')
          .collection('messages')
          .snapshots(),
    );
  }
}
