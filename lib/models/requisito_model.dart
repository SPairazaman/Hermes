class RequisitoModel {
  int? id;
  String nombre;
  String texto;
  String interpretacion;
  String evidencia;
  String periodicidad;
  int idNorma;

  RequisitoModel({this.id, required this.nombre, required this.texto, required this.interpretacion, required this.evidencia, required this.periodicidad, required this.idNorma});

  Map<String, dynamic> toDB() {
    return {
      'id': id,
      'nombre': nombre,
      'texto': texto,
      'interpretacion': interpretacion,
      'evidencia': evidencia,
      'periodicidad': periodicidad,
      'idNorma': idNorma,
    };
  }


  factory RequisitoModel.fromDB(Map<String, dynamic> map) {
    return RequisitoModel(
      id: map['id'],
      nombre: map['nombre'],
      texto: map['texto'],
      interpretacion: map['interpretacion'],
      evidencia: map['evidencia'],
      periodicidad: map['periodicidad'],
      idNorma: map['idNorma'],
    );
  }

  
}