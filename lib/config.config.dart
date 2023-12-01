// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'product_list/data/data_sources/remote_ds/product_list_ds.dart' as _i4;
import 'product_list/data/data_sources/remote_ds/product_list_ds_impl.dart'
    as _i5;
import 'product_list/data/repositories/product_list_repo_impl.dart' as _i7;
import 'product_list/domain/repositories/product_list_repo.dart' as _i6;
import 'product_list/domain/use_cases/product_list_use_case.dart' as _i8;
import 'product_list/presentation/bloc/product_list_bloc.dart' as _i9;
import 'shared/api_manager.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.ApiManager>(_i3.ApiManager());
    gh.factory<_i4.ProductRemoteDS>(
        () => _i5.ProductRemoteDSImpl(gh<_i3.ApiManager>()));
    gh.factory<_i6.ProductListRepo>(
        () => _i7.ProductListRepoImpl(gh<_i4.ProductRemoteDS>()));
    gh.factory<_i8.ProductListUseCase>(
        () => _i8.ProductListUseCase(gh<_i6.ProductListRepo>()));
    gh.factory<_i9.ProductListBloc>(
        () => _i9.ProductListBloc(gh<_i8.ProductListUseCase>()));
    return this;
  }
}
