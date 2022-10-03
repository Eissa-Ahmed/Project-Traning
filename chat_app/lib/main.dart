import 'package:bloc/bloc.dart';
import 'package:chat_app/Constant/chachHelper.dart';
import 'package:chat_app/View/Screen/Home/cubit/home_cubit_cubit.dart';
import 'package:chat_app/View/Screen/Home/homeChat.dart';
import 'package:chat_app/View/Screen/User/Login/cubit/log_in_cubit.dart';
import 'package:chat_app/View/Screen/User/Login/login.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Constant/const.dart';
import 'Constant/theme.dart';
import 'Constant/track.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CachHelper.init();
  // var connect = Connectivity().onConnectivityChanged;
  connectivityResult = await (Connectivity().checkConnectivity());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LogInCubit()),
        BlocProvider(
          create: (context) => HomeCubit()
            ..getDataUser()
            ..getTokenUser()
            ..statusUser(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: connectivityResult == ConnectivityResult.wifi
            ? StreamBuilder<ConnectivityResult>(
                stream: Connectivity().onConnectivityChanged,
                builder: (context, snapshot) {
                  return snapshot.data == ConnectivityResult.none
                      ? Scaffold(
                          body: Center(
                            child: Image.asset("assets/image/nointernet.png"),
                          ),
                        )
                      : CachHelper.sharedPreferences.get("uid") != null
                          ? HomeChat()
                          : LogIn();
                })
            : Scaffold(
                body: Center(
                  child: Image.asset("assets/image/nointernet.png"),
                ),
              ),
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
      ),
    );
  }
}
