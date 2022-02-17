part of 'watchlist_tv_cubit.dart';

class WatchlistTvSeriesState extends Equatable {
  const WatchlistTvSeriesState();

  @override
  List<Object> get props => [];
}

class WatchlistTvSeriesEmpty extends WatchlistTvSeriesState {}

class WatchlistTvSeriesLoading extends WatchlistTvSeriesState {}

class WatchlistTvSeriesError extends WatchlistTvSeriesState {
  final String message;

  const WatchlistTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvSeriesHasData extends WatchlistTvSeriesState {
  final List<TVSeries> result;

  const WatchlistTvSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvSeriesWatchlistState extends WatchlistTvSeriesState {
  bool isAddedToWatchlist = false;

  TvSeriesWatchlistState(this.isAddedToWatchlist);

  @override
  List<Object> get props => [isAddedToWatchlist];
}
