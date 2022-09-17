import '../core.dart';

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
  List<Color> colorList = [
    const Color(0xFFEBEBF4),
    const Color(0xFFF4F4F4),
    const Color(0xFFEBEBF4),
  ];

  int index = 0;

  Color mainColor = darkColor;
  Color secondColor = lightColor;
  Alignment begin = Alignment.centerRight;
  Alignment end = Alignment.centerRight;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.isLoading) {
        setState(() {
          mainColor = lightColor;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      onEnd: () {
        if (widget.isLoading) {
          setState(() {
            index = index + 1;
            mainColor = colorList[index % colorList.length];
            secondColor = colorList[(index + 1) % colorList.length];
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
