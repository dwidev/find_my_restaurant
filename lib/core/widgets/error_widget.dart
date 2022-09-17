import '../core.dart';
import '../services/failure.dart';
import '../services/http_failure.dart';

class RestoErrorWidget extends StatelessWidget {
  const RestoErrorWidget({
    Key? key,
    required this.failure,
    required this.onRetry,
  }) : super(key: key);

  final Failure? failure;
  final VoidCallback onRetry;

  String _getErrorIcon() {
    if (failure is InternetConnectionFailure) {
      return noSignalIcon;
    } else {
      return errorIcon;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            _getErrorIcon(),
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: context.widthSize / 1.5,
            child: Text(
              failure?.message ?? "-",
              style: context.textTheme.caption?.copyWith(
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text("Coba lagi"),
          ),
        ],
      ),
    );
  }
}
