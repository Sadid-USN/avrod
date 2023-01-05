import 'package:avrod/constant/colors/colors.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final void Function() onPressed;
  final String buttonTitle;
  const LoginButton(
      {Key? key, required this.onPressed, required this.buttonTitle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: navItemsColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32))),
        onPressed: onPressed,
        child: Text(
          buttonTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
