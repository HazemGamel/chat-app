import 'dart:io';

import 'package:chat/widgets/AuthForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool loading=false;
  void submitauth(String email,String password,String username,File image
     , bool isloding ,BuildContext ctx)async{
    final auth=FirebaseAuth.instance;
    UserCredential userresult;
    try {
      setState(() {
        loading=true;
      });
      if(isloding){
        userresult = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
        );
      }else{
        userresult = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final ref=FirebaseStorage.instance.ref().child('user_image').
        child(userresult.user.uid+'.jpg');
       await ref.putFile(image);
        final url= await ref.getDownloadURL();

       await FirebaseFirestore.instance.
        collection('users').doc(userresult.user.uid).set({
         "username":username,
         "password":password,
         "image_url":url,
       });

      }

    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message='The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message='The account already exists for that email.';
      }
      else if (e.code == 'user-not-found') {
        message='No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message='Wrong password provided for that user.';
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(content: Text(message)
        ,backgroundColor: Colors.greenAccent,));
      setState(() {
        loading=false;
      });
    } catch (e) {
//      setState(() {
//        loading=false;
//      });
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[400],
      body: AuthForm(submitauth,loading),
    );
  }
}
