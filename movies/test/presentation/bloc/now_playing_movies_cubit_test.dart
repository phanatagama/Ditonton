import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import 'now_playing_movies_cubit_test.mocks.dart';


@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingMoviesCubit nowPlayingMoviesCubit;
  late MockGetNowPlayingMovies mockNowPlayingMovies;

  setUp(() {
    mockNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMoviesCubit = NowPlayingMoviesCubit(mockNowPlayingMovies);
  });

  test('initial state should be empty', () {
    expect(nowPlayingMoviesCubit.state, NowPlayingMoviesEmpty());
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

  blocTest<NowPlayingMoviesCubit, NowPlayingMoviesState>(
    'Should emit [Loading, HasData] when data of nowPlaying movies is gotten successfully',
    build: () {
      when(mockNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return nowPlayingMoviesCubit;
    },
    act: (cubit) => cubit.getNowPlayingMovies(),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesHasData(tMovieList),
    ],
    verify: (cubit) {
      verify(mockNowPlayingMovies.execute());
    },
  );

  blocTest<NowPlayingMoviesCubit, NowPlayingMoviesState>(
    'Should emit [Loading, Error] when get get nowPlaying movies is unsuccessful',
    build: () {
      when(mockNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return nowPlayingMoviesCubit;
    },
    act: (cubit) => cubit.getNowPlayingMovies(),
    expect: () => [
      NowPlayingMoviesLoading(),
      const NowPlayingMoviesError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockNowPlayingMovies.execute());
    },
  );
}