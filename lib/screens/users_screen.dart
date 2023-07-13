import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utilities/pager.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                DocumentSnapshot user = snapshot.data!.docs[index];

                return ListTile(
                  leading:
                      CircleAvatar(child: Image.network(user['image_url'])),
                  title: Text(user['username']),
                  subtitle: Text(user['email']),
                  trailing: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return Pager.chat(user);
                          },
                        ));
                      }),
                );
              },
              itemCount: snapshot.data!.docs.length,
            );
          }),
    );
  }
}
