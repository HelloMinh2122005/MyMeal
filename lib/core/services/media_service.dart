import 'package:image_picker/image_picker.dart';

abstract class MediaService {
  Future<XFile?> captureImageWithCamera();
  // Future<String?> pickImageFromGallery();
}
