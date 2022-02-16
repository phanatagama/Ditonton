import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/search_tv.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTVSeriesBloc extends Bloc<SearchTVSeriesEvent, SearchTVSeriesState> {
  final SearchTVSeries _searchTVSeries;

  SearchTVSeriesBloc(this._searchTVSeries) : super(SearchTVSeriesInitial()) {
    on<OnQueryTVSeriesChange>(_onQueryTVSeriesChange);
  }

  FutureOr<void> _onQueryTVSeriesChange(
      OnQueryTVSeriesChange event, Emitter<SearchTVSeriesState> emit) async {
    final query = event.query;
    emit(SearchTVSeriesEmpty());

    final result = await _searchTVSeries.execute(query);

    result.fold(
          (failure) {
        emit(SearchTVSeriesError(failure.message));
      },
          (data) {
        data.isEmpty
            ? emit(SearchTVSeriesEmpty())
            : emit(SearchTVSeriesHasData(data));
      },
    );
  }

  @override
  Stream<SearchTVSeriesState> get stream =>
      super.stream.debounceTime(const Duration(milliseconds: 200));
}