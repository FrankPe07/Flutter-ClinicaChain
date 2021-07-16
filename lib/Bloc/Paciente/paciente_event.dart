part of 'paciente_bloc.dart';

abstract class PacienteEvent{}


class AgregarPacienteBlockchainEvent extends PacienteEvent {

  final String nombre;
  final String apellidos;
  final String dni;
  final String domicilio;
  final String nacimiento;
  final String sanguino;
  final String correo;
  final String contrasena;

  AgregarPacienteBlockchainEvent({this.nombre, this.apellidos, this.dni, this.domicilio, this.nacimiento, this.sanguino, this.correo, this.contrasena});

}