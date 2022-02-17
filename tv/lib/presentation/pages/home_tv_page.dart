import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/bloc/now_playing_tv/now_playing_tv_cubit.dart';
import 'package:tv/presentation/bloc/popular_tv/popular_tv_cubit.dart';
import 'package:tv/presentation/bloc/top_rated_tv/top_rated_tv_cubit.dart';

class HomeTVPage extends StatefulWidget {
  @override
  _HomeTVPageState createState() => _HomeTVPageState();
}

class _HomeTVPageState extends State<HomeTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PopularTvSeriesCubit>().getPopularTvSeries();
      context.read<TopRatedTvSeriesCubit>().getTopRatedTvSeries();
      context.read<NowPlayingTvSeriesCubit>().getNowPlayingTvSeries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Now Playing',
              style: kHeading6,
            ),
            NowPlayingTVSeries(),
            _buildSubHeading(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(context, POPULAR_TV_ROUTE),
            ),
            PopularTVSeries(),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(context, TOP_RATED_TV_ROUTE),
            ),
            TopRatedTVSeries(),
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TopRatedTVSeries extends StatelessWidget {
  const TopRatedTVSeries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
      builder: (context, state) {
        if (state is TopRatedTvSeriesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TopRatedTvSeriesHasData) {
          return TVSeriesList(state.result);
        } else {
          return const Text('Failed');
        }
      },
    );
  }
}

class PopularTVSeries extends StatelessWidget {
  const PopularTVSeries({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularTvSeriesCubit, PopularTvSeriesState>(
      builder: (context, state) {
        if (state is PopularTvSeriesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PopularTvSeriesHasData) {
          return TVSeriesList(state.result);
        } else {
          return const Text('Failed');
        }
      },
    );
  }
}

class NowPlayingTVSeries extends StatelessWidget {
  const NowPlayingTVSeries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingTvSeriesCubit, NowPlayingTvSeriesState>(
      builder: (context, state) {
        if (state is NowPlayingTvSeriesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NowPlayingTvSeriesHasData) {
          return TVSeriesList(state.result);
        } else {
          return const Text('Failed');
        }
      },
    );
  }
}

class TVSeriesList extends StatelessWidget {
  final List<TVSeries> tvSeries;

  TVSeriesList(this.tvSeries);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TV_DETAIL_ROUTE,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
