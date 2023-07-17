import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? message;
  Timestamp? createdAt;
  String? me;
  String? you;
  String? username;
  String? userImage;

  MessageModel(
      {this.message,
      this.createdAt,
      this.me,
      this.you,
      this.username,
      this.userImage});

  factory MessageModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return MessageModel(
        message: data['message'],
        createdAt: data['createdAt'],
        me: data['me'],
        you: data['you'],
        userImage: data['userImage'],
        username: data['username']);
  }
}
