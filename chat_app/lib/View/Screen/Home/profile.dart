import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/View/Screen/Home/cubit/home_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Constant/const.dart';
import '../../../iconBroken.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubitProgile = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                IconBroken.Arrow___Left_2,
                color: primaryColor,
              ),
            ),
            title: Text(cubitProgile.userInfo!.name),
          ),
          body: Column(
            children: [
              CachedNetworkImage(
                imageUrl: cubitProgile.userInfo!.image,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(color: primaryColor),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                color: Colors.grey[200],
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Email",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          cubitProgile.userInfo!.email,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
