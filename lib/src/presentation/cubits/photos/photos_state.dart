part of 'photos_cubit.dart';

enum PhotosStatus { initial, loading, loaded, error }

class PhotosState extends Equatable {
  final PhotosStatus status;
  final int page;
  final List<PhotosEntity> photos;

  const PhotosState({
    required this.status,
    required this.photos,
    required this.page,
  });

  factory PhotosState.initial() => const PhotosState(
        status: PhotosStatus.initial,
        photos: [],
        page: 0,
      );

  PhotosState copyWith({
    PhotosStatus? status,
    List<PhotosEntity>? photos,
    int? page,
  }) {
    return PhotosState(
      status: status ?? this.status,
      photos: photos ?? this.photos,
      page: page ?? this.page,
    );
  }

  @override
  List<Object> get props => [
        status,
        photos,
        page,
      ];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhotosState &&
        other.status == status &&
        const DeepCollectionEquality().equals(other.photos, photos) &&
        other.page == page;
  }

  @override
  int get hashCode => status.hashCode ^ DeepCollectionEquality().hash(photos) ^ page.hashCode;

  @override
  String toString() {
    return 'PhotosState(status: $status, photos: $photos, page: $page)';
  }
}
