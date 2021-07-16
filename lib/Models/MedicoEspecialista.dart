import 'dart:convert';

MedicoEspecialista medicoEspecialistaFromJson(String str) => MedicoEspecialista.fromJson(json.decode(str));

String medicoEspecialistaToJson(MedicoEspecialista data) => json.encode(data.toJson());

class MedicoEspecialista {
    
    bool resp;
    List<Especialista> especialistas;


    MedicoEspecialista({
        this.resp,
        this.especialistas,
    });

    factory MedicoEspecialista.fromJson(Map<String, dynamic> json) => MedicoEspecialista(
        resp: json["resp"],
        especialistas: List<Especialista>.from(json["especialistas"].map((x) => Especialista.fromJson(x))).toList(),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "especialistas": List<dynamic>.from(especialistas.map((x) => x.toJson())),
    };
}

class Especialista {
    
    String letra;
    String especialidad;
    String descripcion;
    String nombre;
    String apellidos;
    String descMedico;
    String direccionConsulta;
    String cpm;
    String rne;
    int medicoId;

    Especialista({
        this.letra,
        this.especialidad,
        this.descripcion,
        this.nombre,
        this.apellidos,
        this.descMedico,
        this.direccionConsulta,
        this.cpm,
        this.rne,
        this.medicoId,
    });

    factory Especialista.fromJson(Map<String, dynamic> json) => Especialista(
        letra: json["letra"],
        especialidad: json["Especialidad"],
        descripcion: json["Descripcion"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        descMedico: json["desc_medico"],
        direccionConsulta: json["direccion_consulta"],
        cpm: json["cpm"],
        rne: json["rne"],
        medicoId: json["medico_id"],
    );

    Map<String, dynamic> toJson() => {
        "letra": letra,
        "Especialidad": especialidad,
        "Descripcion": descripcion,
        "nombre": nombre,
        "apellidos": apellidos,
        "desc_medico": descMedico,
        "direccion_consulta": direccionConsulta,
        "cpm": cpm,
        "rne": rne,
        "medico_id": medicoId,
    };
}
