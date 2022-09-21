import 'dart:async';
import 'dart:math';

import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../providers/user_provider.dart';

Future<void> showNoSessionDialog(BuildContext context) async {
  showModalBottomSheet(
    enableDrag: false,
    isScrollControlled: true,
    isDismissible: false,
    context: context,
    builder: (context) {
      return const _NoSessionWidget();
    },
  );
}

class _NoSessionWidget extends StatefulWidget {
  const _NoSessionWidget({Key? key}) : super(key: key);

  @override
  State<_NoSessionWidget> createState() => _NoSessionWidgetState();
}

class _NoSessionWidgetState extends State<_NoSessionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Timer timer;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timer.tick % 2 == 0) {
        animationController.repeat();
      } else {
        animationController.stop();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    animationController
      ..stop()
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<UserProvider>();

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10).copyWith(
          bottom: context.mediaQuery.viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                final sineValue = sin(2 * 2 * pi * animationController.value);
                return Transform.translate(
                  offset: Offset(0, sineValue),
                  child: Image.asset(
                    errorIcon,
                    width: 100,
                    height: 100,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: context.widthSize / 1.5,
              child: Text(
                "Upss.. sepertinya finds belum mengenal kamu :( input nama kamu yuk biar finds bisa memberikan fitur lainnya untuk kamu",
                style: context.textTheme.caption?.copyWith(
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 25),
            TextField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: "Masukin nama kamu ya...",
                errorStyle: TextStyle(color: Colors.red),
              ),
              onSubmitted: (value) {
                if (value.isEmpty) {
                  return;
                }

                context.read<UserProvider>().onSetUser(
                      name: value,
                      callbackSuccess: () {
                        if (prov.isSession) {
                          context.pop();
                          context.showSnackbar(
                            "Terima kasih sobat finds, Enjoyyy!!!",
                          );
                        }
                      },
                      callbackError: () {
                        context.showSnackbar(
                          prov.state.errorFailure?.message ?? "",
                        );
                      },
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
