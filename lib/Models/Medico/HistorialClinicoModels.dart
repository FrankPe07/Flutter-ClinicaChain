import 'dart:convert';

HistorialClinicoModels historialClinicoModelsFromJson(String str) => HistorialClinicoModels.fromJson(json.decode(str));

String historialClinicoModelsToJson(HistorialClinicoModels data) => json.encode(data.toJson());

class HistorialClinicoModels {
    HistorialClinicoModels({
        this.resp,
        this.paciente,
        this.persona,
        this.historial,
    });

    bool resp;
    Paciente paciente;
    Persona persona;
    List<Historial> historial;

    factory HistorialClinicoModels.fromJson(Map<String, dynamic> json) => HistorialClinicoModels(
        resp: json["resp"],
        paciente: Paciente.fromJson(json["paciente"]),
        persona: Persona.fromJson(json["persona"]),
        historial: List<Historial>.from(json["historial"].map((x) => Historial.fromJson(x))).toList(),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "paciente": paciente.toJson(),
        "persona": persona.toJson(),
        "historial": List<dynamic>.from(historial.map((x) => x.toJson())),
    };
}

class Historial {
    Historial({
        this.id,
        this.citaId,
        this.fecha,
        this.motivoConsulta,
        this.anamnesis,
        this.pa,
        this.pulso,
        this.temperatura,
        this.fc,
        this.fr,
        this.examenClinico,
        this.diagnostico,
        this.tratamiento,
        this.proximaCita,
    });

    int id;
    int citaId;
    DateTime fecha;
    String motivoConsulta;
    String anamnesis;
    String pa;
    String pulso;
    String temperatura;
    String fc;
    String fr;
    String examenClinico;
    String diagnostico;
    String tratamiento;
    DateTime proximaCita;

    factory Historial.fromJson(Map<String, dynamic> json) => Historial(
        id: json["id"],
        citaId: json["cita_id"],
        fecha: DateTime.parse(json["fecha"]),
        motivoConsulta: json["motivo_consulta"],
        anamnesis: json["anamnesis"],
        pa: json["pa"],
        pulso: json["pulso"],
        temperatura: json["temperatura"],
        fc: json["fc"],
        fr: json["fr"],
        examenClinico: json["examen_clinico"],
        diagnostico: json["diagnostico"],
        tratamiento: json["tratamiento"],
        proximaCita: DateTime.parse(json["proxima_cita"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cita_id": citaId,
        "fecha": fecha.toIso8601String(),
        "motivo_consulta": motivoConsulta,
        "anamnesis": anamnesis,
        "pa": pa,
        "pulso": pulso,
        "temperatura": temperatura,
        "fc": fc,
        "fr": fr,
        "examen_clinico": examenClinico,
        "diagnostico": diagnostico,
        "tratamiento": tratamiento,
        "proxima_cita": proximaCita.toIso8601String(),
    };
}

class Paciente {
    Paciente({
        this.id,
        this.personaId,
        this.grupoSanguineo,
        this.numHistorial,
        this.familiaId,
        this.parentescoId,
    });

    int id;
    int personaId;
    String grupoSanguineo;
    String numHistorial;
    int familiaId;
    int parentescoId;

    factory Paciente.fromJson(Map<String, dynamic> json) => Paciente(
        id: json["id"],
        personaId: json["persona_id"],
        grupoSanguineo: json["grupo_sanguineo"],
        numHistorial: json["num_historial"],
        familiaId: json["familia_id"],
        parentescoId: json["parentesco_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "persona_id": personaId,
        "grupo_sanguineo": grupoSanguineo,
        "num_historial": numHistorial,
        "familia_id": familiaId,
        "parentesco_id": parentescoId,
    };
}

class Persona {
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
