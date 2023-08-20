part of 'search_tv_bloc.dart';

@immutable
abstract class SearchTVSeriesState extends Equatable {}

class SearchTVSeriesInitial extends SearchTVSeriesState {
  @override
  List<Object> get props => [];
}

class SearchTVSeriesEmpty extends SearchTVSeriesState {
  @override
  List<Object> get props => [];
}

class SearchTVSeriesLoading extends SearchTVSeriesState {
  @override
  List<Object> get props => [];
}

class SearchTVSeriesError extends SearchTVSeriesState {
  final String message;

  SearchTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchTVSeriesHasData extends SearchTVSeriesState {
  final List<TVSeries> result;

  SearchTVSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
