import 'package:prueba_omni_pro_app/src/domain/errors/errors.dart';
import 'package:prueba_omni_pro_app/src/domain/models/models.dart';
import 'package:prueba_omni_pro_app/src/domain/repository/repository.dart';
import 'package:prueba_omni_pro_app/src/utils/resources/data_state/data_state.dart';
import 'package:prueba_omni_pro_app/src/utils/resources/data_state/either.dart';

class GetPhotosUseCase {
  final PhotosRepository _photosRepository;

  GetPhotosUseCase({
    required PhotosRepository photosRepository,
  }) : _photosRepository = photosRepository;

  Future<Either<PhotosErrors, List<PhotosEntity>>> call({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _photosRepository.getPhotos(
        request: GetPhotosRequest(
          page: page,
          limit: limit,
        ),
      );

      if (response is DataApiError) {
        throw PhotosErrorBadRequest(
          error: response.error!.message,
          description: response.error!.response!.body,
        );
      }

      return Right(
        response.data!,
      );
      
    } on PhotosErrors catch (e) {
      return Left(e);
    } catch (e) {
      return Left(
        PhotosErrorUnknown(
          error: "Ha ocurrido un error desconocido",
          description: e.toString(),
        ),
      );
    }
  }
}
