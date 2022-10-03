import 'package:chat_app/Constant/const.dart';
import 'package:chat_app/View/Screen/Home/cubit/home_cubit_cubit.dart';
import 'package:chat_app/View/Screen/Home/message.dart';
import 'package:chat_app/View/Screen/Home/profile.dart';
import 'package:chat_app/iconBroken.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeChat extends StatelessWidget {
  HomeChat({super.key});
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .where("uid", isNotEqualTo: uid)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubitHome = HomeCubit.get(context);
        return ConditionalBuilder(
          condition: cubitHome.userInfo != null,
          builder: (context) {
            return StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Scaffold(
                    body: Center(child: Text("Has Error ?")),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                    body: Center(
                        child: CircularProgressIndicator(color: primaryColor)),
                  );
                }
                return Scaffold(
                  appBar: customAppBarHome(cubitHome, context),
                  body: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView.separated(
                        itemBuilder: (context, i) {
                          return ItemChat(model: snapshot.data!.docs[i]);
                        },
                        separatorBuilder: (context, i) {
                          return const Divider(
                            color: Colors.white,
                          );
                        },
                        itemCount: snapshot.data!.docs.length,
                      )),
                );
              },
            );
          },
          fallback: (context) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              ),
            );
          },
        );
      },
    );
  }

  AppBar customAppBarHome(HomeCubit cubitHome, BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () async {
            await cubitHome.signOut(context);
          },
          icon: Icon(
            IconBroken.Logout,
            color: primaryColor,
          ),
        ),
      ],
      title: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => Profile(),
            ),
          );
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 18.0,
              backgroundImage: NetworkImage(cubitHome.userInfo!.image),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              cubitHome.userInfo!.name,
            ),
          ],
        ),
      ),
    );
  }
}

class ItemChat extends StatelessWidget {
  ItemChat({Key? key, required this.model}) : super(key: key);
  var model;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      margin: const EdgeInsets.symmetric(vertical: 10),
      shadowColor: Colors.grey[300],
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 15.0,
              backgroundImage: NetworkImage(
                model["image"],
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model["name"],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      model["isonline"]
                          ? const Text(
                              "Online",
                              style: TextStyle(fontSize: 10),
                            )
                          : const Text(
                              "Offline",
                              style: TextStyle(fontSize: 10),
                            ),
                      const SizedBox(
                        width: 5,
                      ),
                      model["isonline"]
                          ? const CircleAvatar(
                              radius: 4,
                              backgroundColor: Colors.green,
                            )
                          : const CircleAvatar(
                              radius: 4,
                              backgroundColor: Colors.grey,
                            )
                    ],
                  ),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () {
                receveUid = model["uid"];
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => Message(model: model),
                  ),
                );
              },
              child: Text(
                "Message",
                style: TextStyle(color: primaryColor),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            const CircleAvatar(
              radius: 10,
              backgroundColor: Colors.red,
              child: Text(
                "3",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
