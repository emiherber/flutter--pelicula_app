import 'package:flutter/material.dart';
import 'package:peliculaapp/src/pages/homer_page.dart';
import 'package:peliculaapp/src/pages/pelicula_detail_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Películas',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'detalle': (BuildContext context) => PeliculaDetail(),
      },
    );
  }
}
