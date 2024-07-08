// coverage:ignore-file
sealed class PhotosErrors implements Exception {
  PhotosErrors({
    this.error,
    this.code,
    this.description,
  });

  String? error;
  String? code;
  String? description;

}

class PhotosErrorUnknown extends PhotosErrors {
  PhotosErrorUnknown({
    super.error,
    super.code,
    super.description,
  });
}

class PhotosErrorBadRequest extends PhotosErrors {
  PhotosErrorBadRequest({
    super.error,
    super.code,
    super.description,
  });
}



