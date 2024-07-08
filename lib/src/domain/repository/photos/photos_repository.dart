// coverage:ignore-file
import 'package:prueba_omni_pro_app/src/domain/models/models.dart';
import 'package:prueba_omni_pro_app/src/utils/utils.dart';

abstract class PhotosRepository {

  Future<DataState<List<PhotosEntity>>> getPhotos({
    required GetPhotosRequest request,
  });

}