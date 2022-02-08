import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/tv/tv_detail.dart';
import 'package:core/domain/repositories/tv_repository.dart';

class RemoveWatchlist {
  final TVSeriesRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TVSeriesDetail movie) {
    return repository.removeWatchlist(movie);
  }
}