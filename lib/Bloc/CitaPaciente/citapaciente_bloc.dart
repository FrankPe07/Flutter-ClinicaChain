import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clinicachain/Controller/DBPaciente.dart';

part 'citapaciente_event.dart';
part 'citapaciente_state.dart';

class CitapacienteBloc extends Bloc<CitapacienteEvent, CitapacienteState> 
{

  CitapacienteBloc() : super(CitapacienteState());

  @override
  Stream<CitapacienteState> mapEventToState( CitapacienteEvent event ) async* {
    
    if( event is SeleccionarEspecialidad ){

        yield state.copyWith(
          idEspecialidad: event.idEspecialidad,
          especialidad: event.nombreEspecialidad
        );
    
    }else if( event is SelectedMedicoEspecialista ){

        yield state.copyWith(
          idEspecialista: event.idMedico,
          nombreEspecialista: event.nombreMedico,
          apellidosEspecialista: event.lastNameMedico,
          direccionEspecialista: event.direccionEspecialista
        );

    } else if( event is SelectedPaciente ){

        yield state.copyWith(
          idPacienteAtender: event.idPaciente,
          nombrePaciente: event.nombrePaciente,
          parentescoPaciente: event.parentesco
        );
    
    } else if( event is SelectionFecha ){

        yield state.copyWith(
          day: event.day,
          mes: event.month,
          year: event.year
        );
    
    } else if( event is SelectionHora ){

        yield state.copyWith(
          idHora: event.idHora,
          hora: event.hora,
          descriptionCita: event.descripcion
        );
    
    } else if ( event is ConfirmarCitaPaciente ){

        try {

          yield LoadingCitaPaciente();

          await Future.delayed(Duration(seconds: 2));
          
          final resp = await dbPaciente.createCitaMedicaPaciente( 
            idMedico: event.idEspecialista,
            idPaciente: event.idPaciente,
            idHora: event.idHora,
            idEspecialidad: event.idEspecilidad,
            descripcion: event.descripcion
          );

          if( resp ){
            yield SuccessCitaPaciente();
          } 


        } catch (e) {
          yield FailureCitaPacienteState(error: e.toString());
          print(e.toString());
        } 
    }

  }
}
