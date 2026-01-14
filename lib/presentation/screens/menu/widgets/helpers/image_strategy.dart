import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Widget imageContainerStrategy(String? itemImageUrl, XFile? itemImageFile) {
  if (itemImageUrl != null && itemImageUrl.isNotEmpty) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Image.network(itemImageUrl, fit: BoxFit.cover),
    );
  } else if (itemImageFile != null) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Image.file(File(itemImageFile.path), fit: BoxFit.cover),
    );
  } else {
    return const Image(image: AssetImage('assets/image-holder.png'));
  }
}
