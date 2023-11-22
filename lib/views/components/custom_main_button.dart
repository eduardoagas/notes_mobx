import 'package:flutter/material.dart';

import '../../constants/dimensions.dart';
import '../../utils/get_screen_size.dart';

class CustomMainButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool isLoading;
  final VoidCallback onPressed;
  const CustomMainButton(
      {Key? key,
      required this.child,
      required this.color,
      required this.isLoading,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = GetScreenSize().getScreenSize();
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            maximumSize: Size(
              Dimensions.width150,
              Dimensions.height50,
            ),
            fixedSize: Size(screenSize.width * 0.50, screenSize.height * 0.06)),
        onPressed: onPressed,
        child: !isLoading
            ? child
            : AspectRatio(
                aspectRatio: 1 / 1,
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.width5),
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                    )),
              ));
  }
}
