import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:sensors/sensors.dart';
import 'package:path_provider/path_provider.dart';

enum CameraState { mounting, mounted, failure }

class CameraWidget extends StatefulWidget {
  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  bool captured = false;
  CameraState state;
  List<CameraDescription> cameras;
  CameraController controller;

  double value = 0;

  Future<void> setupCameras() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.high);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        state = controller.value.isInitialized
            ? CameraState.mounted
            : CameraState.failure;
      });
    });
  }

  Future future;
  void setValue(double value) {
    this.value = value;

    if (value > 178.0) {
      capturePhoto();
    } else {
      cancelCapturePhoto();
    }

    if (future == null) {
      future = Future.delayed(Duration(milliseconds: 200)).then((_) {
        future = null;
        if (mounted) setState(() {});
      });
    }
  }

  Timer timer;
  void capturePhoto() {
    if (timer != null) return;

    timer = Timer(Duration(milliseconds: 200), () async {
      if (!captured) {
        String path = (await getApplicationDocumentsDirectory()).path;
        path = '$path/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
        if (!controller.value.isTakingPicture)
          await controller.takePicture(
            path,
          );
        captured = true;

        Navigator.pop(context, File(path));
      }
    });
  }

  void cancelCapturePhoto() {
    timer?.cancel();
    timer = null;
  }

  @override
  void initState() {
    super.initState();

    // Setup and display Camera
    state = CameraState.mounting;
    setupCameras();
  }

  @override
  void dispose() {
    controller?.dispose();
    accelerometerEvents.drain();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget cameraWidget;
    switch (state) {
      case CameraState.mounting:
        cameraWidget = Center(child: CircularProgressIndicator());
        break;
      case CameraState.mounted:
        accelerometerEvents.listen((data) {
          double toRound = data.x / sqrt(pow(data.x, 2) + pow(data.z, 2));
          setValue(acos(toRound > 0 ? min(toRound, 1) : max(toRound, -1)) *
              180 /
              pi);
        }, cancelOnError: true);
        cameraWidget = AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: CameraPreview(controller),
        );
        break;
      case CameraState.failure:
        cameraWidget = Center(
          child: Text('Coudn\'t mount camera. Please contact the developer.'),
        );
        break;
      default:
        return Container();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Camera'),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            cameraWidget,
            RotatedBox(
              quarterTurns: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${value.toString()} - Vertical Angle',
                  textScaleFactor: 1.4,
                  style: TextStyle(
                      color: Color.fromARGB(
                          255, 180 - value.round() + 100, value.round(), 0)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
