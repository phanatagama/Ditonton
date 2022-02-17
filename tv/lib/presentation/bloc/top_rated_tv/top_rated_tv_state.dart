part of 'top_rated_tv_cubit.dart';

class TopRatedTvSeriesState extends Equatable {
  const TopRatedTvSeriesState();

  @override
  List<Object> get props => [];
}

class TopRatedTvSeriesEmpty extends TopRatedTvSeriesState {}

class TopRatedTvSeriesLoading extends TopRatedTvSeriesState {}

class TopRatedTvSeriesError extends TopRatedTvSeriesState {
  final String message;

  const TopRatedTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTvSeriesHasData extends TopRatedTvSeriesState {
  final List<TVSeries> result;

  const TopRatedTvSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
