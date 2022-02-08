import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/usecases/tv/search_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTVSeries usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = SearchTVSeries(mockTVSeriesRepository);
  });

  final tTVSeries = <TVSeries>[];
  final tQuery = 'Spiderman';

  test('should get list of TVSeries from the repository', () async {
    // arrange
    when(mockTVSeriesRepository.searchTVSeries(tQuery))
        .thenAnswer((_) async => Right(tTVSeries));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTVSeries));
  });
}
