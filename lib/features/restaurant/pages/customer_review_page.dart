import '../../../core/core.dart';
import '../data/model/customer_review_model.dart';

class CustomerReviewPage extends StatelessWidget {
  const CustomerReviewPage({
    Key? key,
    required this.reviews,
  }) : super(key: key);

  final List<CustomerReviewModel> reviews;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reviews"),
      ),
      body: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final review = reviews[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: lightColor,
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
                        const SizedBox(height: 2),
                        Text(
                          review.date,
                          style: context.textTheme.caption?.copyWith(
                            color: darkColor.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          review.review,
                          style: context.textTheme.caption?.copyWith(
                            color: darkColor,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
