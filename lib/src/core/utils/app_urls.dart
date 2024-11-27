import 'package:injectable/injectable.dart';

abstract class AppUrls {
  String get basePath;
  String get photos;
}

@LazySingleton(as: AppUrls)
class AppUrlsImpl implements AppUrls {
  @override
  String get basePath => 'api.unsplash.com';

  @override
  String get photos => '/photos';
}
