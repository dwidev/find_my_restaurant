import 'package:flutter/cupertino.dart';

import '../core.dart';

class BackIconWidget extends StatelessWidget {
  const BackIconWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.only(
          top: context.mediaQuery.padding.top + 15,
          left: 15,
        ),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: darkColor.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: const Icon(
          CupertinoIcons.back,
          size: 30,
        ),
      ),
    );
  }
}
