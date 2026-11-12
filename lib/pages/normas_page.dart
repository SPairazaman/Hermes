import 'package:flutter/material.dart';
import 'package:hermes/models/generic_modal.dart';
import 'package:hermes/models/norma_model.dart';
import 'package:hermes/pages/requisitos_page.dart';
import 'package:hermes/providers/card_norma_provider.dart';
import 'package:hermes/providers/card_requisito_provider.dart';
import 'package:hermes/widgets/card_norma_widget.dart';
import 'package:hermes/widgets/drawer_widget.dart';
import 'package:hermes/widgets/register_norma_widget.dart';
import 'package:logger/web.dart';
import 'package:provider/provider.dart';

class NormasPage extends StatefulWidget {
  const NormasPage({super.key});

  @override
  State<NormasPage> createState() => _NormasPageState();
}

class _NormasPageState extends State<NormasPage> {
  Logger logger = Logger();

  deleteNorma(NormaModel normaModel){
    context.read<CardNormaProvider>().deleteNorma(normaModel).then((value)
    {
      if (value>0){
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
                Text("Norma Eliminada..."),
              ],
            ),
          ),
        );
        context.read<CardNormaProvider>().getNormas();
      }
    }
  );
   
  }
  
  
  @override void initState() {
    context.read<CardNormaProvider>().getNormas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final providerNorma = context.watch<CardNormaProvider>();

    if (providerNorma.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final norma=providerNorma.normas;
    
   /*  if (norma.isEmpty) {
      return const Text("No se encontraron normas");
    }; */

    //logger.w(norma.isEmpty);

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
                'Normas',
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
                      child: RegisterNormaWidget(),
                      );
                      if (rpta==true){
                        context.read<CardNormaProvider>().getNormas();
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
                        Expanded(
                          child: ListView.builder(
                            itemCount: providerNorma.normas.length,
                            itemBuilder: (BuildContext context,int index){
                                NormaModel normaModel=providerNorma.normas[index];
                                return GestureDetector(
                                  onTap: (){
                                    Provider.of<CardRequisitoProvider>(
                                      context,
                                      listen: false,
                                    ).setId(normaModel.id!);

                                    Navigator.push(
                                      context, 
                                      MaterialPageRoute(builder: (context)=>RequisitosPage(normaModel: normaModel,))
                                      );
                                  },
                                  child: Dismissible(
                                    key: UniqueKey(),
                                    direction: .startToEnd,
                                    background: Container(
                                      color: Colors.lightGreen,
                                    ),
                                    onDismissed: (DismissDirection direccion){
                                      deleteNorma(normaModel);
                                    },
                                    child: CardNormaWidget(normaModel: normaModel),
                                  ),
                                );
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