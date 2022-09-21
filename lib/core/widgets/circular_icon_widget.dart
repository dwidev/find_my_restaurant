import 'package:provider/provider.dart';

import '../core.dart';
import '../theme/theme_provider.dart';

class CircileIconWidget extends StatelessWidget {
  const CircileIconWidget({
    Key? key,
    this.icon,
    this.iconWithProperty,
    required this.onPressed,
    this.isShadow = true,
    this.shadow,
    this.backgroundColor,
  }) : super(key: key);

  static const double size = 30;

  final Color? backgroundColor;
  final Icon? iconWithProperty;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool isShadow;
  final BoxShadow? shadow;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor ??
              (theme.isDark ? Colors.grey.shade900 : Colors.white),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            if (isShadow)
              shadow ??
                  BoxShadow(
                    color: darkColor.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
          ],
        ),
        child: Center(
          child: iconWithProperty ??
              Icon(
                icon,
                size: size,
              ),
        ),
      ),
    );
  }
}
