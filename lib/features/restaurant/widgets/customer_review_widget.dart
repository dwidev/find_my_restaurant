import '../../../core/core.dart';
import '../data/model/customer_review_model.dart';

class CustomerReviewWidget extends StatelessWidget {
  const CustomerReviewWidget({
    Key? key,
    required this.reviews,
  }) : super(key: key);

  final List<CustomerReviewModel> reviews;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  child: Text(review.name[0].toUpperCase()),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.name,
                        style: context.textTheme.bodyText1?.copyWith(),
                      ),
                      Text(
                        review.date,
                        style: context.textTheme.caption?.copyWith(
                          color: darkColor.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(review.review),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
