import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/core.dart';
import '../../../core/helpers/notif_datetime_helper.dart';
import '../../../core/services/backgroud_service.dart';
import '../../restaurant/services/restaurant_service.dart';

class UserNotificationProvider extends BaseProvider<_NotifState> {
  static const notifKey = "notification";

  final RestaurantService restaurantService;

  UserNotificationProvider({
    required this.restaurantService,
  }) : super(_UserNotificationProviderState()) {
    SharedPreferences.getInstance().then((pref) {
      final isActive = pref.getBool(notifKey) ?? false;
      state = state.copyWith(isRecomendActive: isActive);
    });
  }

  bool get isRecomend => state.isRecomendActive;

  Future<bool> setRecomendationRestaurant(bool value) async {
    final pref = await SharedPreferences.getInstance();
    state = state.copyWith(isRecomendActive: value);

    if (value) {
      await pref.setBool(notifKey, true);
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: NotificationDateTimeHelper.getStartAt(),
        exact: true,
        wakeup: true,
      );
    } else {
      await pref.setBool(notifKey, false);
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}

typedef _NotifState = _UserNotificationProviderState;

class _UserNotificationProviderState extends BaseState {
  final bool isRecomendActive;

  _UserNotificationProviderState({
    this.isRecomendActive = false,
  });

  _UserNotificationProviderState copyWith({
    bool? isRecomendActive,
  }) {
    return _UserNotificationProviderState(
      isRecomendActive: isRecomendActive ?? this.isRecomendActive,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _UserNotificationProviderState &&
        other.isRecomendActive == isRecomendActive;
  }

  @override
  int get hashCode => isRecomendActive.hashCode;
}
