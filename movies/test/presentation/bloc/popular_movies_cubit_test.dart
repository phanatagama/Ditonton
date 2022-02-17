import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_cubit_test.mocks.dart';
import 'package:movies/movies.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMoviesCubit popularMoviesCubit;
  late MockGetPopularMovies mockPopularMovies;

  setUp(() {
    mockPopularMovies = MockGetPopularMovies();
    popularMoviesCubit = PopularMoviesCubit(mockPopularMovies);
  });

  test('initial state should be empty', () {
    expect(popularMoviesCubit.state, PopularMoviesEmpty());
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];

  blocTest<PopularMoviesCubit, PopularMoviesState>(
    'Should emit [Loading, HasData] when data of popular movies is gotten successfully',
    build: () {
      when(mockPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return popularMoviesCubit;
    },
    act: (cubit) => cubit.getPopularMovies(),
    expect: () => [
      PopularMoviesLoading(),
      PopularMoviesHasData(tMovieList),
    ],
    verify: (cubit) {
      verify(mockPopularMovies.execute());
    },
  );

  blocTest<PopularMoviesCubit, PopularMoviesState>(
    'Should emit [Loading, Error] when get get popular movies is unsuccessful',
    build: () {
      when(mockPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularMoviesCubit;
    },
    act: (cubit) => cubit.getPopularMovies(),
    expect: () => [
      PopularMoviesLoading(),
      const PopularMoviesError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockPopularMovies.execute());
    },
  );
}
