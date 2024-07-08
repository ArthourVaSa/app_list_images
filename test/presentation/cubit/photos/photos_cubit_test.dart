import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:prueba_omni_pro_app/src/domain/errors/photos/photos_errors.dart';
import 'package:prueba_omni_pro_app/src/domain/models/models.dart';
import 'package:prueba_omni_pro_app/src/domain/use_cases/use_cases.dart';
import 'package:prueba_omni_pro_app/src/presentation/cubits/photos/photos_cubit.dart';
import 'package:prueba_omni_pro_app/src/utils/resources/data_state/either.dart';
import 'package:prueba_omni_pro_app/src/utils/utils.dart';

class MockGetPhotosUseCase extends Mock implements GetPhotosUseCase {
  @override
  Future<Either<PhotosErrors, List<PhotosEntity>>> call(
      {int page = 0, int limit = 20}) async {
    return super.noSuchMethod(
      Invocation.method(#call, [page, limit]),
      returnValue:
          Future<Either<PhotosErrors, List<PhotosEntity>>>.value(Right([
        PhotosEntity(
          id: 1,
          title: "accusamus beatae ad facilis cum similique qui sunt",
          urlImage: "https://via.placeholder.com/600/92c952",
        ),
      ])),
      returnValueForMissingStub:
          Future<Either<PhotosErrors, List<PhotosEntity>>>.value(Right([
        PhotosEntity(
          id: 1,
          title: "accusamus beatae ad facilis cum similique qui sunt",
          urlImage: "https://via.placeholder.com/600/92c952",
        ),
      ])),
    );
  }
}

void main() {
  late PhotosCubit photosCubit;
  late MockGetPhotosUseCase mockGetPhotosUseCase;

  setUp(() {
    mockGetPhotosUseCase = MockGetPhotosUseCase();
    photosCubit = PhotosCubit(getPhotosUseCase: mockGetPhotosUseCase);
  });

  tearDown(() {
    photosCubit.close();
  });

  group('PhotosCubit', () {
    test('initial state is correct', () {
      expect(photosCubit.state, PhotosState.initial());
    });

    blocTest<PhotosCubit, PhotosState>(
      'getPhotos emits correct states when isFirstTimeCall is true',
      build: () => photosCubit,
      act: (cubit) => cubit.getPhotos(true),
      verify: (_) {
        verify(mockGetPhotosUseCase.call(page: 0, limit: 20)).called(1);
        verifyNoMoreInteractions(mockGetPhotosUseCase);
      },
      expect: () => [
        PhotosState.initial().copyWith(status: PhotosStatus.loading),
        PhotosState.initial().copyWith(
          status: PhotosStatus.loaded,
          photos: [
            PhotosEntity(
              id: 1,
              title: "accusamus beatae ad facilis cum similique qui sunt",
              urlImage: "https://via.placeholder.com/600/92c952",
            ),
          ],
          page: 20,
        ),
      ],
    );

    blocTest<PhotosCubit, PhotosState>(
      'getPhotos emits correct states when isFirstTimeCall is false',
      build: () => photosCubit,
      act: (cubit) => cubit.getPhotos(false),
      verify: (_) {
        verify(mockGetPhotosUseCase.call(page: 0, limit: 10)).called(1);
        verifyNoMoreInteractions(mockGetPhotosUseCase);
      },
      expect: () => [
        PhotosState.initial().copyWith(
          status: PhotosStatus.loaded,
          photos: [
            PhotosEntity(
              id: 1,
              title: "accusamus beatae ad facilis cum similique qui sunt",
              urlImage: "https://via.placeholder.com/600/92c952",
            ),
          ],
          page: 10,
        ),
      ],
    );
    blocTest<PhotosCubit, PhotosState>(
      'getPhotos emits correct states when error occurs',
      build: () {
        when(mockGetPhotosUseCase.call(page: 0, limit: 20)).thenAnswer(
          (_) async => Left(PhotosErrorUnknown()),
        );
        return photosCubit;
      },
      act: (cubit) => cubit.getPhotos(true),
      verify: (_) {
        verify(mockGetPhotosUseCase.call(page: 0, limit: 20)).called(1);
        verifyNoMoreInteractions(mockGetPhotosUseCase);
      },
      expect: () => [
        PhotosState.initial().copyWith(status: PhotosStatus.loading),
        PhotosState.initial().copyWith(status: PhotosStatus.error),
      ],
    );

  });
}
