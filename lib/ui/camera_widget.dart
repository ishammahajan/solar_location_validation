import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

enum CameraState { mounting, mounted, failure }

class CameraWidget extends StatefulWidget {
  CameraWidget({@required this.state, this.controller});

  final CameraState state;
  final CameraController controller;

  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  @override
  void initState() {
    super.initState();

    if (widget.state == CameraState.mounted) {
      assert(widget.controller != null);
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.state) {
      case CameraState.mounting:
        return Center(child: CircularProgressIndicator());
        break;
      case CameraState.mounted:
        return AspectRatio(
          aspectRatio: widget.controller.value.aspectRatio,
          child: CameraPreview(widget.controller),
        );
      case CameraState.failure:
        return Center(
          child: Text('Coudn\'t mount camera. Please contact the developer.'),
        );
      default:
        return Container();
    }
  }
}
