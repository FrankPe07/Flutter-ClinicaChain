import 'package:clinicachain/Bloc/CalendarMedico/calendarmedico_bloc.dart';
import 'package:clinicachain/Bloc/HistorialClinico/historialclinico_bloc.dart';
import 'package:clinicachain/Bloc/Medico/medico_bloc.dart';
import 'package:clinicachain/Bloc/Paciente/paciente_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinicachain/Bloc/CitaPaciente/citapaciente_bloc.dart';
import 'package:clinicachain/Models/AuthModels.dart';
import 'package:clinicachain/Bloc/Auth/auth_bloc.dart';
import 'package:clinicachain/Routes/Routes.dart';
import 'package:intl/date_symbol_data_local.dart';


void main() => initializeDateFormatting().then((_) => runApp(MyApp()));


class MyApp extends StatelessWidget 
{

  @override
  Widget build(BuildContext context) 
  {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark ));
    
    return MultiBlocProvider( 
      providers: [
        BlocProvider(create: ( context ) => AuthBloc(AuthState(authModels: AuthModels()))..add( CheckLoginEvent() )),
        BlocProvider(create: ( context ) => CitapacienteBloc()),
        BlocProvider(create: ( context ) => CalendarmedicoBloc()),
        BlocProvider(create: ( context ) => HistorialclinicoBloc()),
        BlocProvider(create: ( context ) => MedicoBloc()),
        BlocProvider(create: ( context ) => PacienteBloc()),
      ],
      child: MaterialApp(
        title: 'ClinicaChain - v2.0',
        debugShowCheckedModeBanner: false,
        initialRoute: 'loading',
        routes: routes,
        supportedLocales: [
            const Locale('es', 'ES'),
            const Locale('en', 'US'),
        ],
      ),
    );
  }
}