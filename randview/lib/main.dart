import 'package:flutter/material.dart';
import 'common_types.dart';
import 'pages/settings_page.dart';
import 'image_storage.dart';
import 'dart:io';

void main() => runApp(const RandView());

class RandView extends StatelessWidget {
  const RandView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RandView',
      home: const RandViewHomePage(title: 'RandView'),
    );
  }
}

class RandViewHomePage extends StatefulWidget {
  const RandViewHomePage({super.key, required this.title});

  final String title;

  @override
  State<RandViewHomePage> createState() => _RandViewHomePageState();
}

class _RandViewHomePageState extends State<RandViewHomePage> {
  File _currentPicture = File("");

  Future<void> randomPicture() async {
    List<String> imagePaths = await ImageStorage.getImagePaths();

    if (imagePaths.isNotEmpty) {
      imagePaths.shuffle();
      setState(() => _currentPicture = File(imagePaths.first));
    } else {
      setState(() => _currentPicture = File(""));
    }
  }

  @override
  void initState() {
    super.initState();
    randomPicture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.appBar,
        foregroundColor: AppColors.textPrimary,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: AppSizes.appBarFontSize,
            color: AppColors.accent,
            fontFamily: "Audiowide",
          ),
        ),
        actions: [
          IconButton(
            style: const ButtonStyle(
              overlayColor: WidgetStatePropertyAll(AppColors.pressed),
              iconColor: WidgetStatePropertyAll(AppColors.textPrimary),
            ),
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            ).then((_) => randomPicture()),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: _currentPicture.path != ""
              ? Image.file(_currentPicture)
              : const Text(
                  "You haven't imported any images yet.",
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 20),
                ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.textPrimary,
        onPressed: randomPicture,
        tooltip: 'Change the picture',
        child: const Icon(Icons.casino),
      ),
    );
  }
}
