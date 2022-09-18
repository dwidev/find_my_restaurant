import '../core.dart';

class CircileIconWidget extends StatelessWidget {
  const CircileIconWidget({
    Key? key,
    this.icon,
    this.iconWithProperty,
    required this.onPressed,
    this.isShadow = true,
  }) : super(key: key);

  static const double size = 30;

  final Icon? iconWithProperty;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool isShadow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            if (isShadow)
              BoxShadow(
                color: darkColor.withOpacity(0.1),
                blurRadius: 5,
                spreadRadius: 1,
              ),
          ],
        ),
        child: iconWithProperty ??
            Icon(
              icon,
              size: size,
            ),
      ),
    );
  }
}
