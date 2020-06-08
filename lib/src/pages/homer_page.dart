import 'package:flutter/material.dart';
import 'package:peliculaapp/src/providers/peliculas_provider.dart';
import 'package:peliculaapp/src/search/search_delegate.dart';
import 'package:peliculaapp/src/widgets/card_swiper_widget.dart';
import 'package:peliculaapp/src/widgets/movie_horizontal_widget.dart';


class HomePage extends StatelessWidget {
  final _peliculasProvider = new PeliculasProvider();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _peliculasProvider.getPopulares();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Películas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: DataSearch()
                );
              }
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTrajetas(),
            _footer(context),
          ],
        ),
      )
    );
  }
  Widget _swiperTrajetas() {
    return FutureBuilder(
      future: _peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        }
        return Container(
          height: 400.0,
          child: Center(
            child: CircularProgressIndicator()
          ),
        );
      }
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Populares',
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          SizedBox(height: 5.0,),
          StreamBuilder(
            stream: _peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if(snapshot.hasData){
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: _peliculasProvider.getPopulares,
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}