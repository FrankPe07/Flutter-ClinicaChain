import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clinicachain/Controller/DBMedico.dart';

part 'calendarmedico_event.dart';
part 'calendarmedico_state.dart';

class CalendarmedicoBloc extends Bloc<CalendarmedicoEvent, CalendarmedicoState> 
{
  CalendarmedicoBloc() : super(CalendarmedicoState());

  @override
  Stream<CalendarmedicoState> mapEventToState( CalendarmedicoEvent event ) async* {
    
      if( event is SelectionDate ){

        yield state.copyWith( day: event.day, month: event.month, year: event.year );
      
      } else if ( event is SelectedHoras ){

        yield state.copyWith( idHoras: event.horas );

      } else if ( event is ClearSelectedHoras ){

          yield state.copyWith( idHoras: [] );

      }else if( event is RemoveItemIdhora ){

          state.idHoras.remove(event.id);
          yield state.copyWith();

      }else if( event is SaveCalendarMedico ){

          await dbMedico.addCalendarioMedico( state.day.toString(), state.month.toString(), state.year.toString() , state.idHoras);
          yield state;

      }
  }
}
