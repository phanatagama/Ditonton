import 'package:core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:tv/tv.dart';

class TVSeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  TVSeriesDetailNotifier({
    required this.getTVDetail,
    required this.getTVRecommendations,
    required this.getWatchListStatusTV,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  final GetTVSeriesDetail getTVDetail;
  final GetTVSeriesRecommendations getTVRecommendations;
  final GetWatchListStatusTVSeries getWatchListStatusTV;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  late TVSeriesDetail _tvDetail;
  TVSeriesDetail get tvDetail => _tvDetail;

  RequestState _tvState = RequestState.Empty;
  RequestState get tvState => _tvState;

  List<TVSeries> _tvRecommendations = [];
  List<TVSeries> get tvRecommendations => _tvRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTVDetail(int id) async {
    _tvState = RequestState.Loading;
    notifyListeners();

    final detailResult = await getTVDetail.execute(id);
    final recommendationResult = await getTVRecommendations.execute(id);

    detailResult.fold(
      (failure) {
        _tvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tv) {
        _recommendationState = RequestState.Loading;
        _tvDetail = tv;
        notifyListeners();

        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (tvs) {
            _recommendationState = RequestState.Loaded;
            _tvRecommendations = tvs;
          },
        );
        _tvState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TVSeriesDetail tv) async {
    final result = await saveWatchlist.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> removeFromWatchlist(TVSeriesDetail tv) async {
    final result = await removeWatchlist.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatusTV.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
