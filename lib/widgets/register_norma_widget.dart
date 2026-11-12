import 'package:flutter/material.dart';
import 'package:hermes/data/data_general.dart';
import 'package:hermes/models/norma_model.dart';
import 'package:hermes/providers/card_norma_provider.dart';
import 'package:hermes/widgets/dropdown_widget.dart';
import 'package:hermes/widgets/field_widget.dart';
import 'package:hermes/widgets/item_type_widget.dart';
import 'package:logger/web.dart';
import 'package:provider/provider.dart';

class RegisterNormaWidget extends StatefulWidget {
  final NormaModel? norma;
  RegisterNormaWidget({super.key, this.norma});

  @override
  State<RegisterNormaWidget> createState() => _RegisterNormaWidgetState();
}

class _RegisterNormaWidgetState extends State<RegisterNormaWidget> {
  final _formKey = GlobalKey<FormState>();
  Logger logger=Logger();

  TextEditingController _numController = TextEditingController();
  TextEditingController _sumController = TextEditingController();
  TextEditingController _fechPubController = TextEditingController();
  TextEditingController _fechEntVigController = TextEditingController();
  String typeSelected = "Legal";
  bool get isUpdate => widget.norma != null;
  int? identificadorId;
  String? identificadorName;
  String? identificadorSeleccionado;

  Widget _buildAddButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            saveNorma();
          }
        },
        child: Text(
          isUpdate
          ? "Actualizar"
          : "Guardar", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  void saveNorma(){
    NormaModel normaModel=NormaModel(
      id : isUpdate 
      ? widget.norma!.id 
      : null,
      numNorma: _numController.text.trim(), 
      ideNorma: identificadorSeleccionado ?? "Ley",
      sumNorma: _sumController.text.trim(), 
      fechPubNorma: _fechPubController.text.trim(), 
      fechEntVigencia: _fechEntVigController.text.trim(),
      type: typeSelected,
      );

      (isUpdate 
      ? context.read<CardNormaProvider>().updateNorma(normaModel)
      : context.read<CardNormaProvider>().addNorma(normaModel)
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
                  ? "Norma actualizada..."
                  : "Norma registrada..."
                  ),
              ],
            ),
          ),
        );
        
        Navigator.pop(context, true);
      }
    });
  }

  void showSelectorFecha(TextEditingController editingController) async {
    DateTime? selectDay = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
      helpText: "Selecciona una fecha",
      cancelText: "Cancelar",
      confirmText: "Aceptar",
      fieldHintText: "dd/mm/aaaa",
      fieldLabelText: "Fecha",
      // Para deshabilitar algunos días
     /*  selectableDayPredicate: (day) {
        return day.weekday != DateTime.sunday;
      }, */
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.cyan, 
              onPrimary: Colors.red, 
              onSurface: Colors.blue,
            ),
            dialogTheme: DialogThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(45),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (selectDay != null) {
        editingController.text =
          "${selectDay.day}/${selectDay.month}/${selectDay.year}";
    }
    setState(() {});
  }

  @override void initState() {
    super.initState();

     if (isUpdate) {
      _numController.text = widget.norma!.numNorma;
      identificadorSeleccionado = widget.norma!.ideNorma;
      _sumController.text = widget.norma!.sumNorma;
      _fechPubController.text =widget.norma!.fechPubNorma;
      _fechEntVigController.text=widget.norma!.fechEntVigencia;
      typeSelected=widget.norma!.type;
    }

  }

  @override
  Widget build(BuildContext context) {
    final cardNormaProvider = context.watch<CardNormaProvider>();
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
                ? "Actualizar norma"
                : "Registrar norma", style: TextStyle(fontSize: 22)),
              SizedBox(height: 12),
              
              DropdownWidget(
                items: identificador,
                valueKey: 'id',
                textKey: 'name',
                returnKey: 'name',
                selectedValue: identificadorSeleccionado,
                label: 'Identificador',
                onChanged: (item) {
                  setState(() {
                    identificadorSeleccionado = item;
                  });
                },
              ),

              FieldWidget(
                controller: _numController,
                hintText: "Ingresa número",
                validator: ((p0) {
                  if (p0 == null || p0.isEmpty) {
                      return "El número es obligatorio";
                    } else {
                      return null;
                    }
                }),
              ),
              

              FieldWidget(
                controller: _sumController,
                maxLines:3,
                hintText: "Ingresa la sumilla",
                 validator: ((p0) {
                  if (p0 == null || p0.isEmpty) {
                      return "La sumilla es obligatoria";
                    } else {
                      return null;
                    }
                }),
              ),

              FieldWidget(
                controller: _fechPubController,
                hintText: "Ingresa la fecha de publicación",
                function: ()=> showSelectorFecha(_fechPubController),
                 validator: ((p0) {
                  if (p0 == null || p0.isEmpty) {
                      return "La fecha publicación es obligatoria";
                    } else {
                      return null;
                    }
                }),
              ),

              FieldWidget(
                controller: _fechEntVigController,
                hintText: "Ingresa la fecha de entrada en vigencia",
                function: () => showSelectorFecha(_fechEntVigController),
                 validator: ((p0) {
                  if (p0 == null || p0.isEmpty) {
                      return "La fecha de entrada en vigencia es obligatoria";
                    } else {
                      return null;
                    }
                }),
              ),
          
              Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: types
                      .map(
                        (type) => ItemTypeWidget(
                          data: type,
                          isSelected: typeSelected == type["tipo"] ? true : false,
                          tap: () {
                            typeSelected = type["tipo"];
                            setState(() {});
                          },
                        ),
                      )
                      .toList(),
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