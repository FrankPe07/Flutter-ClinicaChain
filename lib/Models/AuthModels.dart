import 'dart:convert';

AuthModels authModelsFromJson(String str) => AuthModels.fromJson(json.decode(str));

String authModelsToJson(AuthModels data) => json.encode(data.toJson());

class AuthModels {

    bool resp;
    String token;
    int rolId;
    int personaId;
    String correo;
    String nombre;
    String apellidos;
    String menssage;
    String dni;

    AuthModels({
        this.resp,
        this.token,
        this.rolId,
        this.personaId,
        this.correo,
        this.nombre,
        this.apellidos,
        this.menssage,
        this.dni
    });

    factory AuthModels.fromJson(Map<String, dynamic> json) => AuthModels(
        resp: json["resp"],
        token: json["token"],
        rolId: json["rol_id"],
        personaId: json["persona_id"],
        correo: json["correo"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        menssage: json["menssage"],
        dni: json['dni'],
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "token": token,
        "rol_id": rolId,
        "persona_id": personaId,
        "correo": correo,
        "nombre": nombre,
        "apellidos": apellidos,
        "menssage": menssage,
        "dni": dni,
    };
}
