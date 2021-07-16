part of 'calendarmedico_bloc.dart';


class CalendarmedicoState
{
  final int month;
  final int day;
  final int year;
  final List<int> idHoras;

  CalendarmedicoState({
    this.month  = 0, 
    this.day    = 0, 
    this.year   = 0, 
    this.idHoras = const []
  });

  CalendarmedicoState copyWith({ int month, int day, int year, List<int> idHoras})
    => CalendarmedicoState(
      month: month ?? this.month,
      day: day ?? this.day,
      year: year ?? this.year,
      idHoras: idHoras ?? this.idHoras
    );
}

