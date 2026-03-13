import 'package:flutter/material.dart';
import '../widgets/secondary_app_bar.dart';
import '../common_types.dart';

class LicenseDetailPage extends StatelessWidget {
  const LicenseDetailPage({
    super.key,
    required this.licenseData,
    required this.licenseName,
  });

  final String licenseName;
  final LicenseData licenseData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: SecondaryAppBar(title: "$licenseName License Detail"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.all(AppSizes.padding),
            child: Column(
              children: [
                Text(
                  licenseData.license,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                  ),
                ),

                Container(
                  color: AppColors.divider,
                  height: AppSizes.lineThickness,
                ),

                Text(
                  licenseData.notice,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
