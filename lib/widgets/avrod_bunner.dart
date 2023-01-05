import 'package:flutter/material.dart';

class AvrodBunner extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;
  const AvrodBunner({
    Key? key,
    required this.height,
    required this.width,
    required this.borderRadius,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.9,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade400,
                  offset: const Offset(4.0, 4.0),
                  blurRadius: 3.0,
                  spreadRadius: 1.0),
              BoxShadow(
                  color: Colors.grey[200]!,
                  offset: const Offset(-2.0, -2.0),
                  blurRadius: 3.0,
                  spreadRadius: 1.0),
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          child: Image.asset(
            'assets/images/iconavrod.png',
            height: 190,
            width: 190,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
