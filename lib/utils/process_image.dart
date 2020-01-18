import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../api/dummy.dart';

void processImage(BuildContext context, File image) async {
  showDialog(
    context: context,
    child: AlertDialog(
      title: Text('Analysing, please wait...'),
      actions: <Widget>[
        FlatButton(
          child: Text('Background'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
    barrierDismissible: false,
  );

  File result = await apiProcess(image);

  if (Navigator.canPop(context)) {
    Navigator.pop(context);
  }

  BlocProvider.of<ExperimentBloc>(context).add(
    ExperimentAdd(
      inputFilePath: image.path,
      resultFilePath: result.path,
    ),
  );
}
