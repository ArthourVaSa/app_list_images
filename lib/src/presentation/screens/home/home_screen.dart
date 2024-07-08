import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_omni_pro_app/src/presentation/cubits/cubits.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      context.read<PhotosCubit>().getPhotos(true);
    });

    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<PhotosCubit>().getPhotos(
            false,
          );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cargando más fotos...'),
        ),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Images'),
      ),
      body: BlocBuilder<PhotosCubit, PhotosState>(
        builder: (context, state) {
          if (state.status == PhotosStatus.loading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (state.status == PhotosStatus.error) {
            return const Center(
              child: Text('Error'),
            );
          }

          if (state.photos.isEmpty) {
            return const Center(
              child: Text('No hay fotos para mostrar'),
            );
          }

          if (state.photos.isNotEmpty) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.photos.length,
              itemBuilder: (context, index) {
                final photo = state.photos[index];

                return ListTile(
                  title: Text(
                    "${photo.id}. ${photo.title}",
                    style: TextStyle(
                      fontSize: 14.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Image.network(
                    photo.urlImage,
                    errorBuilder: (context, error, stackTrace) {
                      return const FlutterLogo(
                        size: 72,
                      );
                    },
                  ),
                );
              },
            );
          }

          return Center(
            child: Text('Home Screen'),
          );
        },
      ),
    );
  }
}
