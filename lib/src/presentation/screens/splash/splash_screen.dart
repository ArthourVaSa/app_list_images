import 'package:flutter/material.dart';
import 'package:prueba_omni_pro_app/src/config/router/app_router.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await Future.delayed(const Duration(seconds: 2));
      AppRouter.router.go(AppRouter.homeScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "CARGANDO APP...",
            style: TextStyle(
              fontSize: 14.0.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ],
      ),
    );
  }
}
