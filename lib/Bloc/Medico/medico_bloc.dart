import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clinicachain/Controller/DBMedico.dart';

part 'medico_event.dart';
part 'medico_state.dart';

class MedicoBloc extends Bloc<MedicoEvent, MedicoState> 
{
  MedicoBloc() : super(MedicoState());

  @override
  Stream<MedicoState> mapEventToState( MedicoEvent event ) async* {

      if( event is AddMedicoBlockchainEvent ){

          try {

            yield LoadingMedicoState();

            final resp = await dbMedico.addMedicoBlockchain(
              nombre: event.nombre,
              apellido: event.apellidos,
              dni: event.dni,
              cpm: event.cpm,
              rne: event.rne,
              descripcion: event.decripcion,
              consulta: event.direccion,
              correo: event.correo,
              constrasena: event.contrasena
            );

            if( resp ){ yield SuccessMedicoState(); }
            else { yield FailureMedicoState(error: 'Algo salio al agregar medico a la wallet'); }

            
          } catch (e) {
            yield FailureMedicoState(error: e.toString());
          }

      }
  }
}
