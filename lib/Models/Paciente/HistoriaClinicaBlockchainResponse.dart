import 'dart:convert';

HistoriaClinicaBlockchainResponse historiaClinicaBlockchainResponseFromJson(String str) => HistoriaClinicaBlockchainResponse.fromJson(json.decode(str));

String historiaClinicaBlockchainResponseToJson(HistoriaClinicaBlockchainResponse data) => json.encode(data.toJson());

class HistoriaClinicaBlockchainResponse {

    HistoriaClinicaBlockchainResponse({
        this.resp,
        this.msj,
        this.historia,
    });

    bool resp;
    String msj;
    HistoriaClinica historia;

    factory HistoriaClinicaBlockchainResponse.fromJson(Map<String, dynamic> json) => HistoriaClinicaBlockchainResponse(
        resp: json["resp"],
        msj: json["msj"],
        historia: HistoriaClinica.fromJson(json["historia"]),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "msj": msj,
        "historia": historia.toJson(),
    };
}

class HistoriaClinica {

    HistoriaClinica({
        this.anamnesis,
        this.diagnostico,
        this.examenClinico,
        this.fc,
        this.fechaCita,
        this.fr,
        this.idCita,
        this.idHistoriaClinica,
        this.medicoApellidos,
        this.medicoNombre,
        this.motivoConsulta,
        this.pa,
        this.pacienteApellidos,
        this.pacienteNombre,
        this.proximaCita,
        this.pulso,
        this.temperatura,
        this.tratamiento,
    });

    String anamnesis;
    String diagnostico;
    String examenClinico;
    String fc;
    String fechaCita;
    String fr;
    String idCita;
    String idHistoriaClinica;
    String medicoApellidos;
    String medicoNombre;
    String motivoConsulta;
    String pa;
    String pacienteApellidos;
    String pacienteNombre;
    String proximaCita;
    String pulso;
    String temperatura;
    String tratamiento;

    factory HistoriaClinica.fromJson(Map<String, dynamic> json) => HistoriaClinica(
        anamnesis: json["anamnesis"],
        diagnostico: json["diagnostico"],
        examenClinico: json["examen_clinico"],
        fc: json["fc"],
        fechaCita: json["fecha_cita"],
        fr: json["fr"],
        idCita: json["idCita"],
        idHistoriaClinica: json["idHistoriaClinica"],
        medicoApellidos: json["medico_apellidos"],
        medicoNombre: json["medico_nombre"],
        motivoConsulta: json["motivo_consulta"],
        pa: json["pa"],
        pacienteApellidos: json["paciente_apellidos"],
        pacienteNombre: json["paciente_nombre"],
        proximaCita: json["proxima_cita"],
        pulso: json["pulso"],
        temperatura: json["temperatura"],
        tratamiento: json["tratamiento"],
    );

    Map<String, dynamic> toJson() => {
        "anamnesis": anamnesis,
        "diagnostico": diagnostico,
        "examen_clinico": examenClinico,
        "fc": fc,
        "fecha_cita": fechaCita,
        "fr": fr,
        "idCita": idCita,
        "idHistoriaClinica": idHistoriaClinica,
        "medico_apellidos": medicoApellidos,
        "medico_nombre": medicoNombre,
        "motivo_consulta": motivoConsulta,
        "pa": pa,
        "paciente_apellidos": pacienteApellidos,
        "paciente_nombre": pacienteNombre,
        "proxima_cita": proximaCita,
        "pulso": pulso,
        "temperatura": temperatura,
        "tratamiento": tratamiento,
    };
}
