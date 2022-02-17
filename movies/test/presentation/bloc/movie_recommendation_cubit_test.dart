import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/presentation/bloc/movie_recommendation/movie_recommendation_cubit.dart';

import 'movie_recommendation_cubit_test.mocks.dart';


@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieRecommendationsCubit movieRecommendationsCubit;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  const tId = 1;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecommendationsCubit = MovieRecommendationsCubit(mockGetMovieRecommendations);
  });

  test('initial state should be empty', () {
    expect(movieRecommendationsCubit.state, MovieRecommendationsEmpty());
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovieModel];

  blocTest<MovieRecommendationsCubit, MovieRecommendationsState>(
    'Should emit [Loading, HasData] when data of movie recommendations is gotten successfully',
    build: () {
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tMovieList));
      return movieRecommendationsCubit;
    },
    act: (cubit) => cubit.getMovieRecommendations(tId),
    expect: () => [
      MovieRecommendationsLoading(),
      MovieRecommendationsHasData(tMovieList),
    ],
    verify: (cubit) {
      verify(mockGetMovieRecommendations.execute(tId));
    },
  );

  blocTest<MovieRecommendationsCubit, MovieRecommendationsState>(
    'Should emit [Loading, Error] when get get movie recommendations movies is unsuccessful',
    build: () {
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieRecommendationsCubit;
    },
    act: (cubit) => cubit.getMovieRecommendations(tId),
    expect: () => [
      MovieRecommendationsLoading(),
      const MovieRecommendationsError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockGetMovieRecommendations.execute(tId));
    },
  );
}