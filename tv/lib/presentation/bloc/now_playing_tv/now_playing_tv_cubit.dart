import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

part 'now_playing_tv_state.dart';

class NowPlayingTvSeriesCubit extends Cubit<NowPlayingTvSeriesState> {
  final GetNowPlayingTVSeries _nowPlayingTvSeries;

  NowPlayingTvSeriesCubit(this._nowPlayingTvSeries) : super(NowPlayingTvSeriesEmpty());

  Future<void> getNowPlayingTvSeries() async {
    emit(NowPlayingTvSeriesLoading());
    final result = await _nowPlayingTvSeries.execute();

    result.fold(
          (failure) {
        emit(NowPlayingTvSeriesError(failure.message));
      },
          (tvData) {
        emit(NowPlayingTvSeriesHasData(tvData));
      },
    );
  }
}