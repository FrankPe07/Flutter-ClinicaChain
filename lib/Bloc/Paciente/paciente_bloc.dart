import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clinicachain/Controller/DBPaciente.dart';

part 'paciente_event.dart';
part 'paciente_state.dart';

class PacienteBloc extends Bloc<PacienteEvent, PacienteState> {
  PacienteBloc() : super(PacienteState());

  @override
  Stream<PacienteState> mapEventToState( PacienteEvent event ) async* {
    
      if( event is AgregarPacienteBlockchainEvent ){

          try {

            yield LoadingPacienteState();

            final response = await dbPaciente.createNuevoPacienteToBlockchain(
              nombre: event.nombre,
              apellidos: event.apellidos,
              dni: event.dni,
              domicilio: event.domicilio,
              nacimiento: event.nacimiento,
              sanguineo: event.sanguino,
              correo: event.correo,
              contrasena: event.contrasena
            );

            if( response ) yield SuccessPacienteState();
            else yield FailurePacienteState(error: 'Algo salio mal');

            
          } catch (e) {
            yield FailurePacienteState(error: e.toString());
          }

      }

  }
}
