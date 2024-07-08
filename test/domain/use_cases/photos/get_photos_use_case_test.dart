import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:prueba_omni_pro_app/src/domain/errors/errors.dart';
import 'package:prueba_omni_pro_app/src/domain/models/models.dart';
import 'package:prueba_omni_pro_app/src/domain/models/response/photos/photos_dto.dart';
import 'package:prueba_omni_pro_app/src/domain/repository/repository.dart';
import 'package:prueba_omni_pro_app/src/domain/use_cases/photos/get_photos_use_case.dart';
import 'package:prueba_omni_pro_app/src/utils/resources/data_state/either.dart';
import 'package:prueba_omni_pro_app/src/utils/utils.dart';

class MockPhotosRepository extends Mock implements PhotosRepository {
  @override
  Future<DataState<List<PhotosEntity>>> getPhotos(
      {required GetPhotosRequest request}) async {
    //     log("request.page: ${request.page}");
    // if (request.page >= 0) {
    //   final List<PhotosDto> photosDto = [
    //     PhotosDto(
    //       albumId: 1,
    //       id: 1,
    //       title: "accusamus beatae ad facilis cum similique qui sunt",
    //       url: "https://via.placeholder.com/600/92c952",
    //       thumbnailUrl: "https://via.placeholder.com/150/92c952",
    //     ),
    //   ];

    //   return DataSuccess(photosDto.map((e) => e.toEntity()).toList());
    // } else {
    //   return DataApiError(ApiException(
    //     message: "Bad Request",
    //     code: 400,
    //   ));
    // }
    if (request.page >= 0) {
      return super.noSuchMethod(
        Invocation.method(#getPhotos, [request]),
        returnValue: Future.value(DataSuccess<List<PhotosEntity>>([
          PhotosDto(
            albumId: 1,
            id: 1,
            title: "accusamus beatae ad facilis cum similique qui sunt",
            url: "https://via.placeholder.com/600/92c952",
            thumbnailUrl: "https://via.placeholder.com/150/92c952",
          )
        ].map((e) => e.toEntity()).toList())),
        returnValueForMissingStub:
            Future.value(DataSuccess<List<PhotosEntity>>([
          PhotosDto(
            albumId: 1,
            id: 1,
            title: "accusamus beatae ad facilis cum similique qui sunt",
            url: "https://via.placeholder.com/600/92c952",
            thumbnailUrl: "https://via.placeholder.com/150/92c952",
          )
        ].map((e) => e.toEntity()).toList())),
      );
    } else {
      return super.noSuchMethod(
        Invocation.method(#getPhotos, [request]),
        returnValue: Future.value(DataApiError(ApiException(
          message: "Bad Request",
          code: 400,
        ))),
        returnValueForMissingStub: Future.value(DataApiError(ApiException(
          message: "Bad Request",
          code: 400,
        ))),
      );
    }
  }
}

void main() {
  late GetPhotosUseCase getPhotosUseCase;
  late MockPhotosRepository mockPhotosRepository;

  setUpAll(() {
    mockPhotosRepository = MockPhotosRepository();
    getPhotosUseCase = GetPhotosUseCase(photosRepository: mockPhotosRepository);
  });

  group('GetPhotosUseCase', () {
    test('should return a list of PhotosEntity when successful and call once',
        () async {
      // Arrange
      final expectedResponse = [
        PhotosDto(
          albumId: 1,
          id: 1,
          title: "accusamus beatae ad facilis cum similique qui sunt",
          url: "https://via.placeholder.com/600/92c952",
          thumbnailUrl: "https://via.placeholder.com/150/92c952",
        ),
      ];

      when(mockPhotosRepository.getPhotos(
              request: GetPhotosRequest(page: 1, limit: 10)))
          .thenAnswer((_) async => DataSuccess<List<PhotosEntity>>(
              expectedResponse.map((e) => e.toEntity()).toList()));

      // Act
      final result = await getPhotosUseCase.call();

      // Assert
      result.fold(
        (failure) => fail('Expected a success response but got a failure'),
        (data) => expect(
            data, equals(expectedResponse.map((e) => e.toEntity()).toList())),
      );
      verify(mockPhotosRepository.getPhotos(
              request: GetPhotosRequest(page: 1, limit: 10)))
          .called(1);
      verifyNoMoreInteractions(mockPhotosRepository);
    });

    test('should throw a PhotosErrorBadRequest when response is a DataApiError',
        () async {
      // Arrange
      final errorResponse = DataApiError(ApiException(
        message: 'Bad Request',
      ));
      when(mockPhotosRepository.getPhotos(
              request: GetPhotosRequest(page: 0, limit: 10)))
          .thenAnswer((_) async => DataApiError(ApiException(
                message: 'Bad Request',
              )));

      // Act
      final result = await getPhotosUseCase.call();

      // Assert
      result.fold(
        (failure) => expect(
            failure,
            equals(PhotosErrorBadRequest(
              error: errorResponse.error!.message,
              description: errorResponse.error!.code.toString(),
            ))),
        (data) => data,
      );
      verify(mockPhotosRepository.getPhotos(
              request: GetPhotosRequest(page: 1, limit: 10)))
          .called(1);
      verifyNoMoreInteractions(mockPhotosRepository);
    });

    test('should throw a PhotosErrorUnknown when an unknown error occurs',
        () async {
      // Arrange
      final unknownError = Exception('Unknown error');
      when(mockPhotosRepository.getPhotos(
              request: GetPhotosRequest(page: 0, limit: 10)))
          .thenThrow(PhotosErrorUnknown(
        error: 'Ha ocurrido un error desconocido',
        description: unknownError.toString(),
      ));

      // Act
      final result = await getPhotosUseCase.call();

      // Assert
      result.fold(
        (failure) => expect(
            failure,
            equals(PhotosErrorUnknown(
              error: 'Ha ocurrido un error desconocido',
              description: unknownError.toString(),
            ))),
        (data) => data,
      );
      verify(mockPhotosRepository.getPhotos(
          request: GetPhotosRequest(page: 1, limit: 10)));
      verifyNoMoreInteractions(mockPhotosRepository);
    });
  });
}
