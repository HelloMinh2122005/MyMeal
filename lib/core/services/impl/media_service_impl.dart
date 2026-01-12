import 'dart:io' show Platform;
import 'package:my_flutter_app/core/services/media_service.dart';
import 'package:image_picker/image_picker.dart';
import '../../config/cloudinary_config.dart';

class MediaServiceImpl implements MediaService {
  // Create a static variable to store only one time instance for the whole app life cycle
  static MediaServiceImpl? _instance;
  final ImagePicker _picker = ImagePicker();
  final CloudinaryConfig _config;

  // factory constructor instead of normal constructor
  // => return the same instance every time
  factory MediaServiceImpl(CloudinaryConfig config) {
    _instance ??= MediaServiceImpl._internal(config);
    return _instance!;
  }

  // Private named constructor, only allow to call private inside the class
  MediaServiceImpl._internal(this._config);

  @override
  Future<String?> captureImageWithCamera() async {
    try {
      // Check if the platform supports camera capture
      if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        final XFile? photo = await _picker.pickImage(
          source: ImageSource.gallery,
        );
        return photo?.path;
      } else {
        final XFile? photo = await _picker.pickImage(
          source: ImageSource.camera,
        );
        return photo != null ? uploadToCloud(photo) : '';
      }
    } catch (e) {
      throw Exception('Failed to capture image: $e');
    }
  }

  String uploadToCloud(XFile imageFile) {
    try {
      return '';
    } catch (e) {
      throw Exception('Failed to upload image to cloud: $e');
    }
  }
}
