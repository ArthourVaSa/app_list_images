import 'package:prueba_omni_pro_app/src/domain/datasource/datasource.dart';
import 'package:prueba_omni_pro_app/src/domain/models/entitiy/photos/photos_entity.dart';
import 'package:prueba_omni_pro_app/src/domain/models/request/photos/get_photos_request.dart';
import 'package:prueba_omni_pro_app/src/domain/repository/repository.dart';
import 'package:prueba_omni_pro_app/src/utils/resources/data_state/data_state.dart';

class PhotosRepositoryImpl implements PhotosRepository {
  final PhotosApiService _photosApiService;

  PhotosRepositoryImpl({
    required PhotosApiService photosApiService,
  }) : _photosApiService = photosApiService;

  @override
  Future<DataState<List<PhotosEntity>>> getPhotos({
    required GetPhotosRequest request,
  }) {
    final result = _photosApiService.getPhotos(request: request);

    return result.then((value) {
      if (value is DataSuccess) {
        final List<PhotosEntity> photos = [];

        for (var element in value.data!.photos) {
          photos.add(element.toEntity());
        }

        return DataSuccess(photos);
      } else {
        return DataApiError(value.error!);
      }
    });
  }
}
