import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class NetworkService {
  Dio dio = Dio();
  Map<String, dynamic> headers = {
    'x-hasura-admin-secret':
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6'
  };
  Future<List> fetchBlogPosts() {
    return dio
        .getUri(Uri.https("intent-kit-16.hasura.app", "/api/rest/blogs"),
            options: Options(headers: headers))
        .then((response) {
      dynamic data = response.data;
      return data['blogs'] as List;
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
      throw Exception(
          'CODE:NETW; Error occurred while fetching blog posts. Kindly try again later');
    });
  }
}
