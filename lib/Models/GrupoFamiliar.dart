import 'dart:convert';

GrupoFamiliar grupoFamiliarFromJson(String str) => GrupoFamiliar.fromJson(json.decode(str));

String grupoFamiliarToJson(GrupoFamiliar data) => json.encode(data.toJson());

class GrupoFamiliar 
{
    bool resp;
    List<GrupoFamiliarElement> grupoFamiliar;

    GrupoFamiliar({
        this.resp,
        this.grupoFamiliar,
    }); 

    factory GrupoFamiliar.fromJson(Map<String, dynamic> json) => GrupoFamiliar(
        resp: json["resp"],
        grupoFamiliar: List<GrupoFamiliarElement>.from(json["grupo_familiar"].map((x) => GrupoFamiliarElement.fromJson(x))).toList(),
        // grupoFamiliar: List<GrupoFamiliarElement>.from(json["grupo_familiar"].map((x) => GrupoFamiliarElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "resp": resp,
        "grupo_familiar": List<dynamic>.from(grupoFamiliar.map((x) => x.toJson())),
    };
}

class GrupoFamiliarElement 
{

    int pacienteId;
    int parentescoId;
    int familiaId;
    int personaId;
    String iniciales;
    String nombre;
    String apellidos;
    int genero;
    String dni;
    String domicilio;
    String ocupacion;
    String lugarNacimiento;
    DateTime fechaNacimiento;
    String estadoCivil;
    dynamic imagen;
    String grupoSanguineo;
    String parentesco;

    GrupoFamiliarElement({
        this.pacienteId,
        this.parentescoId,
        this.familiaId,
        this.personaId,
        this.iniciales,
        this.nombre,
        this.apellidos,
        this.genero,
        this.dni,
        this.domicilio,
        this.ocupacion,
        this.lugarNacimiento,
        this.fechaNacimiento,
        this.estadoCivil,
        this.imagen,
        this.grupoSanguineo,
        this.parentesco,
    });

    

    factory GrupoFamiliarElement.fromJson(Map<String, dynamic> json) => GrupoFamiliarElement(
        pacienteId: json["paciente_id"],
        parentescoId: json["parentesco_id"],
        familiaId: json["familia_id"] == null ? null : json["familia_id"],
        personaId: json["persona_id"],
        iniciales: json["iniciales"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        genero: json["genero"],
        dni: json["dni"],
        domicilio: json["domicilio"],
        ocupacion: json["ocupacion"],
        lugarNacimiento: json["lugar_nacimiento"],
        fechaNacimiento: DateTime.parse(json["fecha_nacimiento"]),
        estadoCivil: json["estado_civil"],
        imagen: json["imagen"],
        grupoSanguineo: json["grupo_sanguineo"],
        parentesco: json["parentesco"],
    );

    Map<String, dynamic> toJson() => {
        "paciente_id": pacienteId,
        "parentesco_id": parentescoId,
        "familia_id": familiaId == null ? null : familiaId,
        "persona_id": personaId,
        "iniciales": iniciales,
        "nombre": nombre,
        "apellidos": apellidos,
        "genero": genero,
        "dni": dni,
        "domicilio": domicilio,
        "ocupacion": ocupacion,
        "lugar_nacimiento": lugarNacimiento,
        "fecha_nacimiento": fechaNacimiento.toIso8601String(),
        "estado_civil": estadoCivil,
        "imagen": imagen,
        "grupo_sanguineo": grupoSanguineo,
        "parentesco": parentesco,
    };
}
