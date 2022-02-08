import 'package:core/domain/repositories/tv_repository.dart';

class GetWatchListStatusTVSeries {
  final TVSeriesRepository repository;

  GetWatchListStatusTVSeries(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
