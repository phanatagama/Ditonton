import 'package:bloc/bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_movies_state.dart';

class NowPlayingMoviesCubit extends Cubit<NowPlayingMoviesState> {
  final GetNowPlayingMovies _nowPlayingMovies;

  NowPlayingMoviesCubit(this._nowPlayingMovies)
      : super(NowPlayingMoviesEmpty());

  Future<void> getNowPlayingMovies() async {
    emit(NowPlayingMoviesLoading());
    final result = await _nowPlayingMovies.execute();

    result.fold(
      (failure) {
        emit(NowPlayingMoviesError(failure.message));
      },
      (moviesData) {
        emit(NowPlayingMoviesHasData(moviesData));
      },
    );
  }
}
