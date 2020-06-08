import 'package:flutter/material.dart';
import 'package:peliculaapp/src/models/pelicula_model.dart';
import 'package:peliculaapp/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  final peliculas = [
    'Spiderman1',
    'Spiderman2',
    'Spiderman3',
    'Spiderman4',
    'Spiderman5',
  ];

  final peliculasRecientes = [
    'Spiderman1',
    'Chaturbate'
  ];

  final peliculasProvider = new PeliculasProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones de nuestro appBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del appBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation
      ),
      onPressed: () {
        close(context, null);
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crear los resultados que vamos a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.BuscarPeliculas(query),
      builder: (BuildContext context,  AsyncSnapshot<List<Pelicula>> snapshot) {
        if(snapshot.hasData) {
          final peliculas = snapshot.data;
          return ListView(
             children: peliculas.map((pelicula) {
               return ListTile(
                 leading: FadeInImage(
                   image: NetworkImage(pelicula.getPosterImg()),
                   placeholder: AssetImage('assets/img/no-image.jpg'),
                   fit: BoxFit.contain,
                 ),
                 title: Text(pelicula.title),
                 subtitle: Text(pelicula.originalTitle),
                 onTap: () {
                   close(context, null);
                   pelicula.uniqueId = '';
                   Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                 },
               );
             }).toList(),
           );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }

}