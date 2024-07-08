import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:prueba_omni_pro_app/src/utils/utils.dart';
import 'api_base_handler_test.mocks.dart';
import 'package:nock/nock.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  group('ApiBaseHandler Test Group', () {
    const String baseUrl = 'https://jsonplaceholder.typicode.com/';
    const String path = 'photos?_start=0&_limit=10';
    const List<Map<String, dynamic>> responseData = [
      {
        "albumId": 1,
        "id": 1,
        "title": "accusamus beatae ad facilis cum similique qui sunt",
        "url": "https://via.placeholder.com/600/92c952",
        "thumbnailUrl": "https://via.placeholder.com/150/92c952"
      },
      {
        "albumId": 1,
        "id": 2,
        "title": "reprehenderit est deserunt velit ipsam",
        "url": "https://via.placeholder.com/600/771796",
        "thumbnailUrl": "https://via.placeholder.com/150/771796"
      },
      {
        "albumId": 1,
        "id": 3,
        "title": "officia porro iure quia iusto qui ipsa ut modi",
        "url": "https://via.placeholder.com/600/24f355",
        "thumbnailUrl": "https://via.placeholder.com/150/24f355"
      },
      {
        "albumId": 1,
        "id": 4,
        "title": "culpa odio esse rerum omnis laboriosam voluptate repudiandae",
        "url": "https://via.placeholder.com/600/d32776",
        "thumbnailUrl": "https://via.placeholder.com/150/d32776"
      },
      {
        "albumId": 1,
        "id": 5,
        "title": "natus nisi omnis corporis facere molestiae rerum in",
        "url": "https://via.placeholder.com/600/f66b97",
        "thumbnailUrl": "https://via.placeholder.com/150/f66b97"
      },
      {
        "albumId": 1,
        "id": 6,
        "title": "accusamus ea aliquid et amet sequi nemo",
        "url": "https://via.placeholder.com/600/56a8c2",
        "thumbnailUrl": "https://via.placeholder.com/150/56a8c2"
      },
      {
        "albumId": 1,
        "id": 7,
        "title":
            "officia delectus consequatur vero aut veniam explicabo molestias",
        "url": "https://via.placeholder.com/600/b0f7cc",
        "thumbnailUrl": "https://via.placeholder.com/150/b0f7cc"
      },
      {
        "albumId": 1,
        "id": 8,
        "title": "aut porro officiis laborum odit ea laudantium corporis",
        "url": "https://via.placeholder.com/600/54176f",
        "thumbnailUrl": "https://via.placeholder.com/150/54176f"
      },
      {
        "albumId": 1,
        "id": 9,
        "title": "qui eius qui autem sed",
        "url": "https://via.placeholder.com/600/51aa97",
        "thumbnailUrl": "https://via.placeholder.com/150/51aa97"
      },
      {
        "albumId": 1,
        "id": 10,
        "title": "beatae et provident et ut vel",
        "url": "https://via.placeholder.com/600/810b14",
        "thumbnailUrl": "https://via.placeholder.com/150/810b14"
      }
    ];
    late MockClient mockClient;
    late ApiBaseHandler apiBaseHandler;
    late ApiBaseHandler apiBaseHandler2;
    late http.Client httpClient;

    setUpAll(() {
      nock.init();
      mockClient = MockClient();
      httpClient = http.Client();
      apiBaseHandler = ApiBaseHandler(baseUrl: baseUrl, httpClient: mockClient);
      apiBaseHandler2 =
          ApiBaseHandler(baseUrl: "http://localhost/api/", httpClient: httpClient);
    });

    setUp(() {
      nock.cleanAll();
    });

    test(
        'should return a Response 200 if the http call completes successfully - REAL API',
        () async {
      when(mockClient.get(Uri.parse('$baseUrl$path'))).thenAnswer(
          (_) async => http.Response(jsonEncode(responseData), 200));

      final response = await apiBaseHandler.get(path);

      expect(response, isA<DataSuccess>());
    });

    test(
        'should return a Response 200 if the http call completes successfully - FAKE API NOCK',
        () async {
      final interceptor = nock("http://localhost/api/").get(path)
        ..reply(
          200,
          {
            "data": responseData,
          },
        );

      final response = await apiBaseHandler2.get(path);

      expect(interceptor.isDone, true);
      expect(response, isA<DataSuccess>());
    });

    test(
        'should return a Response 200 if the http call fails - FAKE API NOCK',
        () async {
      final interceptor = nock("http://localhost/api/").get(path)
        ..reply(
          400,
          {
            "error": "Bad Request",
          },
        );

      final response = await apiBaseHandler2.get(path);

      expect(interceptor.isDone, true);
      expect(response, isA<DataApiError>());
    });

  });
}
