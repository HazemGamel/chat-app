import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'addimage.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email,
      String password,String username,File image,bool isloding ,BuildContext ctx) sumfun;
  final bool loding;

   AuthForm( this.sumfun,this.loding);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final formkey=GlobalKey<FormState>();
  String _email="";
  String _username="";
  String _password="";
  bool _islogin =true;
  File imagefile;

  void _image(File pickimage){
    imagefile=pickimage;
  }

  void submit(){
    final valid=formkey.currentState.validate();
    FocusScope.of(context).unfocus();
     if(!_islogin && imagefile==null){
       Scaffold.of(context).showSnackBar(SnackBar(content: Text("Please select image")
         ,backgroundColor: Colors.greenAccent,));
       return;
     }
    if(valid){
      formkey.currentState.save();
      widget.sumfun(_email.trim(),_password.trim(),_username.trim(),imagefile,_islogin,context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if(!_islogin)UserImage(_image),
                 TextFormField(
                   key: ValueKey("email"),
                   validator: (val){
                     if(val.isEmpty || !val.contains("@")){
                       return "please enter your email";
                     }
                     return null;
                   },
                   onSaved: (val)=>_email=val,
                   decoration: InputDecoration(
                     labelText: "Email",
                   ),
                 ),
                 if(!_islogin)
                 TextFormField(
                   key: ValueKey("username"),
                   validator: (val){
                     if(val.isEmpty || val.length<2){
                       return "please enter your name";
                     }
                     return null;
                   },
                   onSaved: (val)=>_username=val,
                   decoration: InputDecoration(
                     labelText: "UserName",
                   ),
                 ),
                 TextFormField(
                   key: ValueKey("password"),
                   validator: (val){
                     if(val.isEmpty || val.length<7){
                       return "please enter valide password";
                     }
                     return null;
                   },
                   onSaved: (val)=>_password=val,
                   obscureText: true,
                   decoration: InputDecoration(
                     labelText: "Password",
                   ),
                 ),
                if(_islogin)
                  FlatButton(onPressed: (){},
                      child:Text("Forget Password ?")),
                SizedBox(height: 10,),
                if(widget.loding)
                  CircularProgressIndicator(),
                if(!widget.loding)
                RaisedButton(onPressed: (){
                 submit();
                },
                child: Text(_islogin?"login":"Sign Up"),),
                if(!widget.loding)
                SizedBox(height: 10),
                FlatButton(
                  textColor: Theme.of(context).backgroundColor,
                    onPressed: (){
                    setState(() {
                      _islogin = !_islogin;
                    });
                    },
                    child: Text(_islogin?"create new account":"I already have account"))
              ],

            ),
          ),
        ),
      ),
    );
  }
}
