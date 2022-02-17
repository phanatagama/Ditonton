import 'package:core/styles/text_styles.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/watchlist_tv/watchlist_tv_cubit.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';

class WatchlistTVSeriesPage extends StatefulWidget {
  @override
  _WatchlistTVSeriesPageState createState() => _WatchlistTVSeriesPageState();
}

class _WatchlistTVSeriesPageState extends State<WatchlistTVSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistTvSeriesCubit>().getWatchlistTvSeries();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistTvSeriesCubit>().getWatchlistTvSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
          builder: (context, state) {
            if (state is WatchlistTvSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistTvSeriesHasData) {
              if (state.result.isNotEmpty) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tv = state.result[index];
                    return TVSeriesCardList(tv);
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
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
