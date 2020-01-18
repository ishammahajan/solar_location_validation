import 'dart:io';

import 'package:flutter/material.dart';

import '../models/experiment.dart';

class ExperimentDetail extends StatefulWidget {
  ExperimentDetail({@required this.title, @required this.experiment});

  final String title;
  final Experiment experiment;

  @override
  _ExperimentDetailState createState() => _ExperimentDetailState();
}

class _ExperimentDetailState extends State<ExperimentDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details - ${widget.title}'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.file(File(widget.experiment.inputFilePath)),
          ),
          Icon(Icons.arrow_downward),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.file(File(widget.experiment.resultFilePath)),
          ),
        ],
      ),
    );
  }
}
