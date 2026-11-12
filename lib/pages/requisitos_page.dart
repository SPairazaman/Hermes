import 'package:flutter/material.dart';
import 'package:hermes/models/generic_modal.dart';
import 'package:hermes/models/norma_model.dart';
import 'package:hermes/models/requisito_model.dart';
import 'package:hermes/providers/card_requisito_provider.dart';
import 'package:hermes/widgets/card_requisito_widget.dart';
import 'package:hermes/widgets/drawer_widget.dart';
import 'package:hermes/widgets/register_requisito_widget.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class RequisitosPage extends StatefulWidget {
  NormaModel normaModel;

  RequisitosPage({
    super.key,
    required this.normaModel,
  });

  @override
  State<RequisitosPage> createState() => _RequisitosPageState();
}

class _RequisitosPageState extends State<RequisitosPage> {
  List<RequisitoModel> requisitoModelList = [];

  Logger logger =Logger();

  @override
  Widget build(BuildContext context) {
    final providerRequisito = context.watch<CardRequisitoProvider>();

    if (providerRequisito.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    /* final requisito=providerRequisito.requisitos;
    if (requisito.isEmpty) {
      return const Text("No se encontraron requisitos");
    } */

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: DrawerWidget(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Row(
            mainAxisSize: .min,
            children: [
              const SizedBox(width: 8),
              const Text(
                'Detalle norma',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async{
                    final rpta= await GenericModal.show(
                      context: context, 
                      child: RegisterRequisitoWidget(),
                      );
                      if (rpta==true){
                        context.read<CardRequisitoProvider>().getRequisitos();
                      }
                  },
                  child: Container(
                    color: Colors.black,
                    width: double.infinity,
                    height: 110,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Agregar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: .start,
                          children: [
                            Text('${widget.normaModel.ideNorma} ${widget.normaModel.numNorma}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: .start,
                          children: [
                             Text('Fech. Pub. : ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                            Text(widget.normaModel.fechPubNorma), 

                          ],
                        ),
                        Row(
                          children: [
                            Text('Fech. Ent. Vig. : ', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                            Text(widget.normaModel.fechPubNorma),
                          ],
                        ),

                        Divider(),

                         Text(
                          'Requisitos:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Divider(),
                        
                        Expanded(
                          child: ListView.builder(
                            itemCount: providerRequisito.requisitos.length,
                            itemBuilder: (BuildContext context,int index){
                                RequisitoModel requisitoModel=providerRequisito.requisitos[index];
                                return CardRequisitoWidget(requisitoModel : requisitoModel);
                              },
                            ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 90),
              ],
            ),
          ],
        ),
      ),
    );


  }
}