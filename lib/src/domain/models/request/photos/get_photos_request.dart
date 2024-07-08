// coverage:ignore-file
class GetPhotosRequest {
  final int page;
  final int limit;

  GetPhotosRequest({
    required this.page,
    required this.limit,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetPhotosRequest &&
          runtimeType == other.runtimeType &&
          page == other.page &&
          limit == other.limit;

  @override
  int get hashCode => page.hashCode ^ limit.hashCode;
}
