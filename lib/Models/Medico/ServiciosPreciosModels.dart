import 'dart:convert';

ServiciosPreciosModels serviciosPreciosModelsFromJson(String str) => ServiciosPreciosModels.fromJson(json.decode(str));

String serviciosPreciosModelsToJson(ServiciosPreciosModels data) => json.encode(data.toJson());

class ServiciosPreciosModels {
    
    bool resp;
    List<Servicio> servicios;

    ServiciosPreciosModels({
        this.resp,
        this.servicios,
    });

    factory ServiciosPreciosModels.fromJson(Map<String, dynamic> json) => ServiciosPreciosModels(
        resp: json["resp"],
        servicios: List<Servicio>.from(json["servicios"].map((x) => Servicio.fromJson(x))).toList(),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "servicios": List<dynamic>.from(servicios.map((x) => x.toJson())),
    };
}

class Servicio {
    
    int id;
    int tipoServicioId;
    String descripcion;
    int precio;
    int medicoId;
    TipoServicio tipoServicio;

    Servicio({
        this.id,
        this.tipoServicioId,
        this.descripcion,
        this.precio,
        this.medicoId,
        this.tipoServicio,
    });

    factory Servicio.fromJson(Map<String, dynamic> json) => Servicio(
        id: json["id"],
        tipoServicioId: json["tipo_servicio_id"],
        descripcion: json["descripcion"],
        precio: json["precio"],
        medicoId: json["medico_id"],
        tipoServicio: TipoServicio.fromJson(json["tipo_servicio"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_servicio_id": tipoServicioId,
        "descripcion": descripcion,
        "precio": precio,
        "medico_id": medicoId,
        "tipo_servicio": tipoServicio.toJson(),
    };
}

class TipoServicio {
    
    int id;
    String nombreServicio;
    DateTime createdAt;
    DateTime updatedAt;

    TipoServicio({
        this.id,
        this.nombreServicio,
        this.createdAt,
        this.updatedAt,
    });

    factory TipoServicio.fromJson(Map<String, dynamic> json) => TipoServicio(
        id: json["id"],
        nombreServicio: json["nombreServicio"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombreServicio": nombreServicio,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
