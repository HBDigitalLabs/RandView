import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'about_page.dart';
import 'remove_imported_images_page.dart';
import 'license_list_page.dart';
import '../image_storage.dart';
import '../utils.dart';
import '../widgets/secondary_app_bar.dart';
import '../common_types.dart';
import '../widgets/primary_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void openAboutPage(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AboutPage()),
  );

  void openLicensePage(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LicenseListPage()),
  );

  Future<void> importImages(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    final List<XFile> images = await picker.pickMultiImage();


    for (final XFile image in images) {
      final result = await ImageStorage.addImage(image.path);

      if (!context.mounted) return;

      if (result != ProcessStatus.successfuly) {
        showMessage(context, "An error occurred while importing the images.");
        return;
      }
    }

    if (!context.mounted || images.isEmpty) return;

    showMessage(context, "Images imported.");
  }

  void removeImportedImages(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => RemoveImportedImagesPage()),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SecondaryAppBar(title: "Settings"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              PrimaryButton(
                text: "Import Images",
                onPressed: () async => await importImages(context),
                margin: AppSizes.margin,
                borderRadius: AppSizes.radius,
              ),
              PrimaryButton(
                text: "Delete Imported Images",
                onPressed: () => removeImportedImages(context),
                margin: AppSizes.margin,
                borderRadius: AppSizes.radius,
              ),
              PrimaryButton(
                text: "About",
                onPressed: () => openAboutPage(context),
                margin: AppSizes.margin,
                borderRadius: AppSizes.radius,
              ),
              PrimaryButton(
                text: "Open Source Licenses",
                onPressed: () => openLicensePage(context),
                margin: AppSizes.margin,
                borderRadius: AppSizes.radius,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
