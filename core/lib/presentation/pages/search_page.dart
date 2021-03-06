import 'package:core/presentation/bloc/search_movie_bloc.dart';
import 'package:core/presentation/bloc/search_tv_bloc.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';
import 'package:provider/provider.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';

class SearchPage extends StatelessWidget {
  SearchPage({
    Key? key,
    this.activeDrawerItem = "Movie",
  }) : super(key: key);

  final String activeDrawerItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search $activeDrawerItem'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: activeDrawerItem == "Movie" ? MovieSearch() : TVSeriesSearch(),
      ),
    );
  }
}

class MovieSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextField(
        onChanged: (query) {
          context.read<SearchMoviesBloc>().add(OnQueryChanged(query));
        },
        decoration: InputDecoration(
          hintText: 'Search title',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        textInputAction: TextInputAction.search,
      ),
      SizedBox(height: 16),
      Text(
        'Search Result',
        style: kHeading6,
      ),
      BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
        builder: (context, state) {
          if (state is SearchMoviesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SearchMoviesHasData) {
            final result = state.result;
            return Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  final data = result[index];
                  return MovieCardList(data);
                },
                itemCount: result.length,
              ),
            );
          } else {
            return Expanded(
              child: Container(),
            );
          }
        },
      ),
    ]);
  }
}

class TVSeriesSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextField(
        onChanged: (query) {
          context.read<SearchTVSeriesBloc>().add(OnQueryTVSeriesChange(query));
        },
        decoration: InputDecoration(
          hintText: 'Search title',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        textInputAction: TextInputAction.search,
      ),
      SizedBox(height: 16),
      Text(
        'Search Result',
        style: kHeading6,
      ),
      BlocBuilder<SearchTVSeriesBloc, SearchTVSeriesState>(
        builder: (context, state) {
          if (state is SearchTVSeriesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SearchTVSeriesHasData) {
            final result = state.result;
            return Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  final data = result[index];
                  return TVSeriesCardList(data);
                },
                itemCount: result.length,
              ),
            );
          } else {
            return Expanded(
              child: Container(),
            );
          }
        },
      ),
    ]);
  }
}
