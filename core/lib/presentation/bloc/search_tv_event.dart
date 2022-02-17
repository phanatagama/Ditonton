part of 'search_tv_bloc.dart';

@immutable
abstract class SearchTVSeriesEvent extends Equatable {
  const SearchTVSeriesEvent();

  @override
  List<Object> get props => [];
}

class OnQueryTVSeriesChange extends SearchTVSeriesEvent {
  final String query;

  OnQueryTVSeriesChange(this.query);

  @override
  List<Object> get props => [query];
}
