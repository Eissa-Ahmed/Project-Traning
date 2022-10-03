import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_app/Constant/chachHelper.dart';
import 'package:chat_app/View/Screen/Home/messageModel.dart';
import 'package:chat_app/View/Screen/User/Login/cubit/log_in_cubit.dart';
import 'package:chat_app/View/Screen/User/Login/login.dart';
import 'package:chat_app/View/Screen/User/Login/loginModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../Constant/const.dart';

part 'home_cubit_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeCubitInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  LoginModel? userInfo;

  FirebaseFirestore users = FirebaseFirestore.instance;

  getDataUser() async {
    emit(HomeGetDataUserLoadedState());

    await users.collection("users").doc(uid).get().then((value) {
      userInfo = LoginModel.fromJson(value.data()!);
      emit(HomeGetDataUserSuccessState());
    }).catchError((error) {
      emit(HomeGetDataUserErrorState());
    });
  }

  sendMessageMe({required String message}) {
    MessageModel messageModel = MessageModel(
        date: DateTime.now().toString(),
        message: message,
        receveuid: receveUid,
        uid: uid);
    users
        .collection("users")
        .doc(uid)
        .collection("message")
        .doc(receveUid)
        .collection("chats")
        .add(messageModel.toMap())
        .then((value) {
      emit(HomeSendMessageSuccessState());
    }).catchError((error) {
      emit(HomeSendMessageErrorState());
    });
  }

  sendMessageYou({required String message}) {
    MessageModel messageModel = MessageModel(
      date: DateTime.now().toString(),
      message: message,
      receveuid: receveUid,
      uid: uid,
    );
    users
        .collection("users")
        .doc(receveUid)
        .collection("message")
        .doc(uid)
        .collection("chats")
        .add(messageModel.toMap())
        .then((value) {
      emit(HomeSendMessageYouSuccessState());
    }).catchError((error) {
      emit(HomeSendMessageYouErrorState());
    });
  }

  signOut(BuildContext context) async {
    emit(HomeSignOutLoadedState());
    final user = FirebaseAuth.instance;
    user.currentUser!.getIdToken();
    CachHelper.sharedPreferences.remove("uid");
    await user.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => LogIn()),
    );
    emit(HomeSignOutSuccessState());
  }

  getTokenUser() {
    final user = FirebaseMessaging.instance.getToken();
    user.then((value) {
      token = value.toString();
    });
  }

  statusUser() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        users.collection("users").doc(uid).update({
          "isonline": true,
        });
      }
    } on SocketException catch (_) {
      users.collection("users").doc(uid).update({
        "isonline": false,
      });
    }
  }

  bool isWriteUser = false;
  bool inChatUser = false;
  bool isWrite(String text) {
    if (text.isNotEmpty) {
      users
          .collection("users")
          .doc(uid)
          .collection("message")
          .doc(receveUid)
          .update({
        "iswrite": true,
      });
      isWriteUser = true;
      emit(HomeWriteDoneState());

      return isWriteUser;
    } else {
      users
          .collection("users")
          .doc(uid)
          .collection("message")
          .doc(receveUid)
          .update({
        "iswrite": false,
      });
      isWriteUser = false;
      emit(HomeWriteNotDoneState());

      return isWriteUser;
    }
  }
// bool inChat(String text) {
//     if (text.isNotEmpty) {
//       users
//           .collection("users")
//           .doc(uid)
//           .collection("message")
//           .doc(receveUid)
//           .update({
//         "inchat": true,
//       });
//       inChatUser = true;
//       emit(HomeWriteDoneState());

//       return inChatUser;
//     } else {
//       users
//           .collection("users")
//           .doc(uid)
//           .collection("message")
//           .doc(receveUid)
//           .update({
//         "inchat": false,
//       });
//       inChatUser = false;
//       emit(HomeWriteNotDoneState());

//       return inChatUser;
//     }
//   }

}
