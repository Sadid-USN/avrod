import 'package:flutter/material.dart';

class DurationAndPosition extends StatelessWidget {
  final Duration duration;
  final Duration position;
  const DurationAndPosition({
    Key? key,
    required this.duration,
    required this.position,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.white),
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Text(
            duration.toString().split('.').first,
            style: const TextStyle(fontSize: 10, color: Colors.white),
          ),
        ),
        const Spacer(
          flex: 3,
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.white),
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Text(
            position.toString().split('.').first,
            style: const TextStyle(fontSize: 10, color: Colors.white),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
