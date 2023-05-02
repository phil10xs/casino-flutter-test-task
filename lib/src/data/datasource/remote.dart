import 'package:graphql_flutter/graphql_flutter.dart';

abstract class RemoteDS {
  Future<QueryResult<Object?>> fetch({int page = 1});
}

class RemoteDSImpl extends RemoteDS {
  RemoteDSImpl({
    required this.graphQLClient,
  });

  final GraphQLClient graphQLClient;

  @override
  Future<QueryResult<Object?>> fetch({int page = 1}) async {
    var response = await graphQLClient.query(QueryOptions(document: gql('''
      query {
      characters(page: $page) {
        info {
          count
        }
        results {
          name
          image
          gender
          species
          status
          id
          created
          origin {
            id
            dimension
            created
          }
        }
      }
    }
    ''')));

    return response;
  }
}
