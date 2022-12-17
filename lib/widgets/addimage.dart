import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImage extends StatefulWidget {
  final void Function(File pickimage) imagefun;
   UserImage( this.imagefun);
  @override
  _UserImageState createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
File _fileImage;
final ImagePicker picker=ImagePicker();

void addimage(ImageSource source)async{
  final fileimagepicker= await picker.getImage(source: source);
  if(fileimagepicker!= null){
    setState(() {
      _fileImage=File(fileimagepicker.path);
    });
    widget.imagefun(_fileImage);
  }else{
    print("NO image select");
  }
}
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _fileImage != null?FileImage(_fileImage):null,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FlatButton.icon(onPressed: (){
              addimage(ImageSource.camera);
            },
                icon: Icon(Icons.camera_alt,color: Colors.blue,), label: Text("Add Image \n From camera")),
            FlatButton.icon(onPressed: (){
              addimage(ImageSource.gallery);
            },
                icon: Icon(Icons.camera_alt_outlined,color: Colors.blue,),
                label: Text("Add Image\nFrom Gallary")),

          ],
        ),
      ],
    );
  }
}
