// coverage:ignore-file
import 'package:prueba_omni_pro_app/src/domain/models/models.dart';
import 'package:prueba_omni_pro_app/src/utils/utils.dart';

abstract class PhotosApiService {

  Future<DataState<GetPhotosResponse>> getPhotos({
    required GetPhotosRequest request,
  });

}