// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chatbubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);

  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          //print(snapshot.data!['message']);

          List<Message> messagesList = [];
          for (var doc in snapshot.data!.docs) {
            messagesList.add(Message.fromJson(doc));
          }
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Chat '),
                    Image.asset(
                      kLogo,
                      height: 40,
                      width: 60,
                    ),
                  ],
                ),
              ),
              body: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: scrollController,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        if (messagesList[index].id == email) {
                          return ChatBubble(
                            message: messagesList[index],
                          );
                        } else {
                          return ChatBubbleForFriend(
                            message: messagesList[index],
                          );
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                        controller: controller,
                        onSubmitted: (message) {
                          if (message.isNotEmpty) {
                            messages.add({
                              "message": message,
                              "createdAt": DateTime.now(),
                              "id": email,
                            });
                            controller.clear();
                            scrollController.animateTo(0,
                                duration: Duration(seconds: 1),
                                curve: Curves.fastOutSlowIn);
                          }
                        },
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              String message = controller.text;
                              if (message.isNotEmpty) {
                                messages.add({
                                  "message": message,
                                  "createdAt": DateTime.now(),
                                  "id": email,
                                });
                                controller.clear();
                                scrollController.animateTo(0,
                                    duration: Duration(seconds: 1),
                                    curve: Curves.fastOutSlowIn);
                              }
                            },
                            icon: Icon(
                              Icons.send_rounded,
                              color: kPrimaryColor,
                            ),
                          ),
                          hintText: "Send message",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ],
              ),
            );
          }
          return Text('Loading....');
        });
  }
}
