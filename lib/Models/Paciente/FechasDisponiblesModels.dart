import 'dart:convert';

FechasDisponiblesModels fechasDisponiblesModelsFromJson(String str) => FechasDisponiblesModels.fromJson(json.decode(str));

String fechasDisponiblesModelsToJson(FechasDisponiblesModels data) => json.encode(data.toJson());

class FechasDisponiblesModels {

    bool resp;
    List<Fechas> fechas;

    FechasDisponiblesModels({
        this.resp,
        this.fechas,
    });

    factory FechasDisponiblesModels.fromJson(Map<String, dynamic> json) => FechasDisponiblesModels(
        resp: json["resp"],
        fechas: List<Fechas>.from(json["fechas"].map((x) => Fechas.fromJson(x))).toList(),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "fechas": List<dynamic>.from(fechas.map((x) => x.toJson())),
    };
}

class Fechas {

    String dia;
    String mes;
    String anno;
    int fechaId;
    int calendarioId;

    Fechas({
        this.dia,
        this.mes,
        this.anno,
        this.fechaId,
        this.calendarioId,
    });

    factory Fechas.fromJson(Map<String, dynamic> json) => Fechas(
        dia: json["dia"],
        mes: json["mes"],
        anno: json["anno"],
        fechaId: json["fecha_id"],
        calendarioId: json["calendario_id"],
    );

    Map<String, dynamic> toJson() => {
        "dia": dia,
        "mes": mes,
        "anno": anno,
        "fecha_id": fechaId,
        "calendario_id": calendarioId,
    };
}
