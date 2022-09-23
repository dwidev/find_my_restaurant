import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../features/restaurant/data/model/restaurant_model.dart';
import '../../features/restaurant/pages/detail_restaurant_page.dart';
import '../../features/restaurant/providers/detail_resto_provider.dart';
import '../core.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class LocalNotificationHelpers {
  static LocalNotificationHelpers? _instance;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  LocalNotificationHelpers._internal() {
    _instance = this;
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  }

  static LocalNotificationHelpers get instance =>
      _instance ?? LocalNotificationHelpers._internal();

  Future<void> initNotifications() async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        selectNotificationSubject.add(details.payload ?? '');
      },
    );
  }

  Future<void> showNotification({
    required String userName,
    required RestaurantModel restaurantModel,
  }) async {
    var channelId = "1";
    var channelName = "channel_01";
    var channelDescription = "find my restaurant notification channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: const DefaultStyleInformation(true, true),
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    var titleNotification = "<b>Haiiii $userName </b>";
    var titleNews =
        "finds ada rekomendasi restaurant untuk kamu nih <b>${restaurantModel.name}</b>, yukk cek sekarang";

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      titleNews,
      platformChannelSpecifics,
      payload: restaurantModel.toJson(),
    );
  }

  void configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        final restaurantModel = RestaurantModel.fromJson(payload);
        navigatorKey.currentContext
            ?.read<DetailRestoProvider>()
            .getDetailResto(restaurantModel.id);
        final heroTag = "list-tile-${restaurantModel.id}";
        final args = DetailRestaurantPageArgs(
          restoId: restaurantModel.id,
          heroTag: heroTag,
          image: "$largeResolution${restaurantModel.pictureId}",
          distance: restaurantModel.distance,
        );
        Navigation.intentWithData(
          DetailRestaurantPage.routeName,
          args,
        );
      },
    );
  }
}
