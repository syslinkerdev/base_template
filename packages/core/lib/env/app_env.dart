import 'package:flutter/material.dart';
import 'env_loader.dart';

class AppEnv {
  // 🔹 Company & System Info
  static String get companyName =>
      EnvLoader.get("COMPANY_NAME", fallback: "Company");
  static String get systemName =>
      EnvLoader.get("SYSTEM_NAME", fallback: "System");

  // 🔹 App Info
  static String get appName => EnvLoader.get("APP_NAME", fallback: "App");
  static String get packageId =>
      EnvLoader.get("APP_PACKAGE_ID", fallback: "com.company.app");
  static String get version =>
      EnvLoader.get("APP_VERSION", fallback: "Version");

  // 🔹 Logo / Assets
  static String get logoPath =>
      EnvLoader.get("LOGO_PATH", fallback: "assets/img_placeholder.png");

  // 🔹 Firebase / Backend
  static String get firebaseProjectId =>
      EnvLoader.get("FIREBASE_PROJECT_ID", fallback: "default_project");

  // 🔹 Colors
  static Color get seedColor {
    final raw = EnvLoader.get("SEED_COLOR", fallback: "0xFF7C4DFF").trim();
    try {
      final color = Color(int.parse(raw));
      return color;
    } catch (e) {
      return const Color(0xFF7C4DFF);
    }
  }
}
