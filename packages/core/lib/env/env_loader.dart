import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvLoader {
  static Future<void> load() async {
    await dotenv.load(fileName: "assets/.env");
  }

  static String get(String key, {String fallback = ""}) {
    return dotenv.env[key] ?? fallback;
  }
}
