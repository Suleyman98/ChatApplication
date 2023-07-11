import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_cubit_state.dart';

class AuthCubitCubit extends Cubit<AuthCubitState> {
  AuthCubitCubit() : super(AuthCubitInitial());
  bool isLogin = false;
  final _firebase = FirebaseAuth.instance;
  final form = GlobalKey<FormState>();
  StreamController<bool> loginStream = StreamController<bool>();
  String email = '';
  String password = '';
  void toggleAuth() {
    isLogin = !isLogin;
    loginStream.sink.add(isLogin);
  }

  void submit(BuildContext context) async {
    if (form.currentState!.validate()) {
      form.currentState!.save();
      if (isLogin) {
        try {
          final userCredentials = await _firebase.signInWithEmailAndPassword(
              email: email, password: password);
          print(userCredentials);
        } on FirebaseAuthException catch (e) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.message ?? 'Auth Failed')));
        }
      } else {
        try {
          await _firebase.createUserWithEmailAndPassword(
              email: email, password: password);
        } on FirebaseAuthException catch (e) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.message ?? 'Auth Failed')));
        }
      }
    }
  }
}
