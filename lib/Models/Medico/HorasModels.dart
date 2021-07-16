import 'dart:convert';

HorasModels horasModelsFromJson(String str) => HorasModels.fromJson(json.decode(str));

String horasModelsToJson(HorasModels data) => json.encode(data.toJson());

class HorasModels 
{
    HorasModels({
        this.resp,
        this.horas,
    });

    bool resp;
    List<Horas> horas;

    factory HorasModels.fromJson(Map<String, dynamic> json) => HorasModels(
        resp: json["resp"],
        horas: List<Horas>.from(json["horas"].map((x) => Horas.fromJson(x))).toList(),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "horas": List<dynamic>.from(horas.map((x) => x.toJson())),
    };
}

class Horas 
{
    Horas({
        this.id,
        this.hora,
    });

    int id;
    String hora;

    factory Horas.fromJson(Map<String, dynamic> json) => Horas(
        id: json["id"],
        hora: json["hora"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "hora": hora,
    };
}
