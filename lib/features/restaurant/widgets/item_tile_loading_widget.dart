import '../../../core/core.dart';

class RestaurantTileLoadingWidget extends StatelessWidget {
  const RestaurantTileLoadingWidget({
    Key? key,
    required this.isLoading,
  }) : super(key: key);

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      width: context.widthSize,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoadingEffectAnimationWidget(
            isLoading: isLoading,
            width: 100,
            height: 80,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LoadingEffectAnimationWidget(
                      isLoading: isLoading,
                      width: 130,
                      height: 10,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                LoadingEffectAnimationWidget(
                  isLoading: isLoading,
                  width: 100,
                  height: 10,
                ),
                const SizedBox(height: 10),
                LoadingEffectAnimationWidget(
                  isLoading: isLoading,
                  width: 60,
                  height: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
