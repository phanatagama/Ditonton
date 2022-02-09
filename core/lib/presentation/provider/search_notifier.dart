import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/usecases/tv/search_tv.dart';
import 'package:flutter/foundation.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/search_movies.dart';

class SearchNotifier extends ChangeNotifier {
  final SearchMovies searchMovies;
  final SearchTVSeries searchTVSeries;

  SearchNotifier({
    required this.searchMovies,
    required this.searchTVSeries,
  });

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Movie> _moviesSearchResult = [];
  List<Movie> get moviesSearchResult => _moviesSearchResult;

  List<TVSeries> _tvSeriesSearchResult = [];
  List<TVSeries> get tvSeriesSearchResult => _tvSeriesSearchResult;

  String _message = '';
  String get message => _message;

  void resetData() {
    _state = RequestState.Empty;
    _moviesSearchResult = [];
    _tvSeriesSearchResult = [];
    notifyListeners();
  }

  Future<void> fetchMovieSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchMovies.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _moviesSearchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTVSeriesSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTVSeries.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _tvSeriesSearchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
