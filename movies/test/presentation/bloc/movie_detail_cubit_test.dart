import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_cubit.dart';

import '../../../test/dummy_data/dummy_objects.dart';
import 'movie_detail_cubit_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MovieDetailCubit movieDetailCubit;
  late MockGetMovieDetail mockMovieDetail;

  setUp(() {
    mockMovieDetail = MockGetMovieDetail();
    movieDetailCubit = MovieDetailCubit(mockMovieDetail);
  });

  test('initial state should be empty', () {
    expect(movieDetailCubit.state, MovieDetailEmpty());
  });

  const tId = 1;

  blocTest<MovieDetailCubit, MovieDetailState>(
    'Should emit [Loading, HasData] when data of movie detail is gotten successfully',
    build: () {
      when(mockMovieDetail.execute(tId))
          .thenAnswer((_) async => Right(testMovieDetail));
      return movieDetailCubit;
    },
    act: (cubit) => cubit.getMovieDetail(tId),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailHasData(testMovieDetail),
    ],
    verify: (cubit) {
      verify(mockMovieDetail.execute(tId));
    },
  );

  blocTest<MovieDetailCubit, MovieDetailState>(
    'Should emit [Loading, Error] when get get movie detail is unsuccessful',
    build: () {
      when(mockMovieDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieDetailCubit;
    },
    act: (cubit) => cubit.getMovieDetail(tId),
    expect: () => [
      MovieDetailLoading(),
      const MovieDetailError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockMovieDetail.execute(tId));
    },
  );
}
