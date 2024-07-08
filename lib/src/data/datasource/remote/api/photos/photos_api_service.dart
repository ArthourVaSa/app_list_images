import 'dart:convert';

import 'package:prueba_omni_pro_app/src/domain/datasource/datasource.dart';
import 'package:prueba_omni_pro_app/src/domain/models/request/photos/get_photos_request.dart';
import 'package:prueba_omni_pro_app/src/domain/models/response/photos/get_photos_response.dart';
import 'package:prueba_omni_pro_app/src/utils/resources/api/api_base_handler.dart';
import 'package:prueba_omni_pro_app/src/utils/resources/data_state/data_state.dart';

class PhotosApiServiceImpl implements PhotosApiService {
  final ApiBaseHandler _apiBaseHandler;

  PhotosApiServiceImpl({
    required ApiBaseHandler apiBaseHandler,
  }) : _apiBaseHandler = apiBaseHandler;

  @override
  Future<DataState<GetPhotosResponse>> getPhotos({
    required GetPhotosRequest request,
  }) async {
    final response = await _apiBaseHandler.get(
      "/photos?_start=${request.page}&_limit=${request.limit}",
    );

    if (response is DataApiError) {
      return DataApiError(response.error!);
    }

    final List<dynamic> json = jsonDecode(response.data!.body);

    return DataSuccess(
      GetPhotosResponse.fromJson(
        json,
      ),
    );
  }
}
