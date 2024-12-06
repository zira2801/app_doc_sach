import 'package:flutter/material.dart';

class TimKiemBoSuuTap extends StatefulWidget {
  const TimKiemBoSuuTap({super.key});

  @override
  State<TimKiemBoSuuTap> createState() => _TimKiemBoSuuTapState();
}

class _TimKiemBoSuuTapState extends State<TimKiemBoSuuTap> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      height: 80,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.blue,
            )
          ],
        ),
      ),
    ));
  }
}
