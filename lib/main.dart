import 'package:chat/testscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Screens/AuthSceen.dart';
import 'Screens/ChatScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Chat',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        primaryColor: Colors.pink[400],
        backgroundColor: Colors.pink,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.green[400],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )
        ),

      ),
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          return ChatScreen();
        }else {
          return AuthScreen();
        }
      },
      ),
    );
  }
}

