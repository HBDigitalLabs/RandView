import 'common_types.dart';
import 'package:flutter/material.dart';

void showMessage(BuildContext context,String message)
  => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.surface,
        content: Text(
          message,
          style: const TextStyle(
            color: AppColors.textPrimary,
            backgroundColor: AppColors.surface
          ),
          
        ),
      ),
    );