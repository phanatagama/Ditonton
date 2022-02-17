import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';
import 'home_page_test.mocks.dart';
import 'popular_tv_page_test.mocks.dart';
import 'top_rated_tv_page_test.mocks.dart';

@GenerateMocks([NowPlayingTvSeriesCubit])
void main() {
  late MockNowPlayingTvSeriesCubit mockNowPlayingTvSeriesCubit;
  late MockPopularTvSeriesCubit mockPopularTvSeriesCubit;
  late MockTopRatedTvSeriesCubit mockTopRatedTvSeriesCubit;

  setUp(() {
    mockNowPlayingTvSeriesCubit = MockNowPlayingTvSeriesCubit();
    mockPopularTvSeriesCubit = MockPopularTvSeriesCubit();
    mockTopRatedTvSeriesCubit = MockTopRatedTvSeriesCubit();
  });

  Widget _makeTestableWidgetNowPlaying() {
    return BlocProvider<NowPlayingTvSeriesCubit>.value(
      value: mockNowPlayingTvSeriesCubit,
      child: const MaterialApp(
        home: NowPlayingTVSeries(),
      ),
    );
  }

  Widget _makeTestableWidgetPopular() {
    return BlocProvider<PopularTvSeriesCubit>.value(
      value: mockPopularTvSeriesCubit,
      child: const MaterialApp(
        home: PopularTVSeries(),
      ),
    );
  }

  Widget _makeTestableWidgetTopRated() {
    return BlocProvider<TopRatedTvSeriesCubit>.value(
      value: mockTopRatedTvSeriesCubit,
      child: const MaterialApp(
        home: TopRatedTVSeries(),
      ),
    );
  }

  group('now playing widget test', () {
    testWidgets('Page should display center progress bar when loading',
            (WidgetTester tester) async {
          final expected = NowPlayingTvSeriesLoading();

          when(mockNowPlayingTvSeriesCubit.state).thenReturn(expected);
          when(mockNowPlayingTvSeriesCubit.stream)
              .thenAnswer((_) => Stream.value(expected));

          final progressBarFinder = find.byType(CircularProgressIndicator);
          final centerFinder = find.byType(Center);

          await tester.pumpWidget(_makeTestableWidgetNowPlaying());

          expect(centerFinder, findsOneWidget);
          expect(progressBarFinder, findsOneWidget);
        });

  });

  group('popular widget test', () {
    testWidgets('Page should display center progress bar when loading',
            (WidgetTester tester) async {
          final expected = PopularTvSeriesLoading();

          when(mockPopularTvSeriesCubit.state).thenReturn(expected);
          when(mockPopularTvSeriesCubit.stream)
              .thenAnswer((_) => Stream.value(expected));

          final progressBarFinder = find.byType(CircularProgressIndicator);
          final centerFinder = find.byType(Center);

          await tester.pumpWidget(_makeTestableWidgetPopular());

          expect(centerFinder, findsOneWidget);
          expect(progressBarFinder, findsOneWidget);
        });

  });

  group('top rated widget test', () {
    testWidgets('Page should display center progress bar when loading',
            (WidgetTester tester) async {
          final expected = TopRatedTvSeriesLoading();

          when(mockTopRatedTvSeriesCubit.state).thenReturn(expected);
          when(mockTopRatedTvSeriesCubit.stream)
              .thenAnswer((_) => Stream.value(expected));

          final progressBarFinder = find.byType(CircularProgressIndicator);
          final centerFinder = find.byType(Center);

          await tester.pumpWidget(_makeTestableWidgetTopRated());

          expect(centerFinder, findsOneWidget);
          expect(progressBarFinder, findsOneWidget);
        });
  });
}