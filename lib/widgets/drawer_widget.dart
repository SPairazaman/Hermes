import 'package:flutter/material.dart';
import 'package:hermes/pages/home_page.dart';
import 'package:hermes/pages/normas_page.dart';

class DrawerWidget extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                image: AssetImage("assets/images/logo_int.png"), // O AssetImage si es local
                fit: BoxFit.cover,
                ),
              ),
              child: const Text(
                  '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
             ListTile(
              leading: Icon(Icons.home),
              title: Text("Inicio"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()),);
              },
            ),
         
            ListTile(
              leading: Icon(Icons.book),
              title: Text("Requisitos"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>NormasPage()),);
              },
            ),
          ],
        ),
      );
  }
}