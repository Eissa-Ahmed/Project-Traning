import 'package:bloc/bloc.dart';
import 'package:chat_app/Constant/chachHelper.dart';
import 'package:chat_app/Constant/const.dart';
import 'package:chat_app/View/Screen/User/Login/loginModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../Home/homeChat.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInInitial());

  static LogInCubit get(context) => BlocProvider.of(context);

//Sign in with Google
//Sign in with Google
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  google(BuildContext context) async {
    emit(LogInSignInGoogleLoadingState());
    signInWithGoogle().then((value) async {
      uid = value.user!.uid;
      CachHelper.saveData(key: "uid", value: uid);

      await saveUserInfo(
        email: value.user!.email.toString(),
        image: value.user!.photoURL.toString(),
        uid: value.user!.uid.toString(),
        name: value.user!.displayName.toString(),
        isonline: isOnline,
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeChat()),
      );

      emit(LogInSignInGoogleSuccessState());
    }).catchError((error) {
      emit(LogInSignInGoogleErrorState());
    });
  }

  FirebaseFirestore users = FirebaseFirestore.instance;
  saveUserInfo({
    required String name,
    required String image,
    required String uid,
    required String email,
    required bool isonline,
  }) async {
    emit(LogInSaveDataUserLoadedState());
    LoginModel loginModel = LoginModel(
        name: name, email: email, image: image, uid: uid, isonline: isonline);
    users.collection("users").doc(uid).set(loginModel.toMap()).then((value) {
      emit(LogInSaveDataUserSuccessState());
    }).catchError((error) {
      emit(LogInSaveDataUserErrorState());
    });
  }
}
