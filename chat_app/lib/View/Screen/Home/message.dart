import 'package:chat_app/Constant/const.dart';
import 'package:chat_app/View/Screen/Home/cubit/home_cubit_cubit.dart';
import 'package:chat_app/iconBroken.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Message extends StatelessWidget {
  Message({super.key, required this.model});
  var model;
  ScrollController scrollController = ScrollController();
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection("message")
      .doc(receveUid)
      .collection("chats")
      .orderBy("date")
      .snapshots();
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubitHome = HomeCubit.get(context);
        return StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(color: primaryColor),
                ),
              );
            }
            return Scaffold(
              appBar: customAppBarHome(model, context),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        controller: scrollController,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, i) {
                          if (snapshot.data!.docs[i]["uid"] == uid) {
                            return CustomLeft(model: snapshot.data!.docs[i]);
                          } else {
                            return CustomRight(model: snapshot.data!.docs[i]);
                          }
                        },
                      ),
                    ),
                    if (cubitHome.isWriteUser)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "${model["name"]} Write Now . . .",
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: CustomRowMessage(
                        messageController: messageController,
                        cubitHome: cubitHome,
                        scrollController: scrollController,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  AppBar customAppBarHome(model, context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          IconBroken.Arrow___Left_2,
          color: primaryColor,
        ),
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 18.0,
            backgroundImage: NetworkImage(model["image"]),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text(
            model["name"],
          ),
        ],
      ),
    );
  }
}

class CustomRowMessage extends StatelessWidget {
  CustomRowMessage({
    Key? key,
    required this.messageController,
    required this.cubitHome,
    required this.scrollController,
  }) : super(key: key);

  final TextEditingController messageController;
  HomeCubit cubitHome;
  ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            onChanged: (val) {
              cubitHome.isWrite(val);
            },
            controller: messageController,
            decoration: InputDecoration(
              hintText: "Message",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: primaryColor),
              ),
            ),
          ),
        ),
        MaterialButton(
          onPressed: () async {
            cubitHome.isWriteUser = false;
            if (messageController.text.isNotEmpty) {
              await cubitHome.sendMessageMe(message: messageController.text);
              await cubitHome.sendMessageYou(message: messageController.text);
              messageController.text = "";

              Future.delayed(const Duration(milliseconds: 200), () {
                scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.linear);
              });
            }
          },
          minWidth: 40,
          height: 55,
          child: Icon(
            IconBroken.Send,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}

class CustomRight extends StatelessWidget {
  CustomRight({
    Key? key,
    required this.model,
  }) : super(key: key);
  var model;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.4),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Text(model["message"]),
          ),
          Icon(
            Icons.done_all_outlined,
            size: 18,
            color: primaryColor,
          ),
        ],
      ),
    );
  }
}

class CustomLeft extends StatelessWidget {
  CustomLeft({
    Key? key,
    required this.model,
  }) : super(key: key);
  var model;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.done_all_outlined,
            size: 18,
            color: primaryColor,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Text(model["message"]),
          ),
        ],
      ),
    );
  }
}
