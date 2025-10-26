import 'package:flutter/material.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';

class SliderBox extends StatelessWidget {
  const SliderBox({
    super.key,
    required this.isFilled,
    required this.width,
    required this.height,
  });

  final bool isFilled;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: width * 0.018),
      height: height * 0.010,
      width: width * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isFilled ? Appcolor.primaryColor : Colors.grey.shade300,
        boxShadow: isFilled
            ? [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ]
            : [],
      ),
    );
  }
}
