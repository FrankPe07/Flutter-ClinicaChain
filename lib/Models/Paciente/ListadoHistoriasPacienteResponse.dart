import 'dart:convert';

ListadoHistoriasPacienteResponse listadoHistoriasPacienteResponseFromJson(String str) => ListadoHistoriasPacienteResponse.fromJson(json.decode(str));

String listadoHistoriasPacienteResponseToJson(ListadoHistoriasPacienteResponse data) => json.encode(data.toJson());

class ListadoHistoriasPacienteResponse {
  
    ListadoHistoriasPacienteResponse({
        this.resp,
        this.msj,
        this.historias,
    });

    bool resp;
    String msj;
    List<Historia> historias;

    factory ListadoHistoriasPacienteResponse.fromJson(Map<String, dynamic> json) => ListadoHistoriasPacienteResponse(
        resp: json["resp"],
        msj: json["msj"],
        historias: List<Historia>.from(json["historias"].map((x) => Historia.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "msj": msj,
        "historias": List<dynamic>.from(historias.map((x) => x.toJson())),
    };
}

class Historia {
    Historia({
        this.id,
        this.nombre,
        this.apellidos,
        this.fecha,
        this.motivoConsulta,
    });

    int id;
    String nombre;
    String apellidos;
    DateTime fecha;
    String motivoConsulta;

    factory Historia.fromJson(Map<String, dynamic> json) => Historia(
        id: json["id"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        fecha: DateTime.parse(json["fecha"]),
        motivoConsulta: json["motivo_consulta"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellidos": apellidos,
        "fecha": fecha.toIso8601String(),
        "motivo_consulta": motivoConsulta,
    };
}
