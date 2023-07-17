import 'package:chat_application/screens/chat.dart';
import 'package:chat_application/screens/doc.dart';
import 'package:chat_application/screens/messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit/auth_cubit_cubit.dart';
import '../cubit/home_cubit/home_cubit.dart';
import '../screens/auth.dart';
import '../screens/users_screen.dart';

class Pager {
  Pager._();

  static get auth => BlocProvider(
        create: (_) => AuthCubitCubit(),
        child: const AuthScreen(),
      );

  static Widget chat(DocumentSnapshot user) {
    return ChatScreen(user: user);
  }

  static Widget doc(DocumentSnapshot message) {
    return DocScreen(message: message);
  }

  static get users => const UsersScreen();
  static get messages => BlocProvider(
        create: (context) => HomeCubit(),
        child: const MessagesScreen(),
      );
}
