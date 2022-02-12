
import 'package:equatable/equatable.dart';
import 'package:tv/data/models/tv_model.dart';

class TVSeriesResponse extends Equatable {
  final List<TVSeriesModel> tvSeriesList;

  TVSeriesResponse({required this.tvSeriesList});

  factory TVSeriesResponse.fromJson(Map<String, dynamic> json) =>
      TVSeriesResponse(
        tvSeriesList: List<TVSeriesModel>.from((json["results"] as List)
            .map((x) => TVSeriesModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(tvSeriesList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [tvSeriesList];
}
