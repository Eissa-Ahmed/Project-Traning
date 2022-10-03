import 'package:chat_app/Constant/const.dart';
import 'package:chat_app/View/Screen/Home/homeChat.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'cubit/log_in_cubit.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogInCubit, LogInState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubitLogin = LogInCubit.get(context);
        return Scaffold(
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/image/login.svg",
                  width: double.infinity,
                  height: 200,
                ),
                const SizedBox(
                  height: 50,
                ),
                ConditionalBuilder(
                  condition: state is! LogInSignInGoogleLoadingState ||
                      state is! LogInSaveDataUserLoadedState,
                  builder: (context) {
                    return CustomSignInGoogle(
                      cubitLogin: cubitLogin,
                    );
                  },
                  fallback: (context) {
                    return const CustomSignInGoogleLoading();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomSignInGoogleLoading extends StatelessWidget {
  const CustomSignInGoogleLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: CircularProgressIndicator(
          color: primaryColor,
        ),
      ),
    );
  }
}

class CustomSignInGoogle extends StatelessWidget {
  CustomSignInGoogle({
    Key? key,
    required this.cubitLogin,
  }) : super(key: key);
  LogInCubit cubitLogin;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await cubitLogin.google(context);
      },
      child: Container(
        width: double.infinity,
        height: 55,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/image/google.png",
              width: 40,
              height: 40,
            ),
            const Text(
              "Sign in With Google",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
