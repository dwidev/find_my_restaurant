import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'core/helpers/local_notification_helper.dart';
import 'core/services/backgroud_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  BackgroundService.instance.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await LocalNotificationHelpers.instance.initNotifications();

  runApp(const RestaurantApp());
}
