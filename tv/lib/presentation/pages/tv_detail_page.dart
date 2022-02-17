import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/routes.dart';
import 'package:core/domain/entities/movie/genre.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv/presentation/bloc/tv_detail/tv_detail_cubit.dart';
import 'package:tv/presentation/bloc/tv_recommendation/tv_recommendation_cubit.dart';
import 'package:tv/presentation/bloc/watchlist_tv/watchlist_tv_cubit.dart';
import '../../domain/entities/tv_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TVSeriesDetailPage extends StatefulWidget {
  TVSeriesDetailPage({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  _TVSeriesDetailPageState createState() => _TVSeriesDetailPageState();
}

class _TVSeriesDetailPageState extends State<TVSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvSeriesDetailCubit>().getTvSeriesDetail(widget.id);
    context.read<WatchlistTvSeriesCubit>().loadWatchlistStatus(widget.id);
    context
        .read<TvSeriesDetailRecommendationsCubit>()
        .getTvSeriesDetailRecommendations(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<TvSeriesDetailCubit, TvSeriesDetailState>(
          builder: (ctx, state) {
            if (state is TvSeriesDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvSeriesDetailHasData) {
              final tvSeries = state.result;
              return DetailContent(tvSeries);
            } else {
              return Center(child: Text('Failed'));
            }
          },
        ),
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TVSeriesDetail tvSeries;

  DetailContent(this.tvSeries);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvSeries.name,
                              style: kHeading5,
                            ),
                            BlocBuilder<WatchlistTvSeriesCubit,
                                WatchlistTvSeriesState>(
                              builder: (context, state) {
                                if (state is TvSeriesWatchlistState) {
                                  return ElevatedButton(
                                    onPressed: () async {
                                      if (!state.isAddedToWatchlist) {
                                        await context
                                            .read<WatchlistTvSeriesCubit>()
                                            .addWatchlist(tvSeries);
                                      } else {
                                        await context
                                            .read<WatchlistTvSeriesCubit>()
                                            .removeFromWatchlist(tvSeries);
                                      }

                                      final message = context
                                          .read<WatchlistTvSeriesCubit>()
                                          .message;

                                      if (message ==
                                              watchlistAddSuccessMessage ||
                                          message ==
                                              watchlistRemoveSuccessMessage) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(message),
                                            duration: const Duration(
                                                milliseconds: 500),
                                          ),
                                        );
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Text(message),
                                            );
                                          },
                                        );
                                      }
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        state.isAddedToWatchlist
                                            ? const Icon(Icons.check)
                                            : const Icon(Icons.add),
                                        const Text('Watchlist'),
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            // ElevatedButton(
                            //   onPressed: () async {
                            //     if (!provider.isAddedToWatchlist) {
                            //       await provider.addWatchlist(tvSeries);
                            //     } else {
                            //       await provider.removeFromWatchlist(tvSeries);
                            //     }
                            //
                            //     final message = provider.watchlistMessage;
                            //
                            //     if (message ==
                            //             TVSeriesDetailNotifier
                            //                 .watchlistAddSuccessMessage ||
                            //         message ==
                            //             TVSeriesDetailNotifier
                            //                 .watchlistRemoveSuccessMessage) {
                            //       ScaffoldMessenger.of(context).showSnackBar(
                            //           SnackBar(content: Text(message)));
                            //     } else {
                            //       showDialog(
                            //           context: context,
                            //           builder: (context) {
                            //             return AlertDialog(
                            //               content: Text(message),
                            //             );
                            //           });
                            //     }
                            //   },
                            //   child: Row(
                            //     mainAxisSize: MainAxisSize.min,
                            //     children: [
                            //       provider.isAddedToWatchlist
                            //           ? const Icon(Icons.check)
                            //           : const Icon(Icons.add),
                            //       Text('Watchlist'),
                            //     ],
                            //   ),
                            // ),
                            Text(
                              _showGenres(tvSeries.genres),
                            ),
                            Text(
                              tvSeries.episodeRunTime.isNotEmpty
                                  ? getFormattedDurationFromList(
                                      tvSeries.episodeRunTime)
                                  : 'N/A',
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeries.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvSeries.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvSeries.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            TVSeriesRecommendation(),
                            // Consumer<TVSeriesDetailNotifier>(
                            //   builder: (context, data, child) {
                            //     if (data.recommendationState ==
                            //         RequestState.Loading) {
                            //       return Center(
                            //         child: CircularProgressIndicator(),
                            //       );
                            //     } else if (data.recommendationState ==
                            //         RequestState.Error) {
                            //       return Text(data.message);
                            //     } else if (data.recommendationState ==
                            //         RequestState.Loaded) {
                            //       return Container(
                            //         height: 150,
                            //         child: ListView.builder(
                            //           scrollDirection: Axis.horizontal,
                            //           itemBuilder: (context, index) {
                            //             final tvSeries =
                            //                 provider.tvRecommendations[index];
                            //             return Padding(
                            //               padding: const EdgeInsets.all(4.0),
                            //               child: InkWell(
                            //                 onTap: () {
                            //                   Navigator.pushReplacementNamed(
                            //                     context,
                            //                     TV_DETAIL_ROUTE,
                            //                     arguments: tvSeries.id,
                            //                   );
                            //                 },
                            //                 child: ClipRRect(
                            //                   borderRadius: BorderRadius.all(
                            //                     Radius.circular(8),
                            //                   ),
                            //                   child: CachedNetworkImage(
                            //                     imageUrl:
                            //                         'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
                            //                     placeholder: (context, url) =>
                            //                         Center(
                            //                       child:
                            //                           CircularProgressIndicator(),
                            //                     ),
                            //                     errorWidget:
                            //                         (context, url, error) =>
                            //                             Icon(Icons.error),
                            //                   ),
                            //                 ),
                            //               ),
                            //             );
                            //           },
                            //           itemCount:
                            //               provider.tvRecommendations.length,
                            //         ),
                            //       );
                            //     } else {
                            //       return Container();
                            //     }
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String getFormattedDurationFromList(List<int> runtimes) =>
      runtimes.map((runtime) => _showDuration(runtime)).join(", ");

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}

class TVSeriesRecommendation extends StatelessWidget {
  const TVSeriesRecommendation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvSeriesDetailRecommendationsCubit,
        TvSeriesDetailRecommendationsState>(
      builder: (context, state) {
        if (state is TvSeriesDetailRecommendationsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TvSeriesDetailRecommendationsHasData) {
          final recommendations = state.recommendations;
          return SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final tv = recommendations[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        TV_DETAIL_ROUTE,
                        arguments: tv.id,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
              itemCount: recommendations.length,
            ),
          );
        } else if (state is TvSeriesDetailRecommendationsError) {
          return Text(state.message);
        } else {
          return const Text('Something Went Wrong');
        }
      },
    );
  }
}
