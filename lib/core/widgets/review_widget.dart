import '../core.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({
    Key? key,
    required this.rating,
  }) : super(key: key);

  final double rating;

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = const Icon(
        Icons.star_outline,
        color: primaryColor,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = const Icon(
        Icons.star_half,
        color: primaryColor,
      );
    } else {
      icon = const Icon(
        Icons.star,
        color: primaryColor,
      );
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(5, (index) => buildStar(context, index)),
    );
  }
}
