import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_cubit_test.mocks.dart';

@GenerateMocks([GetTVSeriesDetail])
void main() {
  late TvSeriesDetailCubit tvSeriesDetailCubit;
  late MockGetTVSeriesDetail mockTvSeriesDetail;

  setUp(() {
    mockTvSeriesDetail = MockGetTVSeriesDetail();
    tvSeriesDetailCubit = TvSeriesDetailCubit(mockTvSeriesDetail);
  });

  test('initial state should be empty', () {
    expect(tvSeriesDetailCubit.state, TvSeriesDetailEmpty());
  });

  const tId = 1;

  blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
    'Should emit [Loading, HasData] when data of tvSeries detail is gotten successfully',
    build: () {
      when(mockTvSeriesDetail.execute(tId))
          .thenAnswer((_) async => Right(testTVSeriesDetail));
      return tvSeriesDetailCubit;
    },
    act: (cubit) => cubit.getTvSeriesDetail(tId),
    expect: () => [
      TvSeriesDetailLoading(),
      TvSeriesDetailHasData(testTVSeriesDetail),
    ],
    verify: (cubit) {
      verify(mockTvSeriesDetail.execute(tId));
    },
  );

  blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
    'Should emit [Loading, Error] when get get tvSeries detail is unsuccessful',
    build: () {
      when(mockTvSeriesDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesDetailCubit;
    },
    act: (cubit) => cubit.getTvSeriesDetail(tId),
    expect: () => [
      TvSeriesDetailLoading(),
      const TvSeriesDetailError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockTvSeriesDetail.execute(tId));
    },
  );
}