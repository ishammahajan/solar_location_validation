import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';
import 'ui/camera_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure build only runs in portrait mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkyPixel Detection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'SkyPixels!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CameraState state;
  List<CameraDescription> cameras;
  CameraController controller;

  Future<void> setupCameras() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.low);
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocProvider(
        create: (_) => ExperimentBloc(),
        child: BlocBuilder<ExperimentBloc, ExperimentState>(
          builder: (context, state) {
            return Text(state.toString());
          },
        ),
      ),
    );
  }
}
