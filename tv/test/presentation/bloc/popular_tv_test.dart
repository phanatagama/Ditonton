import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import 'popular_tv_test.mocks.dart';

@GenerateMocks([GetPopularTVSeries])
void main() {
  late PopularTvSeriesCubit popularTvSeriesCubit;
  late MockGetPopularTVSeries mockPopularTvSeries;

  setUp(() {
    mockPopularTvSeries = MockGetPopularTVSeries();
    popularTvSeriesCubit = PopularTvSeriesCubit(mockPopularTvSeries);
  });

  test('initial state should be empty', () {
    expect(popularTvSeriesCubit.state, PopularTvSeriesEmpty());
  });

  final testTVSeries = TVSeries(
    backdropPath: '/oKt4J3TFjWirVwBqoHyIvv5IImd.jpg',
    genreIds: const [18],
    id: 85552,
    name: 'Euphoria',
    overview:
        'A group of high school students navigate love and friendships in a world of drugs, sex, trauma, and social media.',
    popularity: 5201.673,
    posterPath: '/jtnfNzqZwN4E32FGGxx1YZaBWWf.jpg',
    voteAverage: 8.4,
    voteCount: 5455,
    firstAirDate: '2019-06-16',
    originalLanguage: 'en',
    originalName: 'Euphoria',
    originCountry: const ['US'],
  );
  final tTvSeriesList = <TVSeries>[testTVSeries];

  blocTest<PopularTvSeriesCubit, PopularTvSeriesState>(
    'Should emit [Loading, HasData] when data of popular movies is gotten successfully',
    build: () {
      when(mockPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return popularTvSeriesCubit;
    },
    act: (cubit) => cubit.getPopularTvSeries(),
    expect: () => [
      PopularTvSeriesLoading(),
      PopularTvSeriesHasData(tTvSeriesList),
    ],
    verify: (cubit) {
      verify(mockPopularTvSeries.execute());
    },
  );

  blocTest<PopularTvSeriesCubit, PopularTvSeriesState>(
    'Should emit [Loading, Error] when get popular movies is unsuccessful',
    build: () {
      when(mockPopularTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTvSeriesCubit;
    },
    act: (cubit) => cubit.getPopularTvSeries(),
    expect: () => [
      PopularTvSeriesLoading(),
      const PopularTvSeriesError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockPopularTvSeries.execute());
    },
  );
}
