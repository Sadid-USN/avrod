import 'package:avrod/chat/helper/text_style.dart';
import 'package:flutter/material.dart';

import 'package:avrod/constant/colors/colors.dart';

class ChatDrawer extends StatelessWidget {
  final String userName;
  final String userEmail;
  final Column column;

  const ChatDrawer({
    Key? key,
    required this.userName,
    required this.userEmail,
    required this.column,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: bgColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 70,
            ),
            Image.asset(
              'assets/icons/profile.png',
              height: 150,
            ),
            const SizedBox(
              height: 8,
            ),
            CustomText(
              title: userEmail,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(
              height: 5,
            ),
            CustomText(
              title: userName.toUpperCase(),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(
              height: 20,
            ),
            column,
          ],
        ),
      ),
    );
  }
}
