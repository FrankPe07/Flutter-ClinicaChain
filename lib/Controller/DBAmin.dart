
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clinicachain/Controller/AuthController.dart';
import 'package:clinicachain/Models/Admin/EspecialidadesMedicasModels.dart';

class DBAdmin
{
  static String serverUrl = 'http://192.168.1.16:8000/api';

  Future<List<Especialidades>> getEspecialidadesMedicasAdmin() async {

    var token = await authController.readToken();

    final resp = await http.get(Uri.parse('$serverUrl/especialidad'),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' });

    return EspecialidadesMedicasModels.fromJson( jsonDecode( resp.body ) ).especialidad;

  }

  Future<bool> addNuevaEspecialidadMedica({ String especialidad, String descripcion }) async {

    var token = await authController.readToken();

    final resp = await http.post(Uri.parse('$serverUrl/especialidad'),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' },
      body: {
        'especialidad' : "$especialidad",
        'descripcion' : "$descripcion"
      } 
    );

    var data = json.decode( resp.body );

    if( data['resp'] ) return true;
    else return false;

  }

}

final dbAdmin = DBAdmin();