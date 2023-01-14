import 'package:flutter/material.dart';

snackBar(BuildContext context, Color color, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 2500),
      backgroundColor: color,
      content: Text(
        content,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),

        // const TextStyle(

        // ),
      ),
    ),
  );
}

class MyDialog extends StatefulWidget {
  final Text content;
  final void Function()? onTap;
  const MyDialog({
    Key? key,
    required this.content,
    this.onTap,
  }) : super(key: key);
  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onTap,
        child: AlertDialog(
          content: widget.content,
        ));
  }
}
