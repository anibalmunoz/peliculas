import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = "7c635df5290cf4fc0e2ad74804db046b";
  final String _baseUrl = "api.themoviedb.org";
  final String _language = "es-ES";

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> moviesCast = {};
  int _popularPage = 0;

  MoviesProvider() {
    print("MoviesProvider inicializado");
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
    final jsonData = await _getJsonData("/$movieId/credits", _popularPage);
    final creditsResponse = CreditsResponse.fromJson(jsonData);
    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, "/3/movie/$endpoint", {"api_key": _apiKey, "languaje": _language, "page": "$page"});
    final response = await http.get(url);
    return response.body;
  }
}
