import 'dart:convert';

MedicoModels medicoModelsFromJson(String str) => MedicoModels.fromJson(json.decode(str));

String medicoModelsToJson(MedicoModels data) => json.encode(data.toJson());

class MedicoModels {
    
    bool resp;
    Medico medico;
    Persona persona;
    List<Especialidade> especialidades;

    MedicoModels({
        this.resp,
        this.medico,
        this.persona,
        this.especialidades,
    });

    factory MedicoModels.fromJson(Map<String, dynamic> json) => MedicoModels(
        resp: json["resp"],
        medico: Medico.fromJson(json["medico"]),
        persona: Persona.fromJson(json["persona"]),
        especialidades: List<Especialidade>.from(json["especialidades"].map((x) => Especialidade.fromJson(x))).toList(),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "medico": medico.toJson(),
        "persona": persona.toJson(),
        "especialidades": List<dynamic>.from(especialidades.map((x) => x.toJson())),
    };
}

class Especialidade {

    int id;
    String especialidad;
    int medicoId;

    Especialidade({
        this.id,
        this.especialidad,
        this.medicoId,
    });

    factory Especialidade.fromJson(Map<String, dynamic> json) => Especialidade(
        id: json["id"],
        especialidad: json["Especialidad"],
        medicoId: json["medico_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "Especialidad": especialidad,
        "medico_id": medicoId,
    };
}

class Medico {
    
    int id;
    String description;
    String direccionConsulta;
    String cpm;
    String rne;
    int personaId;

    Medico({
        this.id,
        this.description,
        this.direccionConsulta,
        this.cpm,
        this.rne,
        this.personaId,
    });

    factory Medico.fromJson(Map<String, dynamic> json) => Medico(
        id: json["id"],
        description: json["description"],
        direccionConsulta: json["direccion_consulta"],
        cpm: json["cpm"],
        rne: json["rne"],
        personaId: json["persona_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "direccion_consulta": direccionConsulta,
        "cpm": cpm,
        "rne": rne,
        "persona_id": personaId,
    };
}

class Persona {
    
    int id;
    String nombre;
    String apellidos;
    int genero;
    String domicilio;
    String dni;
    String ocupacion;
    String lugarNacimiento;
    DateTime fechaNacimiento;
    String estadoCivil;
    dynamic imagen;
    int estado;
    DateTime createdAt;
    DateTime updatedAt;

    Persona({
        this.id,
        this.nombre,
        this.apellidos,
        this.genero,
        this.domicilio,
        this.dni,
        this.ocupacion,
        this.lugarNacimiento,
        this.fechaNacimiento,
        this.estadoCivil,
        this.imagen,
        this.estado,
        this.createdAt,
        this.updatedAt,
    });

    factory Persona.fromJson(Map<String, dynamic> json) => Persona(
        id: json["id"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        genero: json["genero"],
        domicilio: json["domicilio"],
        dni: json["dni"],
        ocupacion: json["ocupacion"],
        lugarNacimiento: json["lugar_nacimiento"],
        fechaNacimiento: DateTime.parse(json["fecha_nacimiento"]),
        estadoCivil: json["estado_civil"],
        imagen: json["imagen"],
        estado: json["estado"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellidos": apellidos,
        "genero": genero,
        "domicilio": domicilio,
        "dni": dni,
        "ocupacion": ocupacion,
        "lugar_nacimiento": lugarNacimiento,
        "fecha_nacimiento": fechaNacimiento.toIso8601String(),
        "estado_civil": estadoCivil,
        "imagen": imagen,
        "estado": estado,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
