import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingTVSeries usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetNowPlayingTVSeries(mockTVSeriesRepository);
  });

  final tTVSeries = <TVSeries>[];

  test('should get list of TVSeries from the repository', () async {
    // arrange
    when(mockTVSeriesRepository.getNowPlayingTVSeries())
        .thenAnswer((_) async => Right(tTVSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTVSeries));
  });
}
