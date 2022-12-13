import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {

  final Function onImagePick;

  UserImagePicker({this.onImagePick});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {

  File _pickedImage;

  void _pickImage() async {
    final pickedImageFile = await ImagePicker()
        .pickImage(
          source: ImageSource.camera,
          imageQuality: 50,
          maxWidth: 150
        );
    setState(() {
      _pickedImage = File(pickedImageFile.path);
    });
    widget.onImagePick(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            backgroundImage: _pickedImage != null ? FileImage(_pickedImage) : null,
            radius: 40,
          ),
          TextButton.icon(
            onPressed: _pickImage,
            icon: Icon(Icons.image),
            label: Text("Add Image"),
          )
        ]
    );
  }
}
