import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget{
  @override
  _ProfileState createState() => _ProfileState();
}
class _ProfileState extends State<Profile>{
  File? _image;
  final picker = ImagePicker();

  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  //Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  //Show options to get image from camera or gallery
  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contoh Image Picker'),
      ),
      body: Column(
        children: [
          TextButton(onPressed: showOptions, child: const Text('Select Image')),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: _image == null
                  ? Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFe0f2f1)
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.camera),
                    Text("Tidak Ada Gambar")
                  ],
                ),
              )
                  : kIsWeb
                  ? Image.network(
                _image!.path,
                fit: BoxFit.fill,
                width: 200,
                height: 200,
              )
                  : Image.file(
                _image!,
                fit: BoxFit.fill,
                width: 200,
                height: 200,
              ),

            ),
          )
        ],
      ),
    );
  }
  
}