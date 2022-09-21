import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../../user/providers/user_provider.dart';
import '../data/model/customer_review_model.dart';
import '../data/model/restaurant_model.dart';
import '../providers/detail_resto_provider.dart';

class CustomerReviewPage extends StatefulWidget {
  const CustomerReviewPage({
    Key? key,
    required this.restaurantModel,
  }) : super(key: key);

  final RestaurantModel restaurantModel;

  @override
  State<CustomerReviewPage> createState() => _CustomerReviewPageState();
}

class _CustomerReviewPageState extends State<CustomerReviewPage> {
  late TextEditingController reviewController;

  @override
  void initState() {
    reviewController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  void _onSendRiview() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final name =
        context.read<UserProvider>().state.userModel?.name ?? "Anonymous";
    if (reviewController.text.isNotEmpty) {
      context.read<DetailRestoProvider>().addReviewByUser(
            name: name,
            restoId: widget.restaurantModel.id,
            review: reviewController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final watchProvDetail = context.watch<DetailRestoProvider>();
    final reviews =
        context.select<DetailRestoProvider, List<CustomerReviewModel>>((prov) =>
            prov.state.restaurantModel?.customerReviews.reversed.toList() ??
            []);
    if (watchProvDetail.isSuccess) {
      reviewController.clear();
    }

    if (watchProvDetail.isError) {
      context.showSnackbar(
        watchProvDetail.errorFailure?.message ??
            "Upss review kamu belum terkirim sepertinya terjadi kesalahan",
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reviews - ${widget.restaurantModel.name}",
          overflow: TextOverflow.fade,
          maxLines: 5,
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: EdgeInsets.zero.copyWith(bottom: 80),
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
                              style: context.textTheme.caption,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              review.review,
                              style: context.textTheme.caption,
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
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(20).copyWith(bottom: 10),
              width: context.widthSize,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Material(
                      borderRadius: BorderRadius.circular(50),
                      elevation: 20,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 80),
                        child: TextField(
                          controller: reviewController,
                          decoration: InputDecoration(
                            fillColor: context.isDark
                                ? Colors.grey.shade900
                                : Colors.white,
                            hintText: "Masukin review kamu disini ya",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          maxLines: null,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Material(
                    borderRadius: BorderRadius.circular(50),
                    elevation: 20,
                    child: CircileIconWidget(
                      // backgroundColor: isd,
                      onPressed: _onSendRiview,
                      iconWithProperty: const Icon(
                        Icons.send,
                        size: 20,
                      ),
                      isShadow: false,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
