import 'package:meta/meta.dart';

@immutable
abstract class ExperimentEvent {}

class ExperimentAdd extends ExperimentEvent {
  ExperimentAdd({
    @required this.inputFilePath,
    @required this.resultFilePath,
  });

  final String inputFilePath;
  final String resultFilePath;
}

class ExperimentsClear extends ExperimentEvent {}
