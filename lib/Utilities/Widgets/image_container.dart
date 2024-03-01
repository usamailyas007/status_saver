import 'dart:io';

import 'package:flutter/material.dart';
import 'package:status_saver_bloc/Views/Media/saved_image_view.dart';

import '../../Views/Media/image_view.dart';

class StatusImageContainer extends StatelessWidget {
  const StatusImageContainer(
      {super.key, required this.imagePath, required this.controller});

  final String imagePath;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => controller.index == 0
                  ? ImageView(
                      imagePath: imagePath,
                    )
                  : SavedImageView(imagePath: imagePath)),
        );
      },
      style: ElevatedButton.styleFrom(
        elevation: 1,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      child: Image.file(
        File(imagePath),
        fit: BoxFit.fitHeight,
        filterQuality: FilterQuality.high,
        height: double.infinity,
      ),
    );
  }
}
