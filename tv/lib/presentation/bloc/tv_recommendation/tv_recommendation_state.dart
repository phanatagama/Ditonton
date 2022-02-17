part of 'tv_recommendation_cubit.dart';

abstract class TvSeriesDetailRecommendationsState extends Equatable {
  const TvSeriesDetailRecommendationsState();

  @override
  List<Object> get props => [];
}

class TvSeriesDetailRecommendationsEmpty
    extends TvSeriesDetailRecommendationsState {}

class TvSeriesDetailRecommendationsLoading
    extends TvSeriesDetailRecommendationsState {}

class TvSeriesDetailRecommendationsError
    extends TvSeriesDetailRecommendationsState {
  final String message;

  const TvSeriesDetailRecommendationsError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSeriesDetailRecommendationsHasData
    extends TvSeriesDetailRecommendationsState {
  final List<TVSeries> recommendations;

  const TvSeriesDetailRecommendationsHasData(this.recommendations);

  @override
  List<Object> get props => [recommendations];
}
