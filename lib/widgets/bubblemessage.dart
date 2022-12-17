import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BubbleMessage extends StatelessWidget {
  final Key keyy;
  final String message;
  final String username;
  final Timestamp time;
  final String image;
  final bool isme;

   BubbleMessage( this.keyy,
      this.message, this.username, this.time,this.image, this.isme);
  String formatda(timestamp){
    var defuldate=
    DateTime.fromMillisecondsSinceEpoch(timestamp.seconds*1000);
    return DateFormat('dd-MM-yyyy hh:mm a').format(defuldate);
  }
  @override
  Widget build(BuildContext context) {
    return  Column(
        crossAxisAlignment: isme?CrossAxisAlignment.start:CrossAxisAlignment.end,
        children:[
          Stack(
            children:[
              Row(
                mainAxisAlignment: isme?MainAxisAlignment.start:MainAxisAlignment.end,
                children: [
                  Container(
                    width: 170,
                    padding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                    margin: EdgeInsets.symmetric(vertical: 10,horizontal: 8),
                    decoration: BoxDecoration(
                        color: isme?Colors.grey[400]:Colors.deepPurple[300],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: isme?Radius.circular(0):Radius.circular(15),
                          bottomRight: isme?Radius.circular(20):Radius.circular(15),
                        )
                    ),
                    child:
                    Column(
                        crossAxisAlignment: isme?CrossAxisAlignment.start:CrossAxisAlignment.end,
                        children: [
                          Text(username,style:
                          TextStyle(color: isme?Colors.black:Colors.white),),
                          Text(message,style:
                          TextStyle(color: isme?Colors.black:Colors.white)),
                        ]
                    ),
                  ),
                ],
              ),
              Positioned(
                top: -8,
                  left: isme?145:null,
                  right: !isme?145:null,
                  child: CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(image),
                  )),

    ],
            overflow: Overflow.visible,
          ),
          Text(formatda(time)),
          ]

    );
  }
}
