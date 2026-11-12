import 'package:flutter/material.dart';
import 'package:hermes/pages/home_page.dart';
import 'package:hermes/pages/normas_page.dart';
import 'package:hermes/providers/card_norma_provider.dart';
import 'package:hermes/providers/card_requisito_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CardNormaProvider()),
        ChangeNotifierProvider(create: (context) => CardRequisitoProvider()),
      ],
      child: MaterialApp(
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}