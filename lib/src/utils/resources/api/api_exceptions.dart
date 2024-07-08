// coverage:ignore-file
import 'package:http/http.dart';

class ApiException implements Exception {

  final String message;
  final int? code;
  final Response? response;

  ApiException({
    required this.message,
    this.code,
    this.response,
  });

}