import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  String username = '';
  File? selectedImage;
  void toggleAuth() {
    isLogin = !isLogin;
    loginStream.sink.add(isLogin);
  }

  void submit(BuildContext context) async {
    if (!(form.currentState!.validate()) || !isLogin && selectedImage == null) {
      return;
    }
    form.currentState!.save();
    try {
      if (isLogin) {
        await _firebase.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: email, password: password);
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredentials.user!.uid}.jpg');
        await storageRef.putFile(selectedImage!);
        final imageUrl = await storageRef.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
          'userId': userCredentials.user!.uid,
          'username': username,
          'email': email,
          'image_url': imageUrl,
        });
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? 'Auth Failed')));
    }
  }
}
