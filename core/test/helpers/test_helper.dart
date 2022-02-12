import 'package:core/data/datasources/db/database_helper.dart';
import '../../../tv/lib/data/datasources/tv_local_data_source.dart';
import '../../../tv/lib/data/datasources/tv_remote_data_source.dart';
import '../../../tv/lib/domain/repositories/tv_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TVSeriesRepository,
  TVSeriesRemoteDataSource,
  TVSeriesLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
