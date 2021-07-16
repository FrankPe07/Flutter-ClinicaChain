part of 'calendarmedico_bloc.dart';

abstract class CalendarmedicoEvent{ }

class SelectionDate extends CalendarmedicoEvent{
  final int day;
  final int month;
  final int year;

  SelectionDate({this.day, this.month, this.year });
}

class SelectedHoras extends CalendarmedicoEvent {

  final List<int> horas;

  SelectedHoras({this.horas });
}

class ClearSelectedHoras extends CalendarmedicoEvent {}

class RemoveItemIdhora extends CalendarmedicoEvent {
  final int id;

  RemoveItemIdhora({this.id});
}

class SaveCalendarMedico extends CalendarmedicoEvent{}
