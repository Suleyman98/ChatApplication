import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                if (user.id != FirebaseAuth.instance.currentUser!.uid) {
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
                } else {
                  return const SizedBox.shrink();
                }
              },
              itemCount: snapshot.data!.docs.length,
            );
          }),
    );
  }
}
