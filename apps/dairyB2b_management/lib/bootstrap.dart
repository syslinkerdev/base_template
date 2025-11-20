import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:core/core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:dairyB2b_management/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dairyB2b_management/app/app_base/shared_prefs_provider.dart';

Future<void> bootstrap(Widget Function() createApp) async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 🔹 Load Environment Variables
  await EnvLoader.load(); // Load from .env
  // debugPrint("✅ Loaded env for: ${AppEnv.appName}");

  // 🔹 Firebase Init
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
      webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.debug);

  // Lock to portrait
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await _initInjector();

  if (Platform.isAndroid || Platform.isIOS) {
    await _initOS();
  }

  // Init SharedPreferences and ProviderContainer
  final sharedPrefs = await SharedPreferences.getInstance();
  final container = ProviderContainer(
      overrides: [sharedPrefsProvider.overrideWithValue(sharedPrefs)]);

  _setupErrorHandling(() => runApp(
      UncontrolledProviderScope(container: container, child: createApp())));
}

//const Color.fromARGB(255, 124, 77, 255)
Future<void> _initInjector() async => ColorX.setSeed(AppEnv.seedColor);

Future<void> _initOS() async {}

void _setupErrorHandling(void Function() runApp) {
  if (!kIsWeb) {
    Isolate.current.addErrorListener(
      RawReceivePort((List<dynamic> pair) async {
        try {
          final errorAndStacktrace = pair;
          await FirebaseCrashlytics.instance.recordError(
            errorAndStacktrace.first,
            errorAndStacktrace.last as StackTrace,
          );
        } catch (e, _) {
          // log('[Isolate error]', error: e, stackTrace: st);
        }
      }).sendPort,
    );
  }

  runApp();
  FlutterNativeSplash.remove();
}
