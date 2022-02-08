
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/presentation/provider/search_notifier.dart';
import 'package:core/presentation/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                if (activeDrawerItem == "Movie")
                  Provider.of<SearchNotifier>(context, listen: false)
                      .fetchMovieSearch(query);
                else {
                  Provider.of<SearchNotifier>(context, listen: false)
                      .fetchTVSeriesSearch(query);
                }
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
            Consumer<SearchNotifier>(
              builder: (context, data, child) {
                if (data.state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data.state == RequestState.Loaded) {
                  if (activeDrawerItem == "Movie") {
                    final result = data.moviesSearchResult;
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
                    final result = data.tvSeriesSearchResult;
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
                  }
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
