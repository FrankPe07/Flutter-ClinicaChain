part of 'medico_bloc.dart';

class MedicoState{


  
}

class LoadingMedicoState extends MedicoState {}

class SuccessMedicoState extends MedicoState {}

class FailureMedicoState extends MedicoState {
  final String error;

  FailureMedicoState({this.error});
}


