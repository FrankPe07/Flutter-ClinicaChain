
import 'dart:convert';

import 'package:clinicachain/Models/Medico/CitaMedicaModels.dart';
import 'package:clinicachain/Models/Medico/DetailsCalendarioModels.dart';
import 'package:clinicachain/Models/Medico/HistorialClinicoModels.dart';
import 'package:clinicachain/Models/Medico/HorasModels.dart';
import 'package:clinicachain/Models/Medico/ResenasMedicasModels.dart';
import 'package:clinicachain/Models/Medico/ServiciosPreciosModels.dart';
import 'package:http/http.dart' as http;
import 'package:clinicachain/Controller/AuthController.dart';
import 'package:clinicachain/Models/Medico/MedicoModels.dart';

class DBMedicoModels
{
  static String serverUrl = 'http://192.168.1.16:8000/api';

  Future<MedicoModels> getMedico() async {

    var token = await authController.readToken();

    final resp = await http.get(Uri.parse('$serverUrl/medico'),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' });

    return MedicoModels.fromJson( json.decode( resp.body ) );
  }


  Future<bool> updateDatosMedicos({ String name, String lastname, int sex, String lugar, String description, String consultorio }) async {

    var token = await authController.readToken();

    final resp = await http.put(Uri.parse('$serverUrl/medico'),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' },
      body: {
        'nombre'    : '$name',
        'apellidos' : '$lastname',
        'sexo'      : '$sex',
        'lugar_nacimiento' : '$lugar',
        'desc_medica' : '$description',
        'consultorio' : '$consultorio'
      }
    );

    var data = json.decode( resp.body );

    return data['resp'];
  }


  Future<List<Servicio>> getServiciosPreciosMedico() async {

    var token = await authController.readToken();

    final resp = await http.get(Uri.parse('$serverUrl/servicios-precios'),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' });
    
    return ServiciosPreciosModels.fromJson( json.decode( resp.body ) ).servicios;
  }


  Future<List> getTipoServicio() async {

    var token = await authController.readToken();

    final resp = await http.get(Uri.parse('$serverUrl/tipo-servicio'),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' });

    var data = json.decode( resp.body );
    return data['tipo_servicio'];
  }


  Future<bool> addServicioPrecioMedico({ int tipo, String description, String precio }) async {

    var token = await authController.readToken();

    final resp = await http.post(Uri.parse('$serverUrl/tipo-servicio'),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' },
      body: {
        'tipo_servicio' : '$tipo',
        'descripcion'   : '$description',
        'precio'        : '$precio'
      }
    );

    var data = json.decode( resp.body );
    return data['resp'];

  }


  Future<List> getCalentarioMedico() async {

    var token = await authController.readToken();

    final resp = await http.get(Uri.parse('$serverUrl/calendario-meses'),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' });

    var data = json.decode( resp.body );
    return data['meses'];

  }


  Future<List<Horas>> getAllHoras() async {

    var token = await authController.readToken();

    final resp = await http.get(Uri.parse('$serverUrl/horas-index'),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' });

    return HorasModels.fromJson( json.decode( resp.body ) ).horas;
  }


  Future<void> addCalendarioMedico( String dia, String mes, String year, List horas ) async {

    var token = await authController.readToken();

    await http.post(Uri.parse('$serverUrl/add-calendario'),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' },
      body: {
        'dia' : '$dia',
        'mes' : '$mes',
        'anno': '$year',
        'horas': '$horas'
      });
  }


  Future<List<Calendario>> getCalendarioByMonthAndYear(String month, String year) async {

    var token = await authController.readToken();

    final resp = await http.get(Uri.parse('$serverUrl/calendario-medico?mes=' + month + '&year=' + year ),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' });

    return DetailsCalendarioModels.fromJson( json.decode( resp.body ) ).calendario;
  }


  Future<List> getHorasbyMonths( String day, String month, String year ) async {

    var token = await authController.readToken();

    final resp = await http.get(Uri.parse('$serverUrl/horas-by-mes?dia='+ day +'&mes='+ month +'&anno=' + year ),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' });

    var data = json.decode( resp.body );

    return data['horas'];
  }


  Future<List<CitasMedico>> getCitasMedicas() async {

    var token = await authController.readToken();

    final resp = await http.get(Uri.parse('$serverUrl/citas-para-medico'),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' });

    return CitaMedicaModels.fromJson( json.decode( resp.body ) ).citasMedico;

  }


  Future<bool> validationCodeHistorialClinica( String idCita, String code ) async {

    var token = await authController.readToken();

    final resp = await http.get(Uri.parse('$serverUrl/validate-token-hce?cita_id=' + idCita + '&codtoken=' + code ),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' });

    var data = json.decode( resp.body );

    return data['resp'];
  }


  Future<HistorialClinicoModels> getHistorrialClinicoPaciente( String idPaciente ) async {

    var token = await authController.readToken();

    final resp = await http.get(Uri.parse('$serverUrl/historial-clinico-paciente?idPaciente=' + idPaciente ),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' });

    return HistorialClinicoModels.fromJson( json.decode( resp.body ) );
  }


  Future<bool> addHistorialClinico( String fecha, String motivo, String ana, String pa, String puls, String temp, String fc, String fr, String exfisico, String diag, String trata, String prxcita, String cita, String dni ) async {

    var token = await authController.readToken();

    final resp = await http.post(Uri.parse('http://192.168.1.16:7000/api/add-historial-clinico'),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' },
      body: {
        'fecha'   : '$fecha',
        'motivo'  : '$motivo',
        'ana'     : '$ana',
        'pa'      : '$pa',
        'pulso'   : '$puls',
        'temp'    : '$temp',
        'fc'      : '$fc',
        'fr'      : '$fr',
        'exfisico': '$exfisico',
        'diagnostico': '$diag',
        'tratamiento': '$trata',
        'prxcita' : '$prxcita',
        'cita_id' : '$cita',
        'dni_medico' : dni
      }
    );

    var data = json.decode( resp.body );

    return data['resp'];
  }


  Future<List<ResenasMedico>> getResenasMedicas() async {

    var token = await authController.readToken();

    final resp = await http.get(Uri.parse('$serverUrl/resenas-para-medico'),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' });

    return ResenasMedicasModels.fromJson( json.decode( resp.body ) ).resenasMedico;
  }
  

  Future<bool> addMedicoBlockchain({String nombre, String apellido, String dni, String cpm, String rne, String descripcion, String consulta, String correo, String constrasena }) async {

      var token = await authController.readToken();

      final resp = await http.post(Uri.parse('http://192.168.1.16:7000/api/add-medico-blockchain-authorization'),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' },
      body: {
        'nombre'      : nombre,
        'apellido'    : apellido,
        'dni'         : dni,
        'cpm'         : cpm,
        'rne'         : rne,
        'descripcion' : descripcion,
        'consulta'    : consulta,
        'correo'      : correo,
        'contrasena'  : constrasena,
        'slug'        : '$nombre$cpm'
      }
    );

    var data = json.decode( resp.body );

    return data['resp'];
  }



}

final dbMedico = DBMedicoModels();