import 'package:flutter/widgets.dart';
import 'package:hermes/db/db_admin.dart';
import 'package:hermes/models/norma_model.dart';
import 'package:logger/web.dart';

class CardNormaProvider extends ChangeNotifier{
  
  Logger logger = Logger();

  List<NormaModel> _normas = [];
  List<NormaModel> get normas => _normas;

  int? _idNorma;
  int? get idNorma => _idNorma;

  bool _loading = false;
  bool get loading => _loading;

  void setNormaId(int id) {
    _idNorma = id;
  }

   Future<void> getNormas() async {
    
    _loading = true;
    notifyListeners();

    try {
      _normas= await DbAdmin.db.getNormas();
    } catch (e) {
      logger.w("Error al consultar normas: $e");
      _normas=[];
    }
    _loading = false;
    notifyListeners();
  }

  Future<int> addNorma(NormaModel normaModel) async{
    int res = await DbAdmin.db.insertNorma(normaModel);
    notifyListeners();
    return res;
  }

  Future<int> updateNorma(NormaModel normaModel) async{
    int res = await DbAdmin.db.updateNorma(normaModel);
    notifyListeners();
    return res;
  }

  Future<int> deleteNorma(NormaModel normaModel) async{
    int res = await DbAdmin.db.deleteNorma(normaModel);
    notifyListeners();
    return res;
  }



}