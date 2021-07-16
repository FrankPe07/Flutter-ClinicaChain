import 'dart:convert';

CitaMedicaModels citaMedicaModelsFromJson(String str) => CitaMedicaModels.fromJson(json.decode(str));

String citaMedicaModelsToJson(CitaMedicaModels data) => json.encode(data.toJson());

class CitaMedicaModels {
    
    bool resp;
    List<CitasMedico> citasMedico;
    
    CitaMedicaModels({
        this.resp,
        this.citasMedico,
    });


    factory CitaMedicaModels.fromJson(Map<String, dynamic> json) => CitaMedicaModels(
        resp: json["resp"],
        citasMedico: List<CitasMedico>.from(json["citas_medico"].map((x) => CitasMedico.fromJson(x))).toList(),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "citas_medico": List<dynamic>.from(citasMedico.map((x) => x.toJson())),
    };
}

class CitasMedico {

    int id;
    int pacienteId;
    int condicion;
    String calificacion;
    String dia;
    String mes;
    String anno;
    String hora;
    String direccionConsulta;
    String especialidad;
    String paciente;

    CitasMedico({
        this.id,
        this.pacienteId,
        this.condicion,
        this.calificacion,
        this.dia,
        this.mes,
        this.anno,
        this.hora,
        this.direccionConsulta,
        this.especialidad,
        this.paciente,
    });

    

    factory CitasMedico.fromJson(Map<String, dynamic> json) => CitasMedico(
        id: json["id"],
        pacienteId: json["paciente_id"],
        condicion: json["condicion"],
        calificacion: json["calificacion"] == null ? null : json["calificacion"],
        dia: json["dia"],
        mes: json["mes"],
        anno: json["anno"],
        hora: json["hora"],
        direccionConsulta: json["direccion_consulta"],
        especialidad: json["Especialidad"],
        paciente: json["paciente"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "paciente_id": pacienteId,
        "condicion": condicion,
        "calificacion": calificacion == null ? null : calificacion,
        "dia": dia,
        "mes": mes,
        "anno": anno,
        "hora": hora,
        "direccion_consulta": direccionConsulta,
        "Especialidad": especialidad,
        "paciente": paciente,
    };
}
