import 'package:data/src/api/common/dio_factory.dart';
import 'package:data/src/api/data_source_impl/movie_api_datasource_impl.dart';
import 'package:data/src/data_source/movie_api_datasource.dart';
import 'package:data/src/data_source/movie_database_datasource.dart';
import 'package:data/src/database/data_source/movie_database_datasource_impl.dart';
import 'package:data/src/database/flutter_app_database.dart';
import 'package:data/src/di/di.dart';
import 'package:data/src/repo_impl/movie_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';

Future<void> initDataDiAsync() async {
  dataDi
    ..registerSingleton<Dio>(DioFactory().createClient())
    ..registerSingleton<MovieApiDataSource>(
      MovieApiDataSourceImpl(restClient: dataDi()),
    );

  dataDi
    ..registerSingleton<FlutterAppDatabase>(FlutterAppDatabase())
    ..registerSingleton<MovieDatabaseDataSource>(
      MovieDatabaseDataSourceImpl(database: dataDi()),
    );

  dataDi.registerSingleton<MoviesRepository>(
    MoviesRepositoryImpl(apiDataSource: dataDi(), databaseDataSource: dataDi()),
  );

  await dataDi.allReady();
}
