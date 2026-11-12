import 'package:flutter/widgets.dart';
import 'package:hermes/db/db_admin.dart';
import 'package:hermes/models/requisito_model.dart';
import 'package:logger/web.dart';


class CardRequisitoProvider extends ChangeNotifier{
  Logger logger=Logger();

  int? _id;
  int? get id => _id;

  List<RequisitoModel> _requisitos = [];

  List<RequisitoModel> get requisitos => _requisitos;

  bool _loading = false;
  bool get loading => _loading;

  void setId(int id) {
    _id = id;
    getRequisitos();

  }

  Future<void> getRequisitos() async {
    if (_id == null) return;
    
    _loading = true;
    notifyListeners();

    try {
      _requisitos= await DbAdmin.db.getRequisitos(id!);
    } catch (e) {
      logger.w("Error al consultar requisito: $e");
      _requisitos=[];
    }
    _loading = false;
    notifyListeners();
  }

  Future<int> addRequisito(RequisitoModel requisito_model) async{
    int res = await DbAdmin.db.insertRequisito(requisito_model);
    notifyListeners();
    return res;
  }

   Future<int> updateRequisito(RequisitoModel requisitoModel) async{
    int res = await DbAdmin.db.updateRequisito(requisitoModel);
    notifyListeners();
    return res;
  }

  Future<int> deleteRequisito(RequisitoModel requisitoModel) async{
    int res = await DbAdmin.db.deleteRequisito(requisitoModel);
    notifyListeners();
    return res;
  }




}