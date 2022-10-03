import 'package:chat_app/Constant/chachHelper.dart';
import 'package:flutter/material.dart';

String uid = CachHelper.sharedPreferences.get("uid") != null
    ? CachHelper.sharedPreferences.get("uid").toString()
    : "";
var primaryColor = const Color(0xff6C63FF);
String receveUid = "";
String token = "";
bool isOnline = false;

var connectivityResult;
