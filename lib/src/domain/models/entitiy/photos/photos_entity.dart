// coverage:ignore-file
class PhotosEntity {
  int id;
  String title;
  String urlImage;

  PhotosEntity({
    required this.id,
    required this.title,
    required this.urlImage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhotosEntity &&
        other.id == id &&
        other.title == title &&
        other.urlImage == urlImage;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ urlImage.hashCode;
}
