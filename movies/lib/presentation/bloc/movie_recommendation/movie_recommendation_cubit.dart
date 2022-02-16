import 'package:bloc/bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'movie_recommendation_state.dart';

class MovieRecommendationsCubit
    extends Cubit<MovieRecommendationsState> {
  final GetMovieRecommendations _getMovieRecommendations;

  MovieRecommendationsCubit(this._getMovieRecommendations)
      : super(MovieRecommendationsEmpty());

  Future<void> getMovieRecommendations(int id) async {
    emit(MovieRecommendationsLoading());
    final recommendations = await _getMovieRecommendations.execute(id);

    recommendations.fold(
          (failure) {
        emit(MovieRecommendationsError(failure.message));
      },
          (moviesData) {
        emit(MovieRecommendationsHasData(moviesData));
      },
    );
  }
}