part of 'movie_recommendation_cubit.dart';

abstract class MovieRecommendationsState extends Equatable {
  const MovieRecommendationsState();

  @override
  List<Object> get props => [];
}

class MovieRecommendationsEmpty extends MovieRecommendationsState {}

class MovieRecommendationsLoading
    extends MovieRecommendationsState {}

class MovieRecommendationsError extends MovieRecommendationsState {
  final String message;

  const MovieRecommendationsError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieRecommendationsHasData
    extends MovieRecommendationsState {
  final List<Movie> recommendations;

  const MovieRecommendationsHasData(this.recommendations);

  @override
  List<Object> get props => [recommendations];
}