import 'package:flutter/material.dart';
import 'package:hermes/db/db_admin.dart';
import 'package:hermes/models/requisito_model.dart';
import 'package:hermes/providers/card_requisito_provider.dart';
import 'package:hermes/widgets/field_widget.dart';
import 'package:provider/provider.dart';

class RegisterRequisitoWidget extends StatefulWidget {
  final RequisitoModel? requisito;
  RegisterRequisitoWidget({super.key, this.requisito});

  @override
  State<RegisterRequisitoWidget> createState() => _RegisterRequisitoWidgetState();
}

class _RegisterRequisitoWidgetState extends State<RegisterRequisitoWidget> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nombreController = TextEditingController();
  TextEditingController _textoController = TextEditingController();
  TextEditingController _interpretacionController = TextEditingController();
  TextEditingController _evidenciaController = TextEditingController();
  TextEditingController _periodicidadController = TextEditingController();
  bool get isUpdate => widget.requisito != null;

  Widget _buildAddButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            saveRequisito();
          }
        },
        child: Text(
          isUpdate
          ? "Actualizar"
          : "Guardar", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  void saveRequisito(){
    int idNorma =context.read<CardRequisitoProvider>().id!;
    RequisitoModel requisitoModel=RequisitoModel(
      id : isUpdate 
      ? widget.requisito!.id 
      : null,
      nombre: _nombreController.text.trim(), 
      texto: _textoController.text.trim(), 
      interpretacion: _interpretacionController.text.trim(), 
      evidencia: _evidenciaController.text.trim(), 
      periodicidad: _periodicidadController.text.trim(),
      idNorma: idNorma
    );
      
      (isUpdate 
      ? context.read<CardRequisitoProvider>().updateRequisito(requisitoModel)
      : context.read<CardRequisitoProvider>().addRequisito(requisitoModel)
      ).then((res){
      if(res>0){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.cyan,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(16),
            ),
            content: Row(
              children: [
                Icon(Icons.check_circle,color:Colors.white),
                SizedBox(width: 10,),
                Text(
                  isUpdate
                  ? "Requisito actualizado..."
                  : "Requisito registrado..."),
              ],
            ),
          ),
        );
        Navigator.pop(context, true);
      }
    });
  }

  @override void initState() {
    super.initState();
     if (isUpdate) {
      _nombreController.text = widget.requisito!.nombre;
      _textoController.text = widget.requisito!.texto;
      _interpretacionController.text = widget.requisito!.interpretacion;
      _evidenciaController.text =widget.requisito!.evidencia;
      _periodicidadController.text=widget.requisito!.periodicidad;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardRequisitoProvider = context.watch<CardRequisitoProvider>();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                isUpdate
                ? "Actualizar requisito"
                : "Registrar requisito", style: TextStyle(fontSize: 22)),
              SizedBox(height: 12),
              FieldWidget(
                controller: _nombreController,
                hintText: "Ingresa nombre",
                validator: ((p0) {
                  if (p0 == null || p0.isEmpty) {
                      return "El nombre es obligatorio";
                    } else {
                      return null;
                    }
                }),
              ),
              
              FieldWidget(
                controller: _textoController,
                maxLines: 3,
                hintText: "Ingresa el texto",
                 validator: ((p0) {
                  if (p0 == null || p0.isEmpty) {
                      return "El texto es obligatorio";
                    } else {
                      return null;
                    }
                }),
              ),

              FieldWidget(
                controller: _interpretacionController,
                maxLines: 3,
                hintText: "Ingresa la interpretación",
                 validator: ((p0) {
                  if (p0 == null || p0.isEmpty) {
                      return "La interpretación es obligatoria";
                    } else {
                      return null;
                    }
                }),
              ),

              FieldWidget(
                controller: _evidenciaController,
                maxLines: 3,
                hintText: "Ingresa la evidencia",
                 validator: ((p0) {
                  if (p0 == null || p0.isEmpty) {
                      return "La evidencia es obligatoria";
                    } else {
                      return null;
                    }
                }),
              ),

              FieldWidget(
                controller: _periodicidadController,
                maxLines: 3,
                hintText: "Ingresa la periodicidad",
                 validator: ((p0) {
                  if (p0 == null || p0.isEmpty) {
                      return "La periodicidad es obligatoria";
                    } else {
                      return null;
                    }
                }),
              ),

              SizedBox(height: 8),
          
              _buildAddButton(),
            ],
          ),
        ),
      ),
    );
  }
}