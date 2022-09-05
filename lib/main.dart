import 'package:flutter/material.dart';
import 'package:noticiasapp/pages/tabs_page.dart';
import 'package:noticiasapp/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Noticias',
      theme: miTema,
      home: TabsPage(),
    );
  }
}
