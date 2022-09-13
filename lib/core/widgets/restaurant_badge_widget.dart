import '../core.dart';

class RestaurantBadgeWidget extends StatelessWidget {
  const RestaurantBadgeWidget({
    Key? key,
    required this.text,
    this.textColor,
    this.backgroundColor,
  }) : super(key: key);

  final String text;
  final Color? textColor, backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColor ?? accentColor,
      ),
      child: Text(
        text,
        style: context.textTheme.caption?.copyWith(
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }
}
