import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetNowPlayingTVSeries {
  final TVSeriesRepository repository;

  GetNowPlayingTVSeries(this.repository);

  Future<Either<Failure, List<TVSeries>>> execute() {
    return repository.getNowPlayingTVSeries();
  }
}
