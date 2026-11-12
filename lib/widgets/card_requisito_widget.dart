import 'package:flutter/material.dart';
import 'package:hermes/models/generic_modal.dart';
import 'package:hermes/models/requisito_model.dart';
import 'package:hermes/providers/card_requisito_provider.dart';
import 'package:hermes/widgets/register_requisito_widget.dart';
import 'package:provider/provider.dart';

class CardRequisitoWidget extends StatelessWidget {
  RequisitoModel requisitoModel;

  CardRequisitoWidget({super.key, required this.requisitoModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(requisitoModel.nombre,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  Text(requisitoModel.interpretacion),
                ],
              ),
            ),

            const SizedBox(width: 10),

            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Evidencia:',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),maxLines: 3,),
                Text(requisitoModel.evidencia,maxLines: 3), 
                Text('Periodicidad: ', style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),maxLines: 3,),
                Text(requisitoModel.periodicidad,maxLines: 3,),

              ],
            ),

            Column(
                children: [
                IconButton(onPressed: () async{
                                      
                final rpta= await GenericModal.show(
                  context: context, 
                  child: RegisterRequisitoWidget(requisito: requisitoModel,),
                  );
                  if (rpta==true){
                    context.read<CardRequisitoProvider>().getRequisitos();
                  }
                },
                icon: Icon(Icons.edit,size: 30,color: Colors.lightBlue,),
                
                ),

              ],
            )

          ],
        ),
      ),
    );

  }
}