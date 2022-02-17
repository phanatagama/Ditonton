import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_recommendation_cubit_test.mocks.dart';

@GenerateMocks([GetTVSeriesRecommendations])
void main() {
  late TvSeriesDetailRecommendationsCubit tvSeriesDetailRecommendationsCubit;
  late MockGetTVSeriesRecommendations mockGetTVSeriesRecommendations;

  setUp(() {
    mockGetTVSeriesRecommendations = MockGetTVSeriesRecommendations();
    tvSeriesDetailRecommendationsCubit =
        TvSeriesDetailRecommendationsCubit(mockGetTVSeriesRecommendations);
  });

  final testTVSeriesRecommendations = TVSeries(
      backdropPath: "/phwgPLUIcv3sbI1xmkiurThR13Q.jpg",
      firstAirDate: "2021-11-14",
      genreIds: [16, 10765, 10759],
      id: 84553,
      name: "Blade Runner: Black Lotus",
      originCountry: ["US"],
      originalLanguage: "en",
      originalName: "Blade Runner: Black Lotus",
      overview:
      "Los Angeles 2032. A young woman wakes up with no memories, and possessing deadly skills. The only clues to her mystery are a locked data device and a tattoo of a black lotus. Putting together the pieces, she must hunt down the people responsible for her brutal and bloody past to find the truth of her lost identity.",
      popularity: 477.664,
      posterPath: "/zHQJkDZ4OjqJnp4vtphxOQ7GIh6.jpg",
      voteAverage: 7.6,
      voteCount: 68
  );
  final tTvSeriesListRecommendations = <TVSeries>[testTVSeriesRecommendations];

  test('initial state should be empty', () {
    expect(tvSeriesDetailRecommendationsCubit.state, TvSeriesDetailRecommendationsEmpty());
  });

  const tId = 1;

  blocTest<TvSeriesDetailRecommendationsCubit,
      TvSeriesDetailRecommendationsState>(
    'Should emit [Loading, HasData] when data of tvSeries detail is gotten successfully',
    build: () {
      when(mockGetTVSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvSeriesListRecommendations));
      return tvSeriesDetailRecommendationsCubit;
    },
    act: (cubit) => cubit.getTvSeriesDetailRecommendations(tId),
    expect: () => [
      TvSeriesDetailRecommendationsLoading(),
      TvSeriesDetailRecommendationsHasData(testTVSeriesList),
    ],
    verify: (cubit) {
      verify(mockGetTVSeriesRecommendations.execute(tId));
    },
  );

  blocTest<TvSeriesDetailRecommendationsCubit,
      TvSeriesDetailRecommendationsState>(
    'Should emit [Loading, Error] when get get tvSeries detail is unsuccessful',
    build: () {
      when(mockGetTVSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesDetailRecommendationsCubit;
    },
    act: (cubit) => cubit.getTvSeriesDetailRecommendations(tId),
    expect: () => [
      TvSeriesDetailRecommendationsLoading(),
      const TvSeriesDetailRecommendationsError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockGetTVSeriesRecommendations.execute(tId));
    },
  );
}