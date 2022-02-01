import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVSeriesRecommendations usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetTVSeriesRecommendations(mockTVSeriesRepository);
  });

  final tId = 1;
  final tTVSeries = <TVSeries>[];

  test('should get list of TVSeries recommendations from the repository',
      () async {
    // arrange
    when(mockTVSeriesRepository.getTVSeriesRecommendations(tId))
        .thenAnswer((_) async => Right(tTVSeries));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTVSeries));
  });
}
