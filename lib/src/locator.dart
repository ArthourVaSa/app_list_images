import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:prueba_omni_pro_app/src/data/datasource/datasource.dart';
import 'package:prueba_omni_pro_app/src/data/repository/repository_impl.dart';
import 'package:prueba_omni_pro_app/src/domain/datasource/datasource.dart';
import 'package:prueba_omni_pro_app/src/domain/repository/repository.dart';
import 'package:prueba_omni_pro_app/src/domain/use_cases/use_cases.dart';
import 'package:prueba_omni_pro_app/src/utils/resources/api/api_base_handler.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  // Remote Configuration Dependencies Injection
  final httpClient = Client();

  locator.registerSingleton<Client>(httpClient);

  final ApiBaseHandler apiBaseHandler = ApiBaseHandler(
    baseUrl: "https://jsonplaceholder.typicode.com/",
    httpClient: httpClient,
  );

  locator.registerSingleton<ApiBaseHandler>(apiBaseHandler);

  // Remote Data Sources Dependencies Injection
  locator.registerSingleton<PhotosApiService>(
    PhotosApiServiceImpl(
      apiBaseHandler: locator<ApiBaseHandler>(),
    ),
  );

  // Remote Repository Dependencies Injection
  locator.registerSingleton<PhotosRepository>(
    PhotosRepositoryImpl(
      photosApiService: locator<PhotosApiService>(),
    ),
  );

  // Domain Use Cases Dependencies Injection
  // Photos Use Case
  locator.registerSingleton<GetPhotosUseCase>(
    GetPhotosUseCase(
      photosRepository: locator<PhotosRepository>(),
    ),
  );

}
