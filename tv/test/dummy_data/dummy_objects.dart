import 'package:core/data/models/movie/genre_model.dart';
import 'package:core/data/models/tv/season_model.dart';
import 'package:tv/tv.dart';

final testTVSeriesModel = TVSeriesModel(
    backdropPath: "/phwgPLUIcv3sbI1xmkiurThR13Q.jpg",
    firstAirDate: "2021-11-14",
    genreIds: [16, 10765, 10759],
    id: 84553,
    name: "Blade Runner: Black Lotus",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Blade Runner: Black Lotus",
    overview:
        "Los Angeles 2032. A young woman wakes up with no memories, and possessing deadly skills. The only clues to her mystery are a locked data device and a tattoo of a black lotus. Putting together the pieces, she must hunt down the people responsible for her brutal and bloody past to find the truth of her lost identity.",
    popularity: 477.664,
    posterPath: "/zHQJkDZ4OjqJnp4vtphxOQ7GIh6.jpg",
    voteAverage: 7.6,
    voteCount: 68);

final testTVSeriesModelList = <TVSeriesModel>[testTVSeriesModel];

final testTVSeries = testTVSeriesModel.toEntity();

final testTVSeriesList = <TVSeries>[testTVSeries];

final testTVSeriesResponse =
    TVSeriesResponse(tvSeriesList: testTVSeriesModelList);

final testTVSeriesDetailResponse = TVSeriesDetailResponse(
  backdropPath: '',
  firstAirDate: '',
  genres: [GenreModel(id: 1, name: 'Action')],
  id: 2,
  episodeRunTime: [],
  homepage: "homepage",
  numberOfEpisodes: 34,
  name: 'name',
  numberOfSeasons: 2,
  originalLanguage: 'en',
  originalName: 'name',
  overview: 'overview',
  popularity: 2.323,
  posterPath: '',
  seasons: [
    SeasonModel(
      airDate: '',
      episodeCount: 7,
      id: 1,
      name: 'Winter',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 2,
    )
  ],
  status: 'status',
  tagline: 'tagline',
  type: 'Scripted',
  voteAverage: 3,
  voteCount: 3,
);

final testTVSeriesDetail = testTVSeriesDetailResponse.toEntity();

final testTVSeriesTable = TVSeriesTable.fromEntity(testTVSeriesDetail);

final testTVSeriesTableList = <TVSeriesTable>[testTVSeriesTable];

final testWatchlistTVSeries = [testTVSeriesTable.toEntity()];

final testTVSeriesMap = {
  'id': 1,
  'name': 'name',
  'overview': 'overview',
  'posterPath': 'posterPath',
};
