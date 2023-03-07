import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pucher_chat/core/widget/padding.dart';

import '../../../core/colors.dart';
import '../../../core/widget/buttons.dart';
import '../../../core/widget/text.dart';

class ImageViewerScreen extends StatelessWidget {
  static const id = 'ImageViewerScreen';
  final String path;
  const ImageViewerScreen({
    super.key,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                const MBackButton(),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: MText(
                    text: "Details",
                    fontSize: 20.0,
                  ),
                ),
              ],
            ).addPadding(bottom: 21.0),
            Expanded(
              child: PhotoView(
                backgroundDecoration: const BoxDecoration(color: Coolors.white),
                imageProvider: NetworkImage(path),
              ),
            ),
          ],
        ).addPadding(all: 24.0),
      ),
    );
  }
}
