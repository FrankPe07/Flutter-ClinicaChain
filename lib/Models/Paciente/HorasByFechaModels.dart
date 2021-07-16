import 'dart:convert';

HorasByFechaModels horasByFechaModelsFromJson(String str) => HorasByFechaModels.fromJson(json.decode(str));

String horasByFechaModelsToJson(HorasByFechaModels data) => json.encode(data.toJson());

class HorasByFechaModels {
    HorasByFechaModels({
        this.resp,
        this.horas,
    });

    bool resp;
    List<Horas> horas;

    factory HorasByFechaModels.fromJson(Map<String, dynamic> json) => HorasByFechaModels(
        resp: json["resp"],
        horas: List<Horas>.from(json["horas"].map((x) => Horas.fromJson(x))).toList(),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "horas": List<dynamic>.from(horas.map((x) => x.toJson())),
    };
}

class Horas {
    Horas({
        this.horasId,
        this.hora,
        this.medicoId,
    });

    int horasId;
    String hora;
    int medicoId;

    factory Horas.fromJson(Map<String, dynamic> json) => Horas(
        horasId: json["horas_id"],
        hora: json["hora"],
        medicoId: json["medico_id"],
    );

    Map<String, dynamic> toJson() => {
        "horas_id": horasId,
        "hora": hora,
        "medico_id": medicoId,
    };
}
