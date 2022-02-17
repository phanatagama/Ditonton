import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:movies/presentation/bloc/now_playing_movies/now_playing_movies_cubit.dart';
import 'package:movies/presentation/bloc/popular_movies/popular_movies_cubit.dart';
import 'package:movies/presentation/bloc/top_rated_movies/top_rated_movies_cubit.dart';
import '../../domain/entities/movie.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingMoviesCubit>().getNowPlayingMovies();
      context.read<PopularMoviesCubit>().getPopularMovies();
      context.read<TopRatedMoviesCubit>().getTopRatedMovies();
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
            BlocBuilder<NowPlayingMoviesCubit, NowPlayingMoviesState>(
              builder: (context, state) {
                if (state is NowPlayingMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingMoviesHasData) {
                  return MovieList(state.result);
                } else {
                  return const Text('Failed');
                }
              },
            ),
            _buildSubHeading(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(context, POPULAR_MOVIES_ROUTE),
            ),
            BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
              builder: (context, state) {
                if (state is PopularMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularMoviesHasData) {
                  return MovieList(state.result);
                } else {
                  return const Text('Failed');
                }
              },
            ),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(context, TOP_RATED_MOVIES_ROUTE),
            ),
            BlocBuilder<TopRatedMoviesCubit, TopRatedMoviesState>(
              builder: (context, state) {
                if (state is TopRatedMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedMoviesHasData) {
                  return MovieList(state.result);
                } else {
                  return const Text('Failed');
                }
              },
            ),
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

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MOVIE_DETAIL_ROUTE,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
