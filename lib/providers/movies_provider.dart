import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/now_playing_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = "7c635df5290cf4fc0e2ad74804db046b";
  final String _baseUrl = "api.themoviedb.org";
  final String _language = "es-ES";

  MoviesProvider() {
    print("MoviesProvider inicializado");
    getNowPlayingMovies();
  }

  getNowPlayingMovies() async {
    var url = Uri.https(_baseUrl, "/3/movie/now_playing", {"api_key": _apiKey, "languaje": _language, "page": "1"});
    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    print(nowPlayingResponse.results[1].title);
  }
}
