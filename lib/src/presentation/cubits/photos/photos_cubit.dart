import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:prueba_omni_pro_app/src/domain/models/models.dart';
import 'package:prueba_omni_pro_app/src/domain/use_cases/use_cases.dart';
import 'package:prueba_omni_pro_app/src/presentation/cubits/base/base_cubit.dart';

part 'photos_state.dart';

class PhotosCubit extends BaseCubit<PhotosState, List> {
  final GetPhotosUseCase _getPhotosUseCase;

  PhotosCubit({
    required GetPhotosUseCase getPhotosUseCase,
  })  : _getPhotosUseCase = getPhotosUseCase,
        super(PhotosState.initial(), []);

  Future<void> getPhotos(bool isFirstTimeCall) async {
    if (isBusy) return;

    if (isFirstTimeCall) {
      emit(state.copyWith(status: PhotosStatus.loading));
    }

    await run(() async {
      int page = state.page;
      final limit = isFirstTimeCall ? 20 : 10;

      final response = await _getPhotosUseCase.call(
          page: page, limit: limit);

      response.fold(
        (error) {
          emit(state.copyWith(status: PhotosStatus.error));
        },
        (data) {
          List<PhotosEntity> photos = state.photos;

          photos = [...photos, ...data];

          page = isFirstTimeCall ? state.page + 20 : state.page + 10;

          emit(state.copyWith(
            status: PhotosStatus.loaded,
            photos: photos,
            page: page,
          ));
        },
      );
    });
  }
}
