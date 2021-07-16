import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clinicachain/Controller/AuthController.dart';
import 'package:clinicachain/Models/AuthModels.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  
  
  AuthBloc(AuthState initialState) : super(initialState);

  AuthState get initialState => AuthState.initial();

  @override
  Stream<AuthState> mapEventToState( AuthEvent event ) async* {

    if( event is LoginEvent ){

      try {
        
        yield LoadingState();

        await Future.delayed( const Duration(seconds: 2 ));

        final data = await authController.iniciarSesion(event.email, event.password);
        final secureStorage = FlutterSecureStorage();

        if( data.resp ){

          await authController.persisteToken(data.token);
          await secureStorage.write(key: 'personaid', value: data.personaId.toString());
          await secureStorage.write(key: 'name', value: data.nombre);
          await secureStorage.write(key: 'lastname', value: data.apellidos);
          await secureStorage.write(key: 'email', value: data.correo);
          await secureStorage.write(key: 'rolid', value: data.rolId.toString());
          await secureStorage.write(key: 'dni', value: data.dni);

          yield AuthState(authModels: data);
          yield state.copyWith(
            nombreStorage: data.nombre,
            lastnameStorage: data.apellidos,
            emailStorage: data.correo,
            idrolStorage: data.rolId.toString(),
            dni: data.dni,
            idPersonaStora: data.personaId.toString()
          );
        
        } else {
          yield FailureState(error: data.menssage);
        }

      } catch (e) {
        yield FailureState(error: e.toString()); 
      }

    }

    else if ( event is CheckLoginEvent ){

      final storage = FlutterSecureStorage();

      final bool hasToken = await authController.hasToken();
      final String nombre = await storage.read(key: 'name');
      final String lastname = await storage.read(key: 'lastname');
      final String email = await storage.read(key: 'email');
      final String rolId = await storage.read(key: 'rolid');
      final String dni = await storage.read(key: 'dni');
      final String personaid = await storage.read(key: 'personaid');

      if( hasToken ){
        yield LoggedInState();
        yield state.copyWith(
          nombreStorage: nombre,
          lastnameStorage: lastname,
          emailStorage: email,
          idrolStorage: rolId,
          dni: dni,
          idPersonaStora: personaid
        );
      }else{
        yield LoggedOutState();
        storage.delete(key: 'token');
        storage.deleteAll();
      }

    }

    else if ( event is LogOutEvent ){

      final storage = FlutterSecureStorage();

      await authController.loggoutApp( await authController.readToken() );
      storage.delete(key: 'token');
      await authController.deleteToken();
      yield LoggedOutState(); 
    
    } 


  }
}
