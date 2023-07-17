import 'package:flutter/material.dart';

// A MessageBubble for showing a single chat message on the ChatScreen.
class MessageBubble extends StatelessWidget {
  // Create a message bubble which is meant to be the first in the sequence.
  const MessageBubble({
    super.key,
    required this.userImage,
    required this.username,
    required this.message,
    required this.isMe,
  });

  final String? userImage;

  final String? username;
  final String message;

  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final themez = Theme.of(context);

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        width: 100,
        height: 60,
        decoration: isMe
            ? BoxDecoration(
                color: Colors.yellow, borderRadius: BorderRadius.circular(10))
            : BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10)),
        child: Text(message),
      ),
    );
  }
}
