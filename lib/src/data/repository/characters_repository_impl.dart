import 'dart:async';

import 'package:casino_test/src/core/network/network.dart';
import 'package:casino_test/src/core/toast/toast.dart';
import 'package:casino_test/src/data/datasource/remote.dart';
import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  CharactersRepositoryImpl({
    required this.remote,
    required this.info,
  });

  final RemoteDS remote;
  final NetworkInfo info;

  @override
  Future<List<Character>?> getCharacters(int page) async {
    if (await info.isConnected()) {
      try {
        var res = await remote.fetch(page: page);

        if (res.hasException) {
          res.exception?.graphqlErrors.forEach((e) {
            // log(e.message);
          });
          CustomToast().toast('Something went wrong!');

          return null;
        }

        return Future.value(
          List.of(
            (res.data!['characters']['results'] as List).map(
              (e) => Character.fromJson(e),
            ),
          ),
        );
      } catch (e) {
        CustomToast().toast('Something went wrong!');

        return null;
      }
    } else {
      CustomToast().toast('Please check your internet and try again!');

      return null;
    }
  }
}
