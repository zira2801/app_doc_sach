import 'package:flutter/material.dart';

class CustomWarningIcon extends StatelessWidget {
  final double size;
  final Color color;

  const CustomWarningIcon({Key? key, this.size = 50.0, this.color = Colors.orange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.warning,
      size: size,
      color: color,
    );
  }
}