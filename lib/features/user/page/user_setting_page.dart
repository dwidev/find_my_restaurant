import 'dart:io';

import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../../../core/theme/theme_provider.dart';
import '../providers/user_notification_provider.dart';

class UserSettingsPage extends StatefulWidget {
  static const routeName = "UserSettingsPage";

  const UserSettingsPage({Key? key}) : super(key: key);

  @override
  State<UserSettingsPage> createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Notifikasi rekomendasi",
                        style: context.textTheme.titleSmall,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(
                          "aktifkan untuk memberikan rekomendasi restaurant tiap hari nya",
                          style: context.textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                ),
                Consumer<UserNotificationProvider>(
                  builder: (context, prov, child) {
                    return Switch(
                      value: prov.isRecomend,
                      onChanged: (value) {
                        if (Platform.isAndroid) {
                          prov.setRecomendationRestaurant(value);
                        } else {
                          context.showSnackbar(
                            "Sobat finds sabarya fitur ini akan segera tayang di IOS",
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tema aplikasi",
                        style: context.textTheme.titleSmall,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(
                          "Mode ${theme.isDark ? "gelap" : "terang"}",
                          style: context.textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: theme.isDark,
                  onChanged: (darkMode) {
                    if (darkMode) {
                      context.read<ThemeProvider>().setDarkTheme();
                    } else {
                      context.read<ThemeProvider>().setLightTheme();
                    }
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
