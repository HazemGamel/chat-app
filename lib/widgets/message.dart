import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'bubblemessage.dart';

class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.
      collection('chat').orderBy("createdAt",descending: true).
      snapshots(),
      builder: (context,snapshot){
        if(snapshot.connectionState== ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        final auth=FirebaseAuth.instance.currentUser;
        final doc =snapshot.data.docs;
        return ListView.builder(
          reverse: true,
            itemCount:doc==null ?CircularProgressIndicator():doc.length,
            itemBuilder: (context,index){
              return BubbleMessage(
                ValueKey(doc[index].documentID),
                doc[index]["text"],
                doc[index]["username"],
                doc[index]["createdAt"],
                doc[index]["image_url"],
                doc[index]["userId"]==auth.uid,
                );
            });

      },
    );
  }

}
