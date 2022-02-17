import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';
import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([TvSeriesDetailRecommendationsCubit])
void main() {
  late MockTvSeriesDetailRecommendationsCubit
      mockTvSeriesDetailRecommendationsCubit;

  setUp(() {
    mockTvSeriesDetailRecommendationsCubit =
        MockTvSeriesDetailRecommendationsCubit();
  });

  Widget _makeTestableWidgetDetailRecommendations() {
    return BlocProvider<TvSeriesDetailRecommendationsCubit>.value(
      value: mockTvSeriesDetailRecommendationsCubit,
      child: const MaterialApp(
        home: TVSeriesRecommendation(),
      ),
    );
  }

  group('tv series recommendations widget test', () {
    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      final expected = TvSeriesDetailRecommendationsLoading();

      when(mockTvSeriesDetailRecommendationsCubit.state).thenReturn(expected);
      when(mockTvSeriesDetailRecommendationsCubit.stream)
          .thenAnswer((_) => Stream.value(expected));

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidgetDetailRecommendations());

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });
  });
}
