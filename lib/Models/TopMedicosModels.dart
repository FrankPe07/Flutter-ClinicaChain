import 'dart:convert';

TopMedicosModels topMedicosModelsFromJson(String str) => TopMedicosModels.fromJson(json.decode(str));

String topMedicosModelsToJson(TopMedicosModels data) => json.encode(data.toJson());

class TopMedicosModels {
    
    bool resp;
    List<TopMedico> topMedicos;

    TopMedicosModels({
        this.resp,
        this.topMedicos,
    });

    factory TopMedicosModels.fromJson(Map<String, dynamic> json) => TopMedicosModels(
        resp: json["resp"],
        topMedicos: List<TopMedico>.from(json["top_medicos"].map((x) => TopMedico.fromJson(x))).toList(),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "top_medicos": List<dynamic>.from(topMedicos.map((x) => x.toJson())),
    };
}

class TopMedico {
    
    int id;
    String initial;
    String nombre;
    String apellidos;
    String description;

    TopMedico({
        this.id,
        this.initial,
        this.nombre,
        this.apellidos,
        this.description,
    });

    factory TopMedico.fromJson(Map<String, dynamic> json) => TopMedico(
        id: json["id"],
        initial: json["initial"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "initial": initial,
        "nombre": nombre,
        "apellidos": apellidos,
        "description": description,
    };
}
