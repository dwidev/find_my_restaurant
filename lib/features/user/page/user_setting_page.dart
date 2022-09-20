import '../../../core/core.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
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
                Switch(
                  value: false,
                  onChanged: (value) {},
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
                          "Mode terang",
                          style: context.textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: false,
                  onChanged: (value) {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
