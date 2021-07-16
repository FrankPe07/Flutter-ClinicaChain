import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:clinicachain/Models/MedicoEspecialista.dart';
import 'package:clinicachain/Models/Paciente/CitasMedicasPacienteModels.dart';
import 'package:clinicachain/Models/Paciente/FechasDisponiblesModels.dart';
import 'package:clinicachain/Models/Paciente/HistoriaClinicaBlockchainResponse.dart';
import 'package:clinicachain/Models/Paciente/HorasByFechaModels.dart';
import 'package:clinicachain/Models/Paciente/ListadoHistoriasPacienteResponse.dart';
import 'package:clinicachain/Models/ServicioPrecioOfMedico.dart';
import 'package:clinicachain/Services/Global.dart';

import 'package:clinicachain/Controller/AuthController.dart';
import 'package:clinicachain/Models/GrupoFamiliar.dart';
import 'package:clinicachain/Models/EspecialidadesMedicasModels.dart';

class DBPaciente
{
  static String serverUrl = 'http://192.168.1.16:8000/api';

  
  Future<List<GrupoFamiliarElement>> grupoFamiliarPaciente() async {

    var token = await authController.readToken();

    final resp = await http.get(Uri.parse('$serverUrl/grupo-familiar'),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' });

    var data = GrupoFamiliar.fromJson( jsonDecode( resp.body ) );

    return data.grupoFamiliar;
  }


  Future<List<Especialidades>> getEspecialidadesMedicas( String query ) async {

    var token = await authController.readToken();

    final resp = await http.get(Uri.parse('$serverUrl/especialidad-query?buscar='+ query ),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' });

    var data = EspecialidadesMedicasModels.fromJson( json.decode( resp.body ) );

    return data.especialidad;
  }


  Future<List<Especialista>> getMedicosEspecialistas( String idEspecialidad ) async {

    var token = await authController.readToken();

    final resp = await http.get(Uri.parse('$serverUrl/especialistas?idTipoEspecialidad='+ idEspecialidad ),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' });

    var data = MedicoEspecialista.fromJson( json.decode( resp.body ) );

    return data.especialistas;
  }


  Future<List<dynamic>> getEspecialidadesQuery( String query ) async {

      var token = await authController.readToken();

      final resp = await http.get(Uri.parse('$serverUrl/especialidad-query?buscar='+ query),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' });

      var data = json.decode( resp.body );

      return data['especialidad'];
  }


  Future<List<Servicio>> getServiciosPreciosOfMedico( String idMedico ) async {

    var token = await authController.readToken();

    final resp = await http.get(Uri.parse('$serverUrl/servicio-by-medico?idMedicoServicio='+ idMedico ),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' });

    return ServiciosPrecioOfMedico.fromJson( json.decode( resp.body ) ).servicios;

  }


  Future<List<Fechas>> getFechaHoraPacienteCita( String month, String idMedico, String year ) async {

    var token = await authController.readToken();

    final resp = await http.get(Uri.parse('$serverUrl/fecha-hora?mes='+ month +'&idmedico='+ idMedico +'&year='+ year),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' });
  
    return FechasDisponiblesModels.fromJson( json.decode( resp.body ) ).fechas;
  }


  Future<List<Horas>> getHorasForFecha( String year, String month, String day, String idMedico ) async {

    var token = await authController.readToken();

    final resp = await http.get(Uri.parse('$serverUrl/horas-by-mes-para-paciente?dia='+day+'&mes='+ month +'&anno='+ year +'&idMedico=' + idMedico),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' });

    return HorasByFechaModels.fromJson( json.decode( resp.body ) ).horas;
  }


  Future<bool> createCitaMedicaPaciente( {String idMedico, String idPaciente, String idHora, String idEspecialidad, String descripcion}) async {

    var token = await authController.readToken();

    final resp = await http.post(Uri.parse('$serverUrl/create-cita-paciente'),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' },
      body: {
        'medico'   : '$idMedico',
        'paciente' : '$idPaciente',
        'programacion' : '$idHora',
        'especialidad' : '$idEspecialidad',
        'descripcion' : '$descripcion'
      }
      );

    final data = json.decode( resp.body );

    return data['resp'];
  }


  Future<List<Citas>> getCitasMedicasPaciente() async {

    var token = await authController.readToken();
    
    final resp = await http.get(Uri.parse('$serverUrl/mis-citas'),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' });

    return CitasMedicasPacienteModels.fromJson( json.decode( resp.body ) ).citas;
  }


  Future<String> getTokenAccessHistorial( String idCita ) async {

    var token = await authController.readToken();
    
    final resp = await http.post(Uri.parse('$serverUrl/autorization-token-hce'),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' },
      body: { 'cita_id' : '$idCita'}
    );

    var data = json.decode( resp.body );
    
    return data['token'];
  }


  Future<bool> createNuevoPacienteToBlockchain({ String nombre, String apellidos, String dni, String domicilio, String nacimiento, String sanguineo, String correo, String contrasena }) async {

    final response = await http.post(Uri.parse('http://192.168.1.16:7000/api/create-paciente-to-blockchain'),
      headers:  { 'Accept' : 'application/json' },
      body: { 
        'nombre'      : nombre,
        'apellidos'   : apellidos,
        'dni'         : dni,
        'domicilio'   : domicilio,
        'nacimiento'  : nacimiento,
        'sanguineo'   : sanguineo,
        'correo'      : correo,
        'contrasena'  : contrasena,
      }
    );

    var data = json.decode( response.body );
    return data['resp'];
  }


  Future<List<Historia>> obtenerListaHistoriaClinicaPaciente({ String id }) async {

    final response = await http.get(Uri.parse('${Global.urlServerNodejs}/listado-historia-clinica-paciente/' + id),
      headers:  { 'Accept' : 'application/json' },
    );

    return ListadoHistoriasPacienteResponse.fromJson( json.decode( response.body )).historias;

  }


  Future<HistoriaClinica> obtenerHistoriaClinicaDeBlockchain({ String idHistoria, String dni }) async {

      final response = await http.get(Uri.parse('${Global.urlServerNodejs}/obtener-historia-blockchain-paciente/' + idHistoria + '/' + dni),
        headers:  { 'Accept' : 'application/json' },
      );

      return HistoriaClinicaBlockchainResponse.fromJson( json.decode( response.body ) ).historia;
  }


}

final dbPaciente = DBPaciente();