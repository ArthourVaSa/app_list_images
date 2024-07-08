import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:prueba_omni_pro_app/src/data/repository/photos/photos_repository_impl.dart';
import 'package:prueba_omni_pro_app/src/domain/datasource/datasource.dart';
import 'package:prueba_omni_pro_app/src/domain/models/entitiy/photos/photos_entity.dart';
import 'package:prueba_omni_pro_app/src/domain/models/request/photos/get_photos_request.dart';
import 'package:prueba_omni_pro_app/src/domain/models/response/photos/get_photos_response.dart';
import 'package:prueba_omni_pro_app/src/domain/models/response/photos/photos_dto.dart';
import 'package:prueba_omni_pro_app/src/domain/repository/photos/photos_repository.dart';
import 'package:prueba_omni_pro_app/src/utils/resources/api/api_exceptions.dart';
import 'package:prueba_omni_pro_app/src/utils/resources/data_state/data_state.dart';

class MockPhotosApiService extends Mock implements PhotosApiService {
  @override
  Future<DataState<GetPhotosResponse>> getPhotos({
    required GetPhotosRequest request,
  }) async {
    if (request.page == 1) {
      final List<PhotosDto> photosDto = [
        PhotosDto(
          albumId: 1,
          id: 1,
          title: "accusamus beatae ad facilis cum similique qui sunt",
          url: "https://via.placeholder.com/600/92c952",
          thumbnailUrl: "https://via.placeholder.com/150/92c952",
        ),
      ];

      return DataSuccess(GetPhotosResponse(
        photos: photosDto,
      ));
    } else {
      return DataApiError(ApiException(
        message: "Bad Request",
        code: 400,
      ));
    }
  }
}

void main() {
  group('PhotosRepositoryImpl', () {
    late PhotosRepository photosRepository;
    late PhotosApiService mockPhotosApiService;

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
      mockPhotosApiService = MockPhotosApiService();
      photosRepository = PhotosRepositoryImpl(
        photosApiService: mockPhotosApiService,
      );
    });

    test('getPhotos should return a list of PhotosEntity on success', () async {
      // Arrange
      final request = GetPhotosRequest(page: 1, limit: 10);
      final mockResponseDto = List<PhotosDto>.from(
        jsonResponse.map(
          (e) => PhotosDto.fromJson(e),
        ),
      );
      final expectedDataState = DataSuccess(mockResponseDto
          .map(
            (e) => e.toEntity(),
          )
          .toList());

      // Act
      final result = await photosRepository.getPhotos(request: request);

      // Assert
      expect(result, isA<DataSuccess<List<PhotosEntity>>>());
    });

    test('getPhotos should return DataApiError on failure', () async {
      // Arrange
      final request = GetPhotosRequest(page: 0, limit: 10);
      final expectedDataState = DataApiError(ApiException(
        message: "Bad Request",
        code: 400,
      ));

      // Act
      final result = await photosRepository.getPhotos(request: request);

      // Assert
      expect(result, isA<DataApiError<List<PhotosEntity>>>());
    });
  });
}
