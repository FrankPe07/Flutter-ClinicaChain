import 'dart:convert';
import 'package:clinicachain/Controller/AuthController.dart';
import 'package:clinicachain/Models/TopMedicosModels.dart';
import 'package:http/http.dart' as http;

class DBHome
{
  static String serverUrl = 'http://192.168.1.16:8000/api';


  Future<List<TopMedico>> getTopHome() async {

    var token = await authController.readToken();

    final resp = await http.get(Uri.parse('$serverUrl/top-medicos-home'),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' });

    return TopMedicosModels.fromJson( json.decode( resp.body ) ).topMedicos;
  }

  Future<List> getTopEspecialidades() async {

    var token = await authController.readToken();

    final resp = await http.get(Uri.parse('$serverUrl/top_especialidades'),
      headers:  { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' });
    
    var data = json.decode( resp.body );

    return data['top_especialidades'];
  }

}

final dbHome = DBHome();

