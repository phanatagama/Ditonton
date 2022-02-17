import 'package:bloc/bloc.dart';
import 'package:movies/movies.dart';
import 'package:equatable/equatable.dart';

part 'popular_movies_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  final GetPopularMovies _popularMovies;

  PopularMoviesCubit(this._popularMovies) : super(PopularMoviesEmpty());

  Future<void> getPopularMovies() async {
    emit(PopularMoviesLoading());
    final result = await _popularMovies.execute();

    result.fold(
      (failure) {
        emit(PopularMoviesError(failure.message));
      },
      (moviesData) {
        emit(PopularMoviesHasData(moviesData));
      },
    );
  }
}
