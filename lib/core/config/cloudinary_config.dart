import 'package:flutter_dotenv/flutter_dotenv.dart';

class CloudinaryConfig {
  static final CloudinaryConfig _instance = CloudinaryConfig._internal();
  factory CloudinaryConfig() => _instance;
  CloudinaryConfig._internal();

  late final String cloudName;
  late final String apiKey;
  late final String apiSecret;

  Future<void> init() async {
    await dotenv.load(fileName: ".env");

    cloudName =
        dotenv.env['CLOUDINARY_CLOUD_NAME'] ??
        (throw Exception('CLOUDINARY_CLOUD_NAME not found in .env'));
    apiKey =
        dotenv.env['CLOUDINARY_API_KEY'] ??
        (throw Exception('CLOUDINARY_API_KEY not found in .env'));
    apiSecret =
        dotenv.env['CLOUDINARY_API_SECRET'] ??
        (throw Exception('CLOUDINARY_API_SECRET not found in .env'));
  }
}
