part of 'auth_bloc.dart';

@immutable
class AuthState {

  final AuthModels authModels;
  final String nombreStorage;
  final String lastnameStorage;
  final String emailStorage;
  final String idrolStorage;
  final String idPersonaStora;
  final String dni;

  const AuthState({
    this.authModels,
    this.nombreStorage = '..', 
    this.lastnameStorage = '..', 
    this.emailStorage = '..', 
    this.idrolStorage = '0', 
    this.idPersonaStora = '0',
    this.dni = '---'
  });

  factory AuthState.initial() => AuthState();

  AuthState copyWith({ AuthModels models, String nombreStorage, String lastnameStorage, String emailStorage, String idrolStorage, String idPersonaStora, String dni })
    => AuthState(
      authModels: models ?? this.authModels,
      nombreStorage: nombreStorage ?? this.nombreStorage,
      lastnameStorage: lastnameStorage ?? this.lastnameStorage,
      emailStorage: emailStorage ?? this.emailStorage,
      idrolStorage: idrolStorage ?? this.idrolStorage,
      idPersonaStora: idPersonaStora ?? this.idPersonaStora,
      dni: dni ?? this.dni
    );
}

class LoggedInState extends AuthState {}

class LoggedOutState extends AuthState {}

class LoadingState extends AuthState {}

class FailureState extends AuthState {
  final String error;

  FailureState({ @required this.error});
}

