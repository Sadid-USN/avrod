import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:avrod/constant/colors/colors.dart';
import 'package:avrod/controller/text_screen_controller.dart';

class FontMagnifiereButton extends StatelessWidget {
  const FontMagnifiereButton({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(TextScreenController());

    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Ҳаҷми чоп'),
                      const SizedBox(
                        height: 16,
                      ),
                    
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _FontSizeDialog(
                            icon: Icons.remove_circle_outline,
                            buttonController: controller.buttonController,
                            onStartIconPress: () {
                              controller.decreaseSize();
                              return true;
                            },
                            onEndIconPress: () {
                              controller.decreaseSize();
                              return true;
                            },
                            fontSize: controller.fontSize,
                          ),
                          _FontSizeDialog(
                            icon: Icons.add,
                            buttonController: controller.buttonController,
                            onStartIconPress: () {
                              controller.increaseSize();
                              return true;
                            },
                            onEndIconPress: () {
                              controller.increaseSize();
                              return true;
                            },
                            fontSize: controller.fontSize,
                          ),
                        ],
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: const Text("Сабт"),
                      onPressed: () => Get.back(),
                    ),
                  ],
                );
              });
        },
        icon: SvgPicture.asset(
          'assets/svg/font_size.svg',
          height: 30,
          color: audiplayerColor,
        ),
      ),
    );
  }
}

class _FontSizeDialog extends StatelessWidget {
  final double fontSize;
  final AnimateIconController buttonController;
  final bool Function() onStartIconPress;
  final bool Function() onEndIconPress;
  final IconData icon;
  _FontSizeDialog({
    Key? key,
    required this.fontSize,
    required this.buttonController,
    required this.onStartIconPress,
    required this.onEndIconPress,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimateIcons(
      startIcon: icon,
      endIcon: icon,
      controller: buttonController,
      size: 30.0,
      onStartIconPress: onStartIconPress,
      onEndIconPress: onEndIconPress,
      duration: const Duration(milliseconds: 250),
      startIconColor: listTitleColor,
      endIconColor: listTitleColor,
      clockwise: false,
    );
  }
}
