import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_omni_pro_app/src/domain/use_cases/use_cases.dart';
import 'package:prueba_omni_pro_app/src/locator.dart';
import 'package:prueba_omni_pro_app/src/presentation/cubits/cubits.dart';

class MyMultiCubitProviders extends StatelessWidget {
  const MyMultiCubitProviders({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PhotosCubit>(
          create: (_) => PhotosCubit(
            getPhotosUseCase: locator<GetPhotosUseCase>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
