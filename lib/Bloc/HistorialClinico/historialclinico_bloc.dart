import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clinicachain/Controller/DBMedico.dart';

part 'historialclinico_event.dart';
part 'historialclinico_state.dart';

class HistorialclinicoBloc extends Bloc<HistorialclinicoEvent, HistorialclinicoState> 
{
  HistorialclinicoBloc() : super(HistorialclinicoState());

  @override
  Stream<HistorialclinicoState> mapEventToState( HistorialclinicoEvent event ) async* {


    if( event is SelectionPaciente ){

        yield state.copyWith(
          idCita: event.idCita,
          idPaciente: event.idPaciente,
          motivoConsulta: event.movitoConsulta
        );
    
    }else if( event is SaveHistorialClinicoEvent ){

      try {

        final motivo = state.motivoConsulta;
        final idCita = state.idCita;

        yield LoadingHistorialState();

        final resp = await dbMedico.addHistorialClinico(
          event.fecha,
          motivo,
          event.anamnesis,
          event.pa,
          event.pulso, 
          event.temperatura,
          event.fc,
          event.fr, 
          event.examenClinico,
          event.examenClinico,
          event.tratamiento,
          event.proximaCita,
          idCita,
          event.dni
        );

        if ( resp ){

          yield SuccessHistorialState();

        } else {
          yield FailureHistorialState(error: 'Algo salio mal!');
        }
        
      } catch (e) {
        yield FailureHistorialState(error: e.toString());
      }

    }


  }
}
