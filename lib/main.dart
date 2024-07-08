import 'package:flutter/material.dart';
import 'package:prueba_omni_pro_app/src/config/config.dart';
import 'package:prueba_omni_pro_app/src/locator.dart';
import 'package:sizer/sizer.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MyMultiCubitProviders(
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
              useMaterial3: true,
            ),
            routerConfig: AppRouter.router,
          ),
        );
      }
    );
  }
}