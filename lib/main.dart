import 'package:flutter/material.dart';
import 'package:noticiasapp/pages/tabs_page.dart';
import 'package:noticiasapp/services/news_service.dart';
import 'package:noticiasapp/theme/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NewsService(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Noticias',
        theme: miTema,
        home: TabsPage(),
      ),
    );
  }
}
