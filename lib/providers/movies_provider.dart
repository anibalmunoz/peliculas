import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/helpers/debouncer.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/models/search_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = "7c635df5290cf4fc0e2ad74804db046b";
  final String _baseUrl = "api.themoviedb.org";
  final String _language = "es-ES";

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> moviesCast = {};
  int _popularPage = 0;

  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));
  final StreamController<List<Movie>> _suggestionsStreamController = StreamController.broadcast();
  Stream<List<Movie>> get suggestionsStream => _suggestionsStreamController.stream;

  MoviesProvider() {
    getOnDisplaygMovies();
    getPopularMovies();
  }

  getOnDisplaygMovies() async {
    final jsonData = await _getJsonData("now_playing");
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData("popular", _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMoviesCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    final jsonData = await _getJsonData("/$movieId/credits", _popularPage);
    final creditsResponse = CreditsResponse.fromJson(jsonData);
    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, "/3/movie/$endpoint", {"api_key": _apiKey, "languaje": _language, "page": "$page"});
    final response = await http.get(url);
    return response.body;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_baseUrl, "3/search/movie",
        {"api_key": _apiKey, "languaje": _language, "query": query, "include_adult": "true"});
    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);
    return searchResponse.results;
  }

  void getSuggestionsByQuery(String query) {
    debouncer.value = "";
    debouncer.onValue = (value) async {
      final results = await searchMovie(value);
      _suggestionsStreamController.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      debouncer.value = query;
    });

    Future.delayed(const Duration(milliseconds: 301)).then((value) => timer.cancel());
  }
}
