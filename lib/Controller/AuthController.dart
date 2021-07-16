import 'dart:convert';

import 'package:clinicachain/Models/AuthModels.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthController
{
  static String serverUrl = 'http://192.168.1.16:8000/api';
  String urlLogin = '$serverUrl/login';

  final secureStorage = FlutterSecureStorage();

  Future<AuthModels> iniciarSesion(String email, String password) async {

    final response = await http.post(Uri.parse(urlLogin), 
        headers: {'Accept' : 'application/json'},
        body: {
          'correo'   : '$email',
          'password' : '$password'
        }
    );

    var authModel = AuthModels.fromJson( json.decode(response.body) );

    return authModel;
  }

  Future<void> loggoutApp( String token ) async {

    await http.post(Uri.parse('http://192.168.1.16:8000/api/logoutApi'),
      headers: { 'Accept' : 'application/json', 'Authorization' : 'Bearer $token' }
    );
  }


  //Persistencia de Datos Flutter-Storage-Secure
  Future<bool> hasToken() async {
    var value = await secureStorage.read(key: 'token');

    if( value != null ) return true;
    else return false;
  }

  Future<String> readToken() async {
    return await secureStorage.read(key: 'token');
  }

  Future<void> persisteToken( String token ) async {
    await secureStorage.write(key: 'token', value: token);
  }


  Future<void> deleteToken() async {
    secureStorage.delete(key: 'token');
    secureStorage.deleteAll();
  }

}

final authController = AuthController();