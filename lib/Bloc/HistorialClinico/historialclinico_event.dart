part of 'historialclinico_bloc.dart';

abstract class HistorialclinicoEvent {}

class SelectionPaciente extends HistorialclinicoEvent {
  final String idPaciente;
  final String idCita;
  final String movitoConsulta;

  SelectionPaciente({this.idPaciente, this.idCita, this.movitoConsulta});
}

class SaveHistorialClinicoEvent extends HistorialclinicoEvent {
  final String fecha;
  final String anamnesis;
  final String pa;
  final String pulso;
  final String temperatura;
  final String fc;
  final String fr;
  final String examenClinico;
  final String diagnostico;
  final String tratamiento;
  final String proximaCita;
  final String dni;

  SaveHistorialClinicoEvent({
    this.anamnesis,
    this.pa, 
    this.pulso, 
    this.temperatura, 
    this.fc, 
    this.fr, 
    this.examenClinico, 
    this.diagnostico, 
    this.tratamiento, 
    this.fecha,
    this.proximaCita,
    this.dni
  });
}