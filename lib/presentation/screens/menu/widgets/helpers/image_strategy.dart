import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// itemImageUrl: Old image URL (already stored)
// itemImageFile: New selected image file (if any)
Widget imageContainerStrategy(String? itemImageUrl, XFile? itemImageFile) {
  if (itemImageUrl != null && itemImageUrl.isNotEmpty) {
    return Image(image: AssetImage(itemImageUrl));
  } else if (itemImageFile != null) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Image.file(File(itemImageFile.path), fit: BoxFit.cover),
    );
  } else {
    return const Image(image: AssetImage('assets/image-holder.png'));
  }
}
