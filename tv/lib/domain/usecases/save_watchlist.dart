import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';

import '../../tv.dart';

class SaveWatchlist {
  final TVSeriesRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TVSeriesDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
