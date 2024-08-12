
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/data/datasources/remote/remote_datasource.dart';
import 'package:todo_list_app/data/repositories/remote_repository_impl.dart';
import 'package:todo_list_app/domain/repositories/remote_repository.dart';
import 'package:todo_list_app/domain/usecases/create_usecase.dart';

import '../../domain/usecases/delete_usecase.dart';
import '../../domain/usecases/detail_usecase.dart';
import '../../domain/usecases/list_usecase.dart';
import '../../domain/usecases/update_usecase.dart';
import '../../presentation/page/create/create_vm.dart';
import '../../presentation/page/detail/detail_vm.dart';
import '../../presentation/page/list/list_vm.dart';
import '../services/network_service.dart';

final locator = GetIt.instance;

List<ChangeNotifierProvider> getProviders() {
  return [
    ChangeNotifierProvider(
      create: (_) => locator<PostListViewModel>(),
    ),
    ChangeNotifierProvider(
      create: (_) => locator<CreateViewModel>(),
    ),
    ChangeNotifierProvider(
      create: (_) => locator<DetailPostViewModel>(),
    ),
  ];
}

Future<void> setupLocator() async {

  // data source
  locator.registerLazySingleton<RemoteDatasource>(
          () => RemoteDataSourceImpl());

  // repository
  locator.registerLazySingleton<RemoteRepository>(
      () => RemoteRepositoryImpl(locator())
  );

  locator.registerSingleton<HttpService>(HttpService());

  // use cases
  locator.registerLazySingleton<GetPostList>(
          () => GetPostList(locator())
  );
  locator.registerLazySingleton<CreatePost>(
          () => CreatePost(locator())
  );
  locator.registerLazySingleton<GetPostById>(
          () => GetPostById(locator())
  );
  locator.registerLazySingleton<DeletePost>(
          () => DeletePost(locator())
  );
  locator.registerLazySingleton<UpdatePost>(
          () => UpdatePost(locator())
  );

  // view models
  locator.registerFactory<PostListViewModel>(
          () => PostListViewModel(getPostListUseCase: locator(), deletePostUseCase: locator())
  );

  locator.registerFactory<CreateViewModel>(
          () => CreateViewModel(createPostUsecase: locator(), updatePostUsecase: locator())
  );
  locator.registerFactory<DetailPostViewModel>(
        () => DetailPostViewModel(getDetailPostUseCase: locator()),
  );
}