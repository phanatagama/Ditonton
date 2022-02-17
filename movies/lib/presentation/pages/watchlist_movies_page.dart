import 'package:core/styles/text_styles.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:movies/presentation/bloc/watchlist_movies/watchlist_movies_cubit.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistMoviesCubit>().getWatchlistMovies();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistMoviesCubit>().getWatchlistMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMoviesCubit, WatchlistMoviesState>(
          builder: (context, state) {
            if (state is WatchlistMoviesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistMoviesHasData) {
              if (state.result.isNotEmpty) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.result[index];
                    return MovieCardList(movie);
                  },
                  itemCount: state.result.length,
                );
              }
              return Center(
                child: Text('Empty', style: kBodyText),
              );
            } else {
              return const Text('Failed');
            }
          },
        ),
        // Text(
        //   'TV Series',
        //   style: kHeading6,
        // ),
        // Consumer<WatchlistTVSeriesNotifier>(
        //   builder: (context, data, child) {
        //     if (data.watchlistState == RequestState.Loading) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else if (data.watchlistState == RequestState.Loaded) {
        //       if (data.watchlistTVSeries.isEmpty)
        //         return Center(
        //           child: Text("Empty", style: kBodyText),
        //         );
        //
        //       return ListView.builder(
        //         itemBuilder: (context, index) {
        //           final tvSeries = data.watchlistTVSeries[index];
        //
        //           return TVSeriesCardList(tvSeries);
        //         },
        //         itemCount: data.watchlistTVSeries.length,
        //       );
        //     } else {
        //       return Center(
        //         key: Key('error_message'),
        //         child: Text(data.message),
        //       );
        //     }
        //   },
        // ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
