
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';
import '../../helpers/test_helper.mocks.dart';


void main() {
  late GetWatchListStatusTVSeries usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetWatchListStatusTVSeries(mockTVSeriesRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockTVSeriesRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
