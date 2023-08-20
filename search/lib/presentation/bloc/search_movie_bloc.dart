import 'package:bloc/bloc.dart';

import 'package:movies/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/presentation/bloc/utils.dart';


part 'search_movie_event.dart';

part 'search_movie_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMovies _searchMovies;

  SearchMoviesBloc(this._searchMovies) : super(SearchMoviesEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchMoviesLoading());
      final result = await _searchMovies.execute(query);

      result.fold(
        (failure) {
          emit(SearchMoviesError(failure.message));
        },
        (data) {
          emit(SearchMoviesHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
