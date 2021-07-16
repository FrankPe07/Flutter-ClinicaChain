import 'dart:convert';

DetailsCalendarioModels detailsCalendarioModelsFromJson(String str) => DetailsCalendarioModels.fromJson(json.decode(str));

String detailsCalendarioModelsToJson(DetailsCalendarioModels data) => json.encode(data.toJson());

class DetailsCalendarioModels {

    bool resp;
    List<Calendario> calendario;

    DetailsCalendarioModels({
        this.resp,
        this.calendario,
    });

  
    factory DetailsCalendarioModels.fromJson(Map<String, dynamic> json) => DetailsCalendarioModels(
        resp: json["resp"],
        calendario: List<Calendario>.from(json["calendario"].map((x) => Calendario.fromJson(x))).toList(),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "calendario": List<dynamic>.from(calendario.map((x) => x.toJson())),
    };
}

class Calendario {

    String dia;
    String mes;
    String anno;
    int fechaId;
    int calendarioId;

    Calendario({
        this.dia,
        this.mes,
        this.anno,
        this.fechaId,
        this.calendarioId,
    });
    

    factory Calendario.fromJson(Map<String, dynamic> json) => Calendario(
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
