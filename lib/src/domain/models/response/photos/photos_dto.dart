// coverage:ignore-file
import 'package:prueba_omni_pro_app/src/domain/models/models.dart';

class PhotosDto {
    int albumId;
    int id;
    String title;
    String url;
    String thumbnailUrl;

    PhotosDto({
        required this.albumId,
        required this.id,
        required this.title,
        required this.url,
        required this.thumbnailUrl,
    });

    factory PhotosDto.fromJson(Map<String, dynamic> json) => PhotosDto(
        albumId: json["albumId"],
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
    );

    Map<String, dynamic> toJson() => {
        "albumId": albumId,
        "id": id,
        "title": title,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
    };

    PhotosEntity toEntity() => PhotosEntity(
      id: id,
      title: title,
      urlImage: url,
    );
}
