import 'package:bloc/bloc.dart';
import 'package:core/utils/constants.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';
import 'package:movies/domain/usecases/remove_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist.dart';

part 'watchlist_movies_state.dart';

class WatchlistMoviesCubit extends Cubit<WatchlistMoviesState> {
  final GetWatchlistMovies _getWatchlistMovies;

  WatchlistMoviesCubit(this._getWatchlistMovies, this.getWatchListStatus, this.saveWatchlist, this.removeWatchlist) : super(WatchlistMoviesEmpty());

  Future<void> getWatchlistMovies() async {
    emit(WatchlistMoviesLoading());
    final result = await _getWatchlistMovies.execute();

    result.fold(
          (failure) {
        emit(WatchlistMoviesError(failure.message));
      },
          (moviesData) {
        emit(WatchlistMoviesHasData(moviesData));
      },
    );
  }

  String message = '';

  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    result
        ? message = watchlistAddSuccessMessage
        : message = watchlistRemoveSuccessMessage;
    emit(MovieWatchlistState(result));
  }

  Future<void> addWatchlist(MovieDetail movie) async {
    final result = await saveWatchlist.execute(movie);

    await result.fold(
          (failure) async {
        emit(MovieWatchlistState(false));
        message = failure.message;
      },
          (successMessage) async {
        emit(MovieWatchlistState(true));
        message = successMessage;
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async {
    final result = await removeWatchlist.execute(movie);

    await result.fold(
          (failure) async {
        emit(MovieWatchlistState(true));
        message = failure.message;
      },
          (successMessage) async {
        emit(MovieWatchlistState(false));
        message = successMessage;
      },
    );

    await loadWatchlistStatus(movie.id);
  }
}