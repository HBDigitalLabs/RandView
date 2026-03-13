import 'dart:io';
import 'package:flutter/material.dart';

import '../widgets/primary_button.dart';
import '../image_storage.dart';
import '../common_types.dart';
import '../widgets/secondary_app_bar.dart';
import '../utils.dart';

class RemoveImportedImagesPage extends StatefulWidget {
  const RemoveImportedImagesPage({super.key});

  @override
  State<RemoveImportedImagesPage> createState() =>
      _RemoveImportedImagesPageState();
}

class _RemoveImportedImagesPageState extends State<RemoveImportedImagesPage> {
  late Future<List<String>> _imagePathsFuture;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _imagePathsFuture = ImageStorage.getImagePaths();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _reloadImages() {
    final previousOffset = _scrollController.hasClients
        ? _scrollController.offset
        : 0.0;

    setState(() {
      _imagePathsFuture = ImageStorage.getImagePaths();
    });

    _imagePathsFuture.then((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_scrollController.hasClients) return;
        final max = _scrollController.position.maxScrollExtent;
        final restored = previousOffset.clamp(0.0, max);
        _scrollController.jumpTo(restored);
      });
    });
  }

  Future<void> removeImage(BuildContext context, String path) async {
    final result = await ImageStorage.removeImage(path);

    if (!context.mounted) return;

    _reloadImages();

    if (result != ProcessStatus.successfuly) {
      showMessage(context, "An error occurred while deleting the image.");
    } else {
      showMessage(context, "The image has been deleted.");
    }
  }

  Future<void> removeAllImportedImages(BuildContext context) async {
    final result = await ImageStorage.removeAllImportedImages();

    if (!context.mounted) return;

    _reloadImages();

    if (result != ProcessStatus.successfuly) {
      showMessage(context, "An error occurred while deleting the images.");
    } else {
      showMessage(context, "All files have been deleted.");
    }
  }

  Widget _imageWidget(String path) {
    const double imageHeight = 300;

    return Container(
      key: ValueKey(path),
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.margin,
        vertical: AppSizes.margin / 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: imageHeight,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radius - 2),
              child: Image.file(
                File(path),
                fit: BoxFit.contain,
                width: double.infinity,
                height: imageHeight,
              ),
            ),
          ),

          Container(color: AppColors.divider, height: AppSizes.lineThickness),

          PrimaryButton(
            text: "Remove Image",
            onPressed: () async => await removeImage(context, path),
            margin: AppSizes.margin,
            borderRadius: AppSizes.radius,
          ),
        ],
      ),
    );
  }

  Widget createImageContainerWidgets() {
    return FutureBuilder<List<String>>(
      future: _imagePathsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.accent),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Error: ${snapshot.error}",
              style: const TextStyle(color: AppColors.textPrimary),
            ),
          );
        }

        final imagePaths = snapshot.data!;

        if (imagePaths.isEmpty) {
          return const Center(
            child: Text(
              "No images found",
              style: TextStyle(color: AppColors.textPrimary),
            ),
          );
        }

        return ListView.builder(
          key: const PageStorageKey('imageListView'),
          controller: _scrollController,
          itemCount: imagePaths.length,
          itemBuilder: (context, index) => _imageWidget(imagePaths[index]),
        );
      },
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SecondaryAppBar(title: "Remove Imported Images"),
      body: SafeArea(child: createImageContainerWidgets()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.textPrimary,
        onPressed: () async => await removeAllImportedImages(context),
        tooltip: 'Delete all pictures',
        child: const Icon(Icons.delete_sweep),
      ),
    );
  }
}
