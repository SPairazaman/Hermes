class NormaModel {
  final int? id;
  final String numNorma;
  final String ideNorma;
  final String sumNorma;
  final String fechPubNorma;
  final String fechEntVigencia;
  final String type;

  NormaModel({
    this.id,
    required this.numNorma,
    required this.ideNorma,
    required this.sumNorma,
    required this.fechPubNorma,
    required this.fechEntVigencia,
    required this.type,
  });

  factory NormaModel.fromDB(Map<String, dynamic> json) {
    return NormaModel(
      id: json['id'],
      numNorma: json['numNorma'],
      ideNorma: json['ideNorma'],
      sumNorma: json['sumNorma'],
      fechPubNorma: json['fechPubNorma'],
      fechEntVigencia: json['fechEntVigencia'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toDB() {
    return {
      'id': id,
      'numNorma': numNorma,
      'ideNorma': ideNorma,
      'sumNorma': sumNorma,
      'fechPubNorma': fechPubNorma,
      'fechEntVigencia': fechEntVigencia,
      "type": type,
    };
  }


  
}