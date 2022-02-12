import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

class GetPopularTVSeries {
  final TVSeriesRepository repository;

  GetPopularTVSeries(this.repository);

  Future<Either<Failure, List<TVSeries>>> execute() {
    return repository.getPopularTVSeries();
  }
}
