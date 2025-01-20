import 'dart:async';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamify_todo/1%20Core/helper.dart';
import 'package:gamify_todo/2%20General/accessible.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/5%20Service/notification_services.dart';
import 'package:gamify_todo/5%20Service/server_manager.dart';
import 'package:gamify_todo/5%20Service/home_widget_service.dart';
import 'package:window_manager/window_manager.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableBuildModes = [];

  await NotificationService().init();
  await NotificationService().checkNotificationPermissions();
  await NotificationService().checkAlarmPermission();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Helper().registerAdapters();

  if (!kIsWeb && Platform.isWindows) {
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      title: "Next Level",
      size: Size(450, 1000),
      maximumSize: Size(450, 99999),
      minimumSize: Size(400, 600),
      backgroundColor: Colors.transparent,
      // fullScreen: false,
      // skipTaskbar: false,
      // center: true,
      // titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  } else {
    // Initialize home widget
    await HomeWidgetService.setupHomeWidget();
  }

  // auto login
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // final String? email = prefs.getString('email');
  // final String? password = prefs.getString('password');
  // if (email != null && password != null) {
  //   loginUser = await ServerManager().login(
  //     email: email,
  //     password: password,
  //     isAutoLogin: true,
  //   );
  // }

  loginUser = await ServerManager().getUser();

  // Custom Error
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Container(
        color: AppColors.background,
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.main,
              borderRadius: AppColors.borderRadiusAll,
            ),
            child: Wrap(
              children: [
                Column(
                  children: [
                    const Text(
                      "Error",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      details.exception.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  };
}
