import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';
import '../models/experiment.dart';

class ExperimentBloc extends Bloc<ExperimentEvent, ExperimentState> {
  @override
  ExperimentState get initialState => InitialExperimentState();

  @override
  Stream<ExperimentState> mapEventToState(
    ExperimentEvent event,
  ) async* {
    if (event is ExperimentAdd) {
      List<Experiment> experiments = state.experiments;

      experiments.add(Experiment(
        inputFilePath: event.inputFilePath,
        resultFilePath: event.resultFilePath,
      ));
      yield UpdatedExperimentState(experiments: experiments);
    }

    if (event is ExperimentsClear) {
      yield UpdatedExperimentState(experiments: []);
    }
  }
}
