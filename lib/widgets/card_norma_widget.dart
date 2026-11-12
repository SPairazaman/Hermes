import 'package:flutter/material.dart';
import 'package:hermes/models/generic_modal.dart';
import 'package:hermes/models/norma_model.dart';
import 'package:hermes/providers/card_norma_provider.dart';
import 'package:hermes/widgets/register_norma_widget.dart';
import 'package:provider/provider.dart';

class CardNormaWidget extends StatelessWidget {
  NormaModel normaModel;

  CardNormaWidget({super.key, required this.normaModel});

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
                  Text('${normaModel.ideNorma} ${normaModel.numNorma}',
                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                  Text(normaModel.sumNorma),
                ],
              ),
            ),

            const SizedBox(width: 10),

            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Fech. Pub. :',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                  Text(normaModel.fechPubNorma), 
                  SizedBox(height: 10,),
                  Text('Fech. Ent. Vig. : ', style: TextStyle(fontSize: 14)),
                  Text(normaModel.fechPubNorma),

              ],
            ),

            Column(
                children: [
                  IconButton(onPressed: () async{
                     Provider.of<CardNormaProvider>(
                      context,
                      listen: false,
                    ).setNormaId(normaModel.id!);
                                        
                    final rpta= await GenericModal.show(
                          context: context, 
                          child: RegisterNormaWidget(norma: normaModel,),
                          );
                          if (rpta==true){
                            context.read<CardNormaProvider>().getNormas();
                          }
                  },
                  icon: Icon(Icons.edit,size: 30,color: Colors.lightBlue,),
                  
                  ),

                  
                ],
              ),
             
          ],
        ),
      ),
    );
  }
}