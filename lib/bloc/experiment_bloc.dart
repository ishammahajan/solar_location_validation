import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class ExperimentBloc extends Bloc<ExperimentEvent, ExperimentState> {
  @override
  ExperimentState get initialState => InitialExperimentState();

  @override
  Stream<ExperimentState> mapEventToState(
    ExperimentEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
