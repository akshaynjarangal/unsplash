import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:unsplash/src/core/utils/error_handler.dart';
import 'package:unsplash/src/data/data_source/home_data_source.dart';
import 'package:unsplash/src/data/models/unsplash_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<UnsplashModel>>> getImages({
    required String page,
  });
}

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource _homeDataSource;

  HomeRepositoryImpl({required HomeDataSource homeDataSource})
      : _homeDataSource = homeDataSource;
  @override
  Future<Either<Failure, List<UnsplashModel>>> getImages(
      {required String page,}) async {
    return _homeDataSource.getImages(page: page);
  }
}
