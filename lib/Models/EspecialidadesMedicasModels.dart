import 'dart:convert';

EspecialidadesMedicasModels especialidadesMedicasModelsFromJson(String str) => EspecialidadesMedicasModels.fromJson(json.decode(str));

String especialidadesMedicasModelsToJson(EspecialidadesMedicasModels data) => json.encode(data.toJson());

class EspecialidadesMedicasModels 
{    
    bool resp;
    List<Especialidades> especialidad;

    EspecialidadesMedicasModels({
        this.resp,
        this.especialidad,
    });

    factory EspecialidadesMedicasModels.fromJson(Map<String, dynamic> json) => EspecialidadesMedicasModels(
        resp: json["resp"],
        especialidad: List<Especialidades>.from(json["especialidad"].map((x) => Especialidades.fromJson(x))).toList(),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "especialidad": List<dynamic>.from(especialidad.map((x) => x.toJson())),
    };
}

class Especialidades {
    
    int id;
    String especialidad;
    String descripcion;

    Especialidades({
        this.id,
        this.especialidad,
        this.descripcion,
    });

    factory Especialidades.fromJson(Map<String, dynamic> json) => Especialidades(
        id: json["id"],
        especialidad: json["Especialidad"],
        descripcion: json["Descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "Especialidad": especialidad,
        "Descripcion": descripcion,
    };
}
