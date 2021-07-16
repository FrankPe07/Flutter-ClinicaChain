part of 'citapaciente_bloc.dart';

abstract class CitapacienteEvent{

  const CitapacienteEvent();

}

class SeleccionarEspecialidad extends CitapacienteEvent {
  final String idEspecialidad;
  final String nombreEspecialidad;

  SeleccionarEspecialidad({this.idEspecialidad, this.nombreEspecialidad });
}

class SelectedMedicoEspecialista extends CitapacienteEvent{

  final String idMedico;
  final String nombreMedico;
  final String lastNameMedico;
  final String direccionEspecialista;

  SelectedMedicoEspecialista({this.idMedico, this.nombreMedico, this.lastNameMedico, this.direccionEspecialista });
}

class SelectedPaciente extends CitapacienteEvent{
  
  final String idPaciente;
  final String nombrePaciente;
  final String parentesco;

  SelectedPaciente({this.idPaciente, this.nombrePaciente, this.parentesco});

}

class SelectionFecha extends CitapacienteEvent{
  final String day;
  final String month;
  final String year;

  SelectionFecha({this.day, this.month, this.year});
}

class SelectionHora extends CitapacienteEvent {
  final String idHora;
  final String hora;
  final String descripcion;

  SelectionHora({this.idHora, this.hora, this.descripcion });
}

class ConfirmarCitaPaciente extends CitapacienteEvent {
  final String idEspecialista;
  final String idPaciente;
  final String idHora;
  final String idEspecilidad;
  final String descripcion;

  ConfirmarCitaPaciente({this.idEspecialista, this.idPaciente, this.idHora, this.idEspecilidad, this.descripcion});
}

