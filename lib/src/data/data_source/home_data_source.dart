import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:unsplash/src/core/utils/app_urls.dart';
import 'package:unsplash/src/core/utils/error_handler.dart';
import 'package:unsplash/src/data/models/unsplash_model.dart';
import 'package:http/http.dart' as http;

abstract class HomeDataSource {
  Future<Either<Failure, List<UnsplashModel>>> getImages({
    required String page,
  });
}

@LazySingleton(as: HomeDataSource)
class HomeDataSourceImpl implements HomeDataSource {
  final AppUrls _appUrls;
  HomeDataSourceImpl({required AppUrls appUrls}) : _appUrls = appUrls;
  @override
  Future<Either<Failure, List<UnsplashModel>>> getImages({
    required String page,
  }) async {
    final client = http.Client();
    try {
      final url = Uri.https(_appUrls.basePath, _appUrls.photos, {
        "page": page,
        "per_page": '10',
        "client_id": "y7nKE6jeseU-QuHjYHk0d3To3WlJZ7SLct_vkWmx4w4",
      });
      final res = await http.get(url);
      log(
        'Response: ${res.body} ---${res.statusCode}',
      );
      if (res.statusCode == 200) {
        final data = await compute(unsplashModelFromJson, res.body);
        return Right(data);
      } else {
        return Left(
          handleStatusCode(
            res.statusCode,
            '${(jsonDecode(res.body)['errors'] as List).first}',
          ),
        );
      }
    } catch (e) {
      return Left(handleException(e));
    } finally {
      client.close();
    }
  }
}
