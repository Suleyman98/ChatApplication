import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utilities/pager.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages!'),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('chat').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot user = snapshot.data!.docs[index];

                if (user.id.contains(FirebaseAuth.instance.currentUser!.uid)) {
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return Pager.doc(user);
                        },
                      ));
                    },
                    leading:
                        CircleAvatar(child: Image.network(user['userImage'])),
                    title: Text(user['username']),
                    subtitle: Text(user['message']),
                    trailing: const Text('14'),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return Pager.users;
              },
            ));
          },
          child: const Icon(Icons.person)),
    );
  }
}
