import 'package:flutter/material.dart';
import 'package:tv/presentation/bloc/popular_tv/popular_tv_cubit.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTVSeriesPage extends StatefulWidget {
  @override
  _PopularTVSeriesPageState createState() => _PopularTVSeriesPageState();
}

class _PopularTVSeriesPageState extends State<PopularTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<PopularTvSeriesCubit>().getPopularTvSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TVSeries'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvSeriesCubit, PopularTvSeriesState>(
          builder: (context, state) {
            if (state is PopularTvSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvSeriesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TVSeriesCardList(tv);
                },
                itemCount: state.result.length,
              );
            } else if (state is PopularTvSeriesError) {
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
