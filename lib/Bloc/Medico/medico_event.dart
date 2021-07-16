part of 'medico_bloc.dart';

abstract class MedicoEvent {}


class AddMedicoBlockchainEvent extends MedicoEvent {
  final String nombre;
  final String apellidos;
  final String dni;
  final String cpm;
  final String rne;
  final String decripcion;
  final String direccion;
  final String correo;
  final String contrasena;

  AddMedicoBlockchainEvent({this.nombre, this.apellidos, this.dni, this.cpm, this.rne, this.decripcion, this.direccion, this.correo, this.contrasena});
}