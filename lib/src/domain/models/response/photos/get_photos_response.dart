// coverage:ignore-file
import 'package:prueba_omni_pro_app/src/domain/models/response/photos/photos_dto.dart';

class GetPhotosResponse {

  final List<PhotosDto> photos;

  GetPhotosResponse({required this.photos});

  factory GetPhotosResponse.fromJson(List<dynamic> json) {
    return GetPhotosResponse(
      photos: json.map((photo) => PhotosDto.fromJson(photo)).toList(),
    );
  }

}