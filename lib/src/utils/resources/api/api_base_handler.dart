import 'dart:convert';

import 'package:http/http.dart';
import 'package:prueba_omni_pro_app/src/utils/utils.dart';

class ApiBaseHandler {
  final String _baseUrl;
  final Client _httpClient;

  ApiBaseHandler({
    required String baseUrl,
    required Client httpClient,
  })  : _baseUrl = baseUrl,
        _httpClient = httpClient;

  Future<DataState<Response>> get(String path) async {
    final response = await _httpClient.get(
      Uri.parse(
        '$_baseUrl$path',
      ),
    );

    return _handleResponse(response);
  }

  DataState<Response> _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return DataSuccess(response);
      case 400:
        return DataApiError(
          ApiException(
            message: "Bad request",
            code: 400,
            response: response,
          ),
        );
      default:
        return DataApiError(
          ApiException(
            message: "An error occurred",
            code: response.statusCode,
            response: response,
          ),
        );
    }
  }
}
