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
    final theme = Theme.of(context);

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        child: Text(message),
      ),
    );
  }
}
