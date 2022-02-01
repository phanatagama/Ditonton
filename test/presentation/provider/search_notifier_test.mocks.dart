// Mocks generated by Mockito 5.0.8 from annotations
// in ditonton/test/presentation/provider/search_notifier_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i3;
import 'package:ditonton/common/failure.dart' as _i7;
import 'package:ditonton/domain/entities/movie/movie.dart' as _i8;
import 'package:ditonton/domain/entities/tv/tv.dart' as _i10;
import 'package:ditonton/domain/repositories/movie_repository.dart' as _i2;
import 'package:ditonton/domain/repositories/tv_repository.dart' as _i4;
import 'package:ditonton/domain/usecases/movie/search_movies.dart' as _i5;
import 'package:ditonton/domain/usecases/tv/search_tv.dart' as _i9;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeMovieRepository extends _i1.Fake implements _i2.MovieRepository {}

class _FakeEither<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

class _FakeTVSeriesRepository extends _i1.Fake
    implements _i4.TVSeriesRepository {}

/// A class which mocks [SearchMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchMovies extends _i1.Mock implements _i5.SearchMovies {
  MockSearchMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository()) as _i2.MovieRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i8.Movie>>> execute(String? query) =>
      (super.noSuchMethod(Invocation.method(#execute, [query]),
          returnValue: Future<_i3.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i3.Either<_i7.Failure, List<_i8.Movie>>>);
}

/// A class which mocks [SearchTVSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchTVSeries extends _i1.Mock implements _i9.SearchTVSeries {
  MockSearchTVSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.TVSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVSeriesRepository()) as _i4.TVSeriesRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i10.TVSeries>>> execute(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#execute, [query]),
              returnValue:
                  Future<_i3.Either<_i7.Failure, List<_i10.TVSeries>>>.value(
                      _FakeEither<_i7.Failure, List<_i10.TVSeries>>()))
          as _i6.Future<_i3.Either<_i7.Failure, List<_i10.TVSeries>>>);
}