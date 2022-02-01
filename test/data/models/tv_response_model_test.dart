import 'dart:convert';

import 'package:ditonton/data/models/tv/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing_tv.json'));
      // act
      final result = TVSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, testTVSeriesResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = testTVSeriesResponse.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/phwgPLUIcv3sbI1xmkiurThR13Q.jpg",
            "first_air_date": "2021-11-14",
            "genre_ids": [16, 10765, 10759],
            "id": 84553,
            "name": "Blade Runner: Black Lotus",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "Blade Runner: Black Lotus",
            "overview":
                "Los Angeles 2032. A young woman wakes up with no memories, and possessing deadly skills. The only clues to her mystery are a locked data device and a tattoo of a black lotus. Putting together the pieces, she must hunt down the people responsible for her brutal and bloody past to find the truth of her lost identity.",
            "popularity": 477.664,
            "poster_path": "/zHQJkDZ4OjqJnp4vtphxOQ7GIh6.jpg",
            "vote_average": 7.6,
            "vote_count": 68
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
