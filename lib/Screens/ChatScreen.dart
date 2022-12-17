import 'dart:io';

import 'package:chat/widgets/Newmessage.dart';
import 'package:chat/widgets/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  File sendingimage;
  void _sendimage(File image){
    sendingimage=image;
  }
  ChatScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Group"),
        actions: [
          Icon(Icons.call,color: Colors.green,),
          SizedBox(width: 40,),
          Icon(Icons.video_call_outlined,color: Colors.green,),
          DropdownButton(
            underline: Container(),
            icon: Icon(Icons.more_vert,color: Colors.white,),
              items: [
            DropdownMenuItem(child:
            Row(children: [
              Icon(Icons.logout,color: Colors.pink,),
              Text("logout"),
            ],
            ),value:"Logout" ,),
               ],
              onChanged:(itemIdentifier){
              if(itemIdentifier=='Logout'){
                FirebaseAuth.instance.signOut();
              }
              }),
        ],
      ),
      body:Container(
        child:Column(
          children: [
            Expanded(child: Message()),
            NewMessage(),
          ],
        ) ,
      )
    );
  }
}
