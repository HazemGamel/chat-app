import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class NewMessage extends StatefulWidget {

  @override
  _NewMessageState createState() => _NewMessageState();
}
class _NewMessageState extends State<NewMessage> {
  final _control=TextEditingController();
  String _message="";
  //logic send image




  //logic send message
  _sendmessage()async{
    FocusScope.of(context).unfocus();
    //logic
    final auth=FirebaseAuth.instance.currentUser;
    final user= await FirebaseFirestore.instance.collection("users")
        .doc(auth.uid).get();

    FirebaseFirestore.instance.
    collection('chat').add({
      "text":_message,
      "createdAt":Timestamp.now(),
      "username":user['username'],
       "userId":auth.uid,
      "image_url":user["image_url"],

    });
    _control.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          IconButton(onPressed: (){
          }, icon: Icon(Icons.camera_alt,color: Colors.blue,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.mic,color: Colors.green,)),
          Expanded(child: TextFormField(
            controller: _control,
            onChanged: (val){
              setState(() {
                _message = val;
              });
            },
            decoration: InputDecoration(
              labelText: "Send Your message...",
            ),
          )),
        IconButton(
             color: Colors.pink,
             onPressed:_message.trim().isEmpty ?null:_sendmessage,
             icon:Icon(Icons.send)),

        ],

      ),

    );
  }
}
