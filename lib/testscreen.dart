import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FlatButton(onPressed:(){
        FirebaseFirestore.instance.
        collection('chats/CMOvmLn4Pj8PNN3LNWBi/messages').
        snapshots().listen((event) {
          event.docs.forEach((element) {
            print(element['text']);
          });
        });
      } ,child:Text("get") ,),
    );
  }
}
