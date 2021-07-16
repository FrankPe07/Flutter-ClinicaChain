import 'dart:convert';

CitasMedicasPacienteModels citasMedicasPacienteModelsFromJson(String str) => CitasMedicasPacienteModels.fromJson(json.decode(str));

String citasMedicasPacienteModelsToJson(CitasMedicasPacienteModels data) => json.encode(data.toJson());

class CitasMedicasPacienteModels {

    CitasMedicasPacienteModels({
        this.resp,
        this.citas,
    });

    bool resp;
    List<Citas> citas;

    factory CitasMedicasPacienteModels.fromJson(Map<String, dynamic> json) => CitasMedicasPacienteModels(
        resp: json["resp"],
        citas: List<Citas>.from(json["citas"].map((x) => Citas.fromJson(x))).toList(),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "citas": List<dynamic>.from(citas.map((x) => x.toJson())),
    };
}

class Citas {
    Citas({
        this.id,
        this.condicion,
        this.dia,
        this.mes,
        this.anno,
        this.hora,
        this.direccionConsulta,
        this.medico,
        this.especialidad,
        this.paciente,
    });

    int id;
    int condicion;
    String dia;
    String mes;
    String anno;
    String hora;
    String direccionConsulta;
    String medico;
    String especialidad;
    String paciente;

    factory Citas.fromJson(Map<String, dynamic> json) => Citas(
        id: json["id"],
        condicion: json["condicion"],
        dia: json["dia"],
        mes: json["mes"],
        anno: json["anno"],
        hora: json["hora"],
        direccionConsulta: json["direccion_consulta"],
        medico: json["medico"],
        especialidad: json["Especialidad"],
        paciente: json["paciente"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "condicion": condicion,
        "dia": dia,
        "mes": mes,
        "anno": anno,
        "hora": hora,
        "direccion_consulta": direccionConsulta,
        "medico": medico,
        "Especialidad": especialidad,
        "paciente": paciente,
    };
}
