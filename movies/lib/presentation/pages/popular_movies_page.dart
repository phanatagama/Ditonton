import 'package:flutter/material.dart';
import 'package:movies/presentation/bloc/popular_movies/popular_movies_cubit.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesPage extends StatefulWidget {
  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    context.read<PopularMoviesCubit>().getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
          builder: (context, state) {
            if (state is PopularMoviesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularMoviesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return MovieCardList(movie);
                },
                itemCount: state.result.length,
              );
            } else if (state is PopularMoviesError) {
              return Text(state.message);
            } else {
              return Text('Failed');
            }
          },
        ),
      ),
    );
  }
}
