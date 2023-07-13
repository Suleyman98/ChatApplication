import 'package:flutter/material.dart';

import '../utilities/pager.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(),
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
