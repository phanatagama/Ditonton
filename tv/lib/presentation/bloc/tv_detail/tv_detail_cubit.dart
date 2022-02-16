import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

part 'tv_detail_state.dart';

class TvSeriesDetailCubit extends Cubit<TvSeriesDetailState> {
  final GetTVSeriesDetail _getTvSeriesDetail;

  TvSeriesDetailCubit(this._getTvSeriesDetail)
      : super(TvSeriesDetailEmpty());

  Future<void> getTvSeriesDetail(int id) async {
    emit(TvSeriesDetailLoading());
    final result = await _getTvSeriesDetail.execute(id);

    result.fold(
          (failure) {
        emit(TvSeriesDetailError(failure.message));
      },
          (tvSeriesData) async {
        emit(TvSeriesDetailHasData(tvSeriesData));
      },
    );
  }
}