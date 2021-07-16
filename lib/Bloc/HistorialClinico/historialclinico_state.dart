part of 'historialclinico_bloc.dart';

class HistorialclinicoState
{
  final String idPaciente;
  final String idCita;
  final String motivoConsulta;
  // Datos clinicos a Blockchain
  final String anamnesis;
  final String vitales;
  final String pa;
  final String pulso;
  final String temperatura;
  final String fc;
  final String fr;
  final String examenClinico;
  final String diagnostico;
  final String tratamiento;
  final String fecha;
  final String proximaCita;

  HistorialclinicoState({
    this.idPaciente     = '0',
    this.idCita         = '0',
    this.motivoConsulta = '0', 
    this.anamnesis      = '0', 
    this.vitales        = '0', 
    this.pa             = '0', 
    this.pulso          = '0', 
    this.temperatura    = '0', 
    this.fc             = '0', 
    this.fr             = '0', 
    this.examenClinico  = '0', 
    this.diagnostico    = '0', 
    this.tratamiento    = '0', 
    this.fecha          = '0',
    this.proximaCita    = '0'
  });

  HistorialclinicoState copyWith({ 
    String idPaciente,
    String idCita,
    String motivoConsulta,
    String anamnesis,
    String vitales,
    String pa,
    String pulso,
    String temperatura,
    String fc,
    String fr,
    String examenClinico,
    String diagnostico,
    String tratamiento,
    String fecha,
    String proximaCita
   }) => HistorialclinicoState(
      idPaciente: idPaciente ?? this.idPaciente,
      idCita: idCita  ?? this.idCita,
      motivoConsulta: motivoConsulta ?? this.motivoConsulta,
      anamnesis: anamnesis ?? this.anamnesis,
      vitales: vitales ?? this.vitales,
      pa: pa ?? this.pa,
      pulso: pulso ?? this.pulso,
      temperatura: temperatura ?? this.temperatura,
      fc: fc ?? this.fc,
      fr: fr ?? this.fr,
      examenClinico: examenClinico ?? this.examenClinico,
      diagnostico: diagnostico ?? this.diagnostico,
      tratamiento: tratamiento ?? this.tratamiento,
      fecha: fecha ?? this.fecha,
      proximaCita: proximaCita ?? this.proximaCita
   );

}

class SuccessHistorialState extends HistorialclinicoState {}

class LoadingHistorialState extends HistorialclinicoState {}

class SaveHistorialClinicoState extends HistorialclinicoState {}

class FailureHistorialState extends HistorialclinicoState {
  final String error;

  FailureHistorialState({this.error});
} 

