import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/primary_button.dart';
import '../common_types.dart';
import '../widgets/secondary_app_bar.dart';
import 'license_detail_page.dart';

class License {
  final String name;
  final String path;
  final String noticePath;
  const License({required this.name, required this.path, this.noticePath = ""});
}

class LicenseListPage extends StatefulWidget {
  const LicenseListPage({super.key});

  static const List<License> licenses = [
    License(
      name: "RandView",
      path: "licenses/RandView_LICENSE.txt",
      noticePath: "licenses/RandView_NOTICE.txt",
    ),
    License(name: "flutter_lints", path: "licenses/third-party/flutter_lints_LICENSE.txt"),
    License(name: "Dart", path: "licenses/third-party/Dart_LICENSE.txt"),
    License(name: "path", path: "licenses/third-party/path_LICENSE.txt"),
    License(name: "Flutter", path: "licenses/third-party/Flutter_LICENSE.txt"),
    License(
      name: "flutter_launcher_icons",
      path: "licenses/third-party/flutter_launcher_icons_LICENSE.txt",
    ),
    License(
      name: "image_picker",
      path: "licenses/third-party/image_picker_LICENSE.txt",
    ),
    License(
      name: "Audiowide",
      path: "licenses/third-party/Audiowide_LICENSE.txt",
    ),
    License(
      name: "path_provider",
      path: "licenses/third-party/path_provider_LICENSE.txt",
    ),
  ];

  @override
  State<LicenseListPage> createState() => _LicenseListPageState();
}

class _LicenseListPageState extends State<LicenseListPage> {
  late final List<Future<LicenseData>> _licenseFutures;

  @override
  void initState() {
    super.initState();
    _licenseFutures = LicenseListPage.licenses.map(_loadLicense).toList();
  }

  Future<LicenseData> _loadLicense(License l) async {
    final license = await rootBundle.loadString(l.path);
    String notice = "";
    if (l.noticePath.isNotEmpty) {
      notice = await rootBundle.loadString(l.noticePath);
    }
    return LicenseData(license, notice);
  }

  Widget _buildLicenseItem(int index) {
    final license = LicenseListPage.licenses[index];
    final future = _licenseFutures[index];

    return FutureBuilder<LicenseData>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 80,
            child: Center(
              child: CircularProgressIndicator(color: AppColors.accent),
            ),
          );
        }

        if (snapshot.hasError) {
          return PrimaryButton(
            text: "Error loading ${license.name}",
            onPressed: () {},
            margin: AppSizes.margin,
            borderRadius: AppSizes.radius,
          );
        }

        final data = snapshot.data!;

        return PrimaryButton(
          text: license.name,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LicenseDetailPage(
                licenseData: data,
                licenseName: license.name,
              ),
            ),
          ),
          margin: AppSizes.margin,
          borderRadius: AppSizes.radius,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SecondaryAppBar(title: "Licenses"),
      body: SafeArea(
        child: ListView.builder(
          itemCount: LicenseListPage.licenses.length,
          itemBuilder: (context, index) => _buildLicenseItem(index),
        ),
      ),
    );
  }
}
