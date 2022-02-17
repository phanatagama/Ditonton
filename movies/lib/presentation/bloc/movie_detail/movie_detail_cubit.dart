import 'package:bloc/bloc.dart';
import 'package:movies/movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final GetMovieDetail _getMovieDetail;

  MovieDetailCubit(this._getMovieDetail) : super(MovieDetailEmpty());

  Future<void> getMovieDetail(int id) async {
    emit(MovieDetailLoading());
    final result = await _getMovieDetail.execute(id);

    result.fold(
      (failure) {
        emit(MovieDetailError(failure.message));
      },
      (movieData) async {
        emit(MovieDetailHasData(movieData));
      },
    );
  }
}
