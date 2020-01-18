import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../utils/choose_image_source.dart';
import '../models/experiment.dart';
import '../ui/experiment_detail.dart';

class ExperimentList extends StatefulWidget {
  ExperimentList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ExperimentListState createState() => _ExperimentListState();
}

class _ExperimentListState extends State<ExperimentList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          FlatButton.icon(
            label: Text(
              'New Experiment',
              style: TextStyle(color: Colors.white54),
            ),
            icon: Icon(Icons.delete_sweep, color: Colors.white54),
            onPressed: () {
              BlocProvider.of<ExperimentBloc>(context).add(ExperimentsClear());
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        onPressed: () {
          chooseImageSource(context);
        },
      ),
      body: BlocBuilder<ExperimentBloc, ExperimentState>(
        builder: (context, state) {
          if (state is InitialExperimentState) {
            return Center(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Please take a photo for analysis'),
            ));
          }

          List<Experiment> experiments = state.experiments.reversed.toList();
          return ListView.builder(
            itemCount: experiments.length,
            itemBuilder: (_, index) {
              return GestureDetector(
                child: Card(
                  child: Image.file(File(experiments[index].inputFilePath)),
                  margin: EdgeInsets.all(10.0),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return ExperimentDetail(
                      title: (experiments.length - index).toString(),
                      experiment: experiments[index],
                    );
                  }));
                },
              );
            },
          );
        },
      ),
    );
  }
}
