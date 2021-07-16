part of 'paciente_bloc.dart';

class PacienteState{

}

class LoadingPacienteState extends PacienteState {}


class SuccessPacienteState extends PacienteState {}


class FailurePacienteState extends PacienteState {
  final String error;

  FailurePacienteState({this.error});
}
