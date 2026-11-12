import 'package:flutter/material.dart';
import 'package:hermes/widgets/drawer_widget.dart';

class HomePage extends StatelessWidget {
  const new({super.key});
@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor:Colors.white,
        centerTitle: true,
        title: Row(
          mainAxisSize: .min,
          children: [
            const SizedBox(width: 8),
            const Text(
              'Hermes',
              style: TextStyle(
                color: Color(0x0F06b713),
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage("assets/images/imagencentral.jpg"), 
            fit: BoxFit.cover,
            ),
          ),
        )
      ),
    );
  }

}