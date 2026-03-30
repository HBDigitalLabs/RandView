import 'package:flutter/material.dart';
import '../widgets/secondary_app_bar.dart';
import '../common_types.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const String aboutText =
      "Copyright 2026 Hüseyin Berke - HBDigitalLabs\n"
      "Version: v1.0.1\n\n"
      "This project was developed by Hüseyin Berke.\n"
      "This project is licensed under the Apache 2.0 license.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SecondaryAppBar(title: "About"),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(AppSizes.padding),
          child: Text(
            aboutText,
            style: TextStyle(color: AppColors.textPrimary, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
