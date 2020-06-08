import 'dart:async';
import 'dart:convert';
import 'package:peliculaapp/src/models/actor_model.dart';
import 'package:peliculaapp/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProvider {
  String _apikey = 'su api key';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularesPage = 0;
  List<Pelicula> _populares = new List();
  bool _cargando = false;

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStream() {
    _popularesStreamController?.close();
  }



  Future<List<Pelicula>> _procersarRespuesta(Uri url) async {
    final resp = await http.get( url );
    final decodedData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

  Future<List<Pelicula>>getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key': _apikey,
      'language': _language,
    });
    return _procersarRespuesta(url);
  }

  Future<List<Pelicula>>getPopulares() async {
    if (_cargando) {
      return [];
    }
    _popularesPage++;
    _cargando = true;

    final url = Uri.https(_url, '3/movie/popular',{
      'api_key': _apikey,
      'language': _language,
      'page' : _popularesPage.toString()
    });
    final resp = await _procersarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);
    _cargando = false;
    return resp;
  }

  Future<List<Actor>> getCast(String peliId) async {
    final url  = Uri.https(_url, '3/movie/$peliId/credits',{
      'api_key': _apikey,
      'language': _language,
    });

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final cast = new Cast.fromJsonList(decodeData['cast']);
    return cast.actores;
  }

  Future<List<Pelicula>> BuscarPeliculas(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key'  : _apikey,
      'language' : _language,
      'query'    : query
    });
    return await _procersarRespuesta(url);
  }


}