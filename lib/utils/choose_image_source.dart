import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import './process_image.dart';
import '../ui/camera_widget.dart';

Future<File> openGallery() async {
  return await ImagePicker.pickImage(source: ImageSource.gallery);
}

Future<File> openCameraUI(BuildContext context) async {
  return await Navigator.push(context, MaterialPageRoute(builder: (_) {
    return CameraWidget();
  }));
}

void chooseImageSource(BuildContext context) async {
  bool useCamera = await showDialog(
    context: context,
    child: AlertDialog(
      title: Text('Choose image source'),
      actions: <Widget>[
        FlatButton(
          child: Text('Gallery'),
          onPressed: () async {
            Navigator.pop(context, false);
          },
        ),
        FlatButton(
          child: Text('Camera'),
          onPressed: () async {
            Navigator.pop(context, true);
          },
        ),
      ],
    ),
  );

  if (useCamera == null) {
    return;
  }

  File image = useCamera ? await openCameraUI(context) : await openGallery();

  processImage(context, image);
}
