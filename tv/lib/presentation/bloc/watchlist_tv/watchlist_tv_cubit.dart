import 'package:bloc/bloc.dart';
import 'package:core/utils/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_watchlist_status.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:tv/domain/usecases/remove_watchlist.dart';
import 'package:tv/domain/usecases/save_watchlist.dart';

part 'watchlist_tv_state.dart';

class WatchlistTvSeriesCubit extends Cubit<WatchlistTvSeriesState> {
  final GetWatchlistTVSeries _getWatchlistTvSeries;

  WatchlistTvSeriesCubit(this._getWatchlistTvSeries, this.getWatchListStatus,
      this.saveWatchlist, this.removeWatchlist)
      : super(WatchlistTvSeriesEmpty());

  Future<void> getWatchlistTvSeries() async {
    emit(WatchlistTvSeriesLoading());
    final result = await _getWatchlistTvSeries.execute();

    result.fold(
      (failure) {
        emit(WatchlistTvSeriesError(failure.message));
      },
      (moviesData) {
        emit(WatchlistTvSeriesHasData(moviesData));
      },
    );
  }

  String message = '';

  final GetWatchListStatusTVSeries getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    result
        ? message = watchlistAddSuccessMessage
        : message = watchlistRemoveSuccessMessage;
    emit(TvSeriesWatchlistState(result));
  }

  Future<void> addWatchlist(TVSeriesDetail tvSeries) async {
    final result = await saveWatchlist.execute(tvSeries);

    await result.fold(
      (failure) async {
        emit(TvSeriesWatchlistState(false));
        message = failure.message;
      },
      (successMessage) async {
        emit(TvSeriesWatchlistState(true));
        message = successMessage;
      },
    );

    await loadWatchlistStatus(tvSeries.id);
  }

  Future<void> removeFromWatchlist(TVSeriesDetail tvSeries) async {
    final result = await removeWatchlist.execute(tvSeries);

    await result.fold(
      (failure) async {
        emit(TvSeriesWatchlistState(true));
        message = failure.message;
      },
      (successMessage) async {
        emit(TvSeriesWatchlistState(false));
        message = successMessage;
      },
    );

    await loadWatchlistStatus(tvSeries.id);
  }
}
