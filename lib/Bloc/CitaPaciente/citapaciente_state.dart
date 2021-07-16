part of 'citapaciente_bloc.dart';

class CitapacienteState{

  final String idEspecialidad;
  final String especialidad;
  final String idEspecialista;
  final String nombreEspecialista;
  final String apellidosEspecialista;
  final String idPacienteAtender;
  final String parentescoPaciente;
  final String nombrePaciente;
  final String mes;
  final String day;
  final String year;
  final String idHora;
  final String hora;
  final String descriptionCita;
  final String direccionEspecialista;


  const CitapacienteState({
    this.idEspecialidad     = '0',
    this.especialidad       = '...',
    this.idEspecialista     = '0',
    this.nombreEspecialista = '...',
    this.apellidosEspecialista = '...',
    this.idPacienteAtender  = '0',
    this.parentescoPaciente = '...',
    this.nombrePaciente     = '...',
    this.mes  = '00',
    this.day  = '00',
    this.year = '2021',
    this.idHora = '65',
    this.hora = '01:00',
    this.descriptionCita = 'Cita Pendiente',
    this.direccionEspecialista = 'direccion',
  });


  CitapacienteState copyWith({
    String idEspecialidad,
    String especialidad,
    String idEspecialista,
    String nombreEspecialista,
    String apellidosEspecialista,
    String idPacienteAtender,
    String parentescoPaciente,
    String nombrePaciente,
    String mes,
    String day,
    String year,
    String idHora,
    String hora,
    String descriptionCita,
    String direccionEspecialista
  }) => CitapacienteState(
    idEspecialidad    : idEspecialidad  ?? this.idEspecialidad,
    especialidad      : especialidad    ?? this.especialidad,
    idEspecialista    : idEspecialista  ?? this.idEspecialista,
    nombreEspecialista: nombreEspecialista ?? this.nombreEspecialista,
    apellidosEspecialista: apellidosEspecialista ?? this.apellidosEspecialista,
    idPacienteAtender : idPacienteAtender   ?? this.idPacienteAtender,
    parentescoPaciente: parentescoPaciente  ?? this.parentescoPaciente,
    nombrePaciente    : nombrePaciente      ?? this.nombrePaciente,
    mes   : mes  ?? this.mes,
    day   : day  ?? this.day,
    year  : year ?? this.year,
    idHora  : idHora ?? this.idHora,
    hora  : hora ?? this.hora,
    descriptionCita: descriptionCita ?? this.descriptionCita,
    direccionEspecialista: direccionEspecialista ?? this.direccionEspecialista
  );
  
}

class LoadingCitaPaciente extends CitapacienteState {}

class SuccessCitaPaciente extends CitapacienteState {}

class FailureCitaPacienteState extends CitapacienteState {
  final String error;

  FailureCitaPacienteState({this.error});
}