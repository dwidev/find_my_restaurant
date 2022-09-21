import 'package:provider/provider.dart';

import '../core.dart';
import '../theme/theme_provider.dart';

class LoadingEffectAnimationWidget extends StatefulWidget {
  const LoadingEffectAnimationWidget({
    Key? key,
    required this.isLoading,
    required this.width,
    required this.height,
    this.borderRadius,
  }) : super(key: key);

  final bool isLoading;
  final double width, height;
  final BorderRadiusGeometry? borderRadius;

  @override
  State<LoadingEffectAnimationWidget> createState() =>
      _LoadingEffectAnimationWidgetState();
}

class _LoadingEffectAnimationWidgetState
    extends State<LoadingEffectAnimationWidget> {
  int index = 0;

  late Color mainColor;
  late Color secondColor;
  Alignment begin = Alignment.centerRight;
  Alignment end = Alignment.centerRight;

  @override
  void initState() {
    final theme = context.read<ThemeProvider>();
    mainColor = theme.isDark ? Colors.grey : darkColor;
    secondColor = theme.isDark ? Colors.grey : lightColor;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.isLoading) {
        setState(() {
          mainColor = theme.isDark ? Colors.grey : const Color(0xFFEBEBF4);
          secondColor =
              theme.isDark ? Colors.grey.shade500 : const Color(0xFFF4F4F4);
        });
      }
    });
    super.initState();
  }

  List<Color> get getListColor {
    final theme = context.read<ThemeProvider>();
    if (theme.isDark) {
      return [
        Colors.grey,
        Colors.grey.shade500,
        Colors.grey.shade700,
      ];
    }

    return [
      const Color(0xFFEBEBF4),
      const Color(0xFFF4F4F4),
      const Color(0xFFEBEBF4),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      onEnd: () {
        if (widget.isLoading) {
          setState(() {
            index = index + 1;
            mainColor = getListColor[index % getListColor.length];
            secondColor = getListColor[(index + 1) % getListColor.length];
          });
        }
      },
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: [mainColor, secondColor],
        ),
        borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
      ),
    );
  }
}
