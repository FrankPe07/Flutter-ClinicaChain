import 'dart:convert';

ResenasMedicasModels resenasMedicasModelsFromJson(String str) => ResenasMedicasModels.fromJson(json.decode(str));

String resenasMedicasModelsToJson(ResenasMedicasModels data) => json.encode(data.toJson());

class ResenasMedicasModels 
{
    bool resp;
    List<ResenasMedico> resenasMedico;

    ResenasMedicasModels({
        this.resp,
        this.resenasMedico,
    });

    factory ResenasMedicasModels.fromJson(Map<String, dynamic> json) => ResenasMedicasModels(
        resp: json["resp"],
        resenasMedico: List<ResenasMedico>.from(json["resenas_medico"].map((x) => ResenasMedico.fromJson(x))).toList(),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "resenas_medico": List<dynamic>.from(resenasMedico.map((x) => x.toJson())),
    };
}

class ResenasMedico 
{
    int citaId;
    String calificacion;
    String opinion;

    ResenasMedico({
        this.citaId,
        this.calificacion,
        this.opinion,
    });

    factory ResenasMedico.fromJson(Map<String, dynamic> json) => ResenasMedico(
        citaId: json["cita_id"],
        calificacion: json["calificacion"],
        opinion: json["opinion"],
    );

    Map<String, dynamic> toJson() => {
        "cita_id": citaId,
        "calificacion": calificacion,
        "opinion": opinion,
    };
}
