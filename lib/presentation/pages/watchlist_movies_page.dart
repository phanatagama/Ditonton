import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/widgets/card_list.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<WatchlistMovieNotifier>(context, listen: false)
          .fetchWatchlistMovies();
      // Provider.of<WatchlistTVSeriesNotifier>(context, listen: false)
      //     .fetchWatchlistTVSeries();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    // Provider.of<WatchlistTVSeriesNotifier>(context, listen: false)
    //     .fetchWatchlistTVSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<WatchlistMovieNotifier>(
          builder: (context, data, child) {
            if (data.watchlistState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.watchlistState == RequestState.Loaded) {
              if (data.watchlistMovies.isEmpty)
                return Center(
                  child: Text("Empty", style: kBodyText),
                );
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.watchlistMovies[index];
                  return MovieCardList(movie);
                },
                itemCount: data.watchlistMovies.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
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
