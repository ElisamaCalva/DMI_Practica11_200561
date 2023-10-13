import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movieapp_200561/common/Constants.dart';
import 'package:movieapp_200561/model/Media.dart';

class HttpHandler {
  static final _httHandler = new HttpHandler();
  final String _baseUrl = "api.themoviedb.org";
  final String _language =
      "es-MX";

  static HttpHandler get(){
    return _httHandler;
  }

  Future<dynamic> getJson(Uri uri) async {
    http.Response response =
        await http.get(uri);
    return json.decode(response.body);
  }
  Future<List<Media>> fetchMovies() {
    var uri = new Uri.https(
        _baseUrl,
        "3/movie/popular",
        {
          'api_key': API_KEY,
          'page': "1",
          'languaje': _language
        });
    return getJson(uri).then(((data) =>
        data['results'].map<Media>((item) => new Media(item, MediaType.movie)).toList()));
  }
  Future<List<Media>> fetchShow() {
    var uri = new Uri.https(
        _baseUrl,
        "3/tv/popular", 
        {
          'api_key': API_KEY,
          'page': "1",
          'languaje': _language
        });
    return getJson(uri).then(((data) =>
        data['results'].map<Media>((item) => new Media(item, MediaType.show)).toList()));
  }
}