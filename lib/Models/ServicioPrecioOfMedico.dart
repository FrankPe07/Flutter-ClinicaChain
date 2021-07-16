import 'dart:convert';

ServiciosPrecioOfMedico serviciosPrecioOfMedicoFromJson(String str) => ServiciosPrecioOfMedico.fromJson(json.decode(str));

String serviciosPrecioOfMedicoToJson(ServiciosPrecioOfMedico data) => json.encode(data.toJson());

class ServiciosPrecioOfMedico 
{
    bool resp;
    List<Servicio> servicios;

    ServiciosPrecioOfMedico({
        this.resp,
        this.servicios,
    });

    factory ServiciosPrecioOfMedico.fromJson(Map<String, dynamic> json) => ServiciosPrecioOfMedico(
        resp: json["resp"],
        servicios: List<Servicio>.from(json["especialistas"].map((x) => Servicio.fromJson(x))).toList(),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "especialistas": List<dynamic>.from(servicios.map((x) => x.toJson())),
    };
}

class Servicio 
{
    String nombreServicio;
    String descripcion;
    int precio;

    Servicio({
        this.nombreServicio,
        this.descripcion,
        this.precio,
    });

    factory Servicio.fromJson(Map<String, dynamic> json) => Servicio(
        nombreServicio: json["nombreServicio"],
        descripcion: json["descripcion"],
        precio: json["precio"],
    );

    Map<String, dynamic> toJson() => {
        "nombreServicio": nombreServicio,
        "descripcion": descripcion,
        "precio": precio,
    };
}
