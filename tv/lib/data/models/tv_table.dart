import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';

class TVSeriesTable extends Equatable {
  TVSeriesTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  factory TVSeriesTable.fromEntity(TVSeriesDetail tvSeries) => TVSeriesTable(
        id: tvSeries.id,
        name: tvSeries.name,
        posterPath: tvSeries.posterPath,
        overview: tvSeries.overview,
      );

  factory TVSeriesTable.fromMap(Map<String, dynamic> map) => TVSeriesTable(
        id: map["id"],
        name: map["name"],
        posterPath: map["posterPath"],
        overview: map["overview"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
      };

  TVSeries toEntity() => TVSeries.watchlist(
        id: this.id,
        overview: this.overview,
        posterPath: this.posterPath,
        name: this.name,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        posterPath,
        overview,
      ];
}
