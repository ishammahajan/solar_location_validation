import 'package:meta/meta.dart';

class Experiment {
  Experiment({@required this.inputFilePath, this.resultFilePath});

  final String inputFilePath;
  final String resultFilePath;

  @override
  String toString() {
    return '${this.inputFilePath}|${this.resultFilePath}';
  }

  Experiment fromString(String s) {
    List<String> split = s.split('|');
    return Experiment(inputFilePath: split[0], resultFilePath: split[1]);
  }
}
