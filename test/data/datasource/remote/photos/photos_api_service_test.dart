import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:prueba_omni_pro_app/src/data/datasource/remote/api/photos/photos_api_service.dart';
import 'package:prueba_omni_pro_app/src/domain/datasource/datasource.dart';
import 'package:prueba_omni_pro_app/src/domain/models/models.dart';
import 'package:prueba_omni_pro_app/src/utils/utils.dart';
// import 'photos_api_service_test.mocks.dart';

// @GenerateNiceMocks([MockSpec<ApiBaseHandler>()])

class MockApiBaseHandler extends Mock implements ApiBaseHandler {
  @override
  Future<DataState<Response>> get(String? path) async {
    return super.noSuchMethod(
      Invocation.method(#get, [path]),
      returnValue: Future.value(DataSuccess(Response('[]', 200))),
      returnValueForMissingStub: Future.value(DataSuccess(Response('[]', 200))),
    );
  }
}

void main() {
  group('PhotosApiServiceImpl', () {
    late PhotosApiService photosApiService;
    late MockApiBaseHandler apiBaseHandler;

    final List<dynamic> jsonResponse = [
      {
        "albumId": 1,
        "id": 1,
        "title": "accusamus beatae ad facilis cum similique qui sunt",
        "url": "https://via.placeholder.com/600/92c952",
        "thumbnailUrl": "https://via.placeholder.com/150/92c952"
      },
    ];

    setUp(() {
      apiBaseHandler = MockApiBaseHandler();
      photosApiService = PhotosApiServiceImpl(apiBaseHandler: apiBaseHandler);
    });

    test('getPhotos should return DataSuccess with GetPhotosResponse',
        () async {
      // Arrange
      final request = GetPhotosRequest(page: 1, limit: 10);
      final mockResponse = DataSuccess(Response(jsonEncode(jsonResponse), 200));

      // Configura el mock para devolver un valor no nulo
      when(apiBaseHandler.get(any)).thenAnswer((_) async => mockResponse);

      // Act
      final result = await photosApiService.getPhotos(request: request);

      // Assert
      expect(result, isA<DataSuccess<GetPhotosResponse>>());
    });

    test('getPhotos should return DataApiError with ApiException', () async {
      // Arrange
      final request = GetPhotosRequest(page: 1, limit: 10);

      // Configura el mock para devolver un valor no nulo
      when(apiBaseHandler.get(any)).thenAnswer((_) async {
        return DataApiError(ApiException(message: "Error: Bad Request", code: 400));
      });

      // Act
      final result = await photosApiService.getPhotos(request: request);

      // Assert
      expect(result, isA<DataApiError<GetPhotosResponse>>());
    });
  });
}
