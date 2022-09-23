import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';

import '../../features/restaurant/services/restaurant_service.dart';
import '../../features/user/preferences/user_preferences.dart';
import '../helpers/local_notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  static BackgroundService get instance =>
      _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    final restaurantService = RestaurantServiceImpl(
      client: Dio(),
      userPreference: UserPreferenceImpl(),
    );
    final user = await restaurantService.userPreference.getUser();
    final restaurantModel =
        await restaurantService.getRecomendationRestaurant();

    if (restaurantModel != null) {
      await LocalNotificationHelpers.instance.showNotification(
        userName: user.name,
        restaurantModel: restaurantModel,
      );
    }

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
