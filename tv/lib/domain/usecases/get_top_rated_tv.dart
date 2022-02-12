import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetTopRatedTVSeries {
  final TVSeriesRepository repository;

  GetTopRatedTVSeries(this.repository);

  Future<Either<Failure, List<TVSeries>>> execute() {
    return repository.getTopRatedTVSeries();
  }
}
