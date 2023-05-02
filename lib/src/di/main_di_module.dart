import 'package:casino_test/src/core/network/network.dart';
import 'package:casino_test/src/data/datasource/remote.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/data/repository/characters_repository_impl.dart';
import 'package:casino_test/src/presentation/bloc/main_bloc.dart';
import 'package:casino_test/src/presentation/bloc/main_event.dart';
import 'package:casino_test/src/presentation/bloc/main_state.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MainDIModule {
  Future configure(GetIt getIt) async {
    getIt.registerLazySingleton<CharactersRepository>(
      () => CharactersRepositoryImpl(
        remote: getIt(),
        info: getIt(),
      ),
    );

    getIt.registerLazySingleton<GraphQLClient>(
      () => GraphQLClient(
        link: HttpLink('https://rickandmortyapi.com/graphql'),
        cache: GraphQLCache(store: InMemoryStore()),
      ),
    );

    getIt.registerLazySingleton<RemoteDS>(
      () => RemoteDSImpl(graphQLClient: getIt()),
    );

    getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

    getIt.registerLazySingleton<MainPageEvent>(
        () => GetTestDataOnMainPageEvent(1));
    getIt.registerLazySingleton<MainPageState>(
        () => SuccessfulMainPageState([]));

    getIt.registerLazySingleton<MainPageBloc>(() => MainPageBloc(
          getIt(),
          getIt(),
        ));
  }
}
