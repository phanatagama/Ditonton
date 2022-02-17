import 'package:core/core.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/presentation/bloc/search_movie_bloc.dart';
import 'package:core/presentation/bloc/search_tv_bloc.dart';

import 'package:movies/movies.dart';
import 'package:tv/tv.dart';
import 'package:movies/domain/usecases/remove_watchlist.dart' as rwm;
import 'package:movies/domain/usecases/save_watchlist.dart' as swm;
import 'package:tv/domain/usecases/remove_watchlist.dart' as rwtv;
import 'package:tv/domain/usecases/save_watchlist.dart' as swtv;
// import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieDetailCubit(locator()),
  );
  locator.registerFactory(() => TvSeriesDetailCubit(locator()));
  locator.registerFactory(
    () => NowPlayingMoviesCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieRecommendationsCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesDetailRecommendationsCubit(
      locator(),
    ),
  );
  locator.registerFactory(() => NowPlayingTvSeriesCubit(locator()));
  locator.registerFactory(
    () => SearchMoviesBloc(locator()),
  );
  locator.registerFactory(
    () => SearchTVSeriesBloc(locator()),
  );
  locator.registerFactory(
    () => PopularMoviesCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMoviesCubit(locator(), locator(), locator(), locator()),
  );
  locator.registerFactory(
    () => PopularTvSeriesCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvSeriesCubit(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvSeriesCubit(locator(), locator(), locator(), locator()),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => GetNowPlayingTVSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTVSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTVSeries(locator()));
  locator.registerLazySingleton(() => GetTVSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTVSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => SearchTVSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => swm.SaveWatchlist(locator()));
  locator.registerLazySingleton(() => rwm.RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTVSeries(locator()));
  locator.registerLazySingleton(() => swtv.SaveWatchlist(locator()));
  locator.registerLazySingleton(() => rwtv.RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTVSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TVSeriesRepository>(
    () => TVSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TVSeriesRemoteDataSource>(
      () => TVSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVSeriesLocalDataSource>(
      () => TVSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => SSLPinning.client
      // http.Client()
      );
}
