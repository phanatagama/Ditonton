part of 'watchlist_movies_cubit.dart';

class WatchlistMoviesState extends Equatable {
  const WatchlistMoviesState();

  @override
  List<Object> get props => [];
}

class WatchlistMoviesEmpty extends WatchlistMoviesState {}

class WatchlistMoviesLoading extends WatchlistMoviesState {}

class WatchlistMoviesError extends WatchlistMoviesState {
  final String message;

  const WatchlistMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMoviesHasData extends WatchlistMoviesState {
  final List<Movie> result;

  const WatchlistMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class MovieWatchlistState extends WatchlistMoviesState {
  bool isAddedToWatchlist = false;

  MovieWatchlistState(this.isAddedToWatchlist);

  @override
  List<Object> get props => [isAddedToWatchlist];
}
