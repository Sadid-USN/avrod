import 'package:animate_icons/animate_icons.dart';
import 'package:avrod/constant/colors/colors.dart';
import 'package:avrod/controller/text_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FontMagnifiereButton extends StatelessWidget {
  const FontMagnifiereButton({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextScreenController controller = Get.put(TextScreenController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimateIcons(
          startIcon: Icons.remove_circle_outline,
          endIcon: Icons.remove_circle_outline,
          controller: controller.buttonController,
          size: 35.0,
          onStartIconPress: () {
            controller.decreaseSize();
            return true;
          },
          onEndIconPress: () {
            controller.decreaseSize();
            return true;
          },
          duration: const Duration(milliseconds: 250),
          startIconColor: listTitleColor,
          endIconColor: listTitleColor,
          clockwise: false,
        ),
        const SizedBox(
          width: 20,
        ),
        AnimateIcons(
          startIcon: Icons.add_circle_outline,
          endIcon: Icons.add_circle_outline,
          controller: controller.buttonController,
          size: 35.0,
          onStartIconPress: () {
            controller.increaseSize();
            return true;
          },
          onEndIconPress: () {
            controller.increaseSize();
            return true;
          },
          duration: const Duration(milliseconds: 250),
          startIconColor: listTitleColor,
          endIconColor: listTitleColor,
          clockwise: false,
        ),
      ],
    );
  }
}
