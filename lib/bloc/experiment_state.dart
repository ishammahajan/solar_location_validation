import 'package:meta/meta.dart';
import 'package:solar_location_validation/models/experiment.dart';

@immutable
abstract class ExperimentState {
  ExperimentState({@required this.experiments});
  final List<Experiment> experiments;
}

class InitialExperimentState extends ExperimentState {
  final List<Experiment> experiments = [];
}
