import 'package:clinicachain/Screens/Acerca/AcercaDePage.dart';
import 'package:clinicachain/Screens/Acerca/TerminosPage.dart';
import 'package:clinicachain/Screens/Admin/AddMedicoPage.dart';
import 'package:clinicachain/Screens/Admin/EspecialidadesPage.dart';
import 'package:clinicachain/Screens/Home/HomePage.dart';
import 'package:clinicachain/Screens/Login/LoginPage.dart';
import 'package:clinicachain/Screens/Medico/AddNewCalendarioPage.dart';
import 'package:clinicachain/Screens/Medico/AddServicioPrecioPage.dart';
import 'package:clinicachain/Screens/Medico/CalendarioPage.dart';
import 'package:clinicachain/Screens/Medico/CitaPage.dart';
import 'package:clinicachain/Screens/Medico/DatosGeneralesPages.dart';
import 'package:clinicachain/Screens/Medico/ResenasPages.dart';
import 'package:clinicachain/Screens/Medico/ServicioPrecioPage.dart';
import 'package:clinicachain/Screens/Paciente/AddPacientePage.dart';
import 'package:clinicachain/Screens/Paciente/BuscarEspecialidadPage.dart';
import 'package:clinicachain/Screens/Paciente/GrupoFamiliarPage.dart';
import 'package:clinicachain/Screens/Paciente/HistoriaClinicaPage.dart';
import 'package:clinicachain/Screens/Paciente/MedicoEspecialista.dart';
import 'package:clinicachain/Screens/Paciente/MisCitasPage.dart';
import 'package:clinicachain/Screens/Paciente/SelectedPacientePage.dart';
import 'package:flutter/material.dart';

import 'package:clinicachain/Screens/Login/Loading.dart';


Map<String, Widget Function(BuildContext)> routes = {

  'loading'        : (_) => LoadingLoginPage(),
  'loginPage'      : (_) => LoginPage(),
  'homePage'      : (_) => HomePage(),
  'grupoFamiliarPage'      : (_) => GrupoFamiliarPage(),
  'misCitasPage'           : (_) => MisCitasPage(),
  'addPacientePage'        : (_) => AddPacientePage(),
  'buscarEspecialidadPage' : (_) => BuscarEspecialidadPage(),
  'historiaClinicaPaciente' : (_) => HistoriaClinicaPacientePage(),
  'medicoEspecialista'     : (_) => MedicoEspecialistaPage(),
  'selectedPaciente'       : (_) => SelectedPacientePage(),
  'datosGenerales'         : (_) => DatosGeneralesPage(),
  'servicioPrecio'         : (_) => ServicioPrecioPage(),
  'calendarioPage'         : (_) => CalendarioPage(),
  'addServicioPrecio'      : (_) => AddServicioPrecioPage(),
  'addNewCalendarioPage'   : (_) => AddNewCalendarioPage(),
  'citasPage'              : (_) => CitasPage(),
  'resenasPage'            : (_) => ResenasPage(),
  'terminosPage'           : (_) => TerminosPage(),
  'acercaDePage'           : (_) => AcercaDePage(),
  // Admin Routes
  'especialidadesPage'     : (_) => EspecialidadesPage(),
  'addMedico'              : (_) => AddMedicoPage(),
  
};