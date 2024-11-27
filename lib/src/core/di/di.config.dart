// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/data_source/home_data_source.dart' as _i756;
import '../../data/repositories/home_repository.dart' as _i482;
import '../../presentation/provider/home_provider.dart' as _i821;
import '../utils/app_urls.dart' as _i1060;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i1060.AppUrls>(() => _i1060.AppUrlsImpl());
    gh.lazySingleton<_i756.HomeDataSource>(
        () => _i756.HomeDataSourceImpl(appUrls: gh<_i1060.AppUrls>()));
    gh.lazySingleton<_i482.HomeRepository>(() =>
        _i482.HomeRepositoryImpl(homeDataSource: gh<_i756.HomeDataSource>()));
    gh.factory<_i821.HomeProvider>(
        () => _i821.HomeProvider(homeRepository: gh<_i482.HomeRepository>()));
    return this;
  }
}
