import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/message_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<List<MessageModel>> getUserDetails() async {
    final snapshot = FirebaseFirestore.instance
            .collection('chat')
            .id
            .contains(FirebaseAuth.instance.currentUser!.uid)
        ? await FirebaseFirestore.instance.collection('chat').get()
        : null;

    return snapshot!.docs.map((e) => MessageModel.fromSnapshot(e)).toList();
  }
}
