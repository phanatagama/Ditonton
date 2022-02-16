import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

part 'popular_tv_state.dart';

class PopularTvSeriesCubit extends Cubit<PopularTvSeriesState> {
  final GetPopularTVSeries _popularTvSeries;

  PopularTvSeriesCubit(this._popularTvSeries) : super(PopularTvSeriesEmpty());

  Future<void> getPopularTvSeries() async {
    emit(PopularTvSeriesLoading());
    final result = await _popularTvSeries.execute();

    result.fold(
          (failure) {
        emit(PopularTvSeriesError(failure.message));
      },
          (moviesData) {
        emit(PopularTvSeriesHasData(moviesData));
      },
    );
  }
}