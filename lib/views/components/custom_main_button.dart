import 'package:flutter/material.dart';

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
            fixedSize: Size(screenSize.width * 0.50, screenSize.width * 0.13)),
        onPressed: onPressed,
        child: !isLoading
            ? child
            : const AspectRatio(
                aspectRatio: 1 / 1,
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    )),
              ));
  }
}
