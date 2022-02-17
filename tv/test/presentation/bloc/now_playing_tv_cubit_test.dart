import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import 'now_playing_tv_cubit_test.mocks.dart';

@GenerateMocks([GetNowPlayingTVSeries])
void main() {
  late NowPlayingTvSeriesCubit nowPlayingTvSeriesCubit;
  late MockGetNowPlayingTVSeries mockNowPlayingTvSeries;

  setUp(() {
    mockNowPlayingTvSeries = MockGetNowPlayingTVSeries();
    nowPlayingTvSeriesCubit = NowPlayingTvSeriesCubit(mockNowPlayingTvSeries);
  });

  test('initial state should be empty', () {
    expect(nowPlayingTvSeriesCubit.state, NowPlayingTvSeriesEmpty());
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

  blocTest<NowPlayingTvSeriesCubit, NowPlayingTvSeriesState>(
    'Should emit [Loading, HasData] when data of Now Playing TV Series is gotten successfully',
    build: () {
      when(mockNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return nowPlayingTvSeriesCubit;
    },
    act: (cubit) => cubit.getNowPlayingTvSeries(),
    expect: () => [
      NowPlayingTvSeriesLoading(),
      NowPlayingTvSeriesHasData(tTvSeriesList),
    ],
    verify: (cubit) {
      verify(mockNowPlayingTvSeries.execute());
    },
  );

  blocTest<NowPlayingTvSeriesCubit, NowPlayingTvSeriesState>(
    'Should emit [Loading, Error] when get get nowPlaying movies is unsuccessful',
    build: () {
      when(mockNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return nowPlayingTvSeriesCubit;
    },
    act: (cubit) => cubit.getNowPlayingTvSeries(),
    expect: () => [
      NowPlayingTvSeriesLoading(),
      const NowPlayingTvSeriesError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockNowPlayingTvSeries.execute());
    },
  );
}
