import 'package:avrod/controller/text_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySlider extends StatelessWidget {
  const MySlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TextScreenController>(
      builder: (controller) => SizedBox(
        width: MediaQuery.of(context).size.width / 3 * 2.2,
        child: SliderTheme(
          data: const SliderThemeData(
            thumbColor: Colors.red,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 3.0),
          ),
          child: Slider(
            mouseCursor: MouseCursor.uncontrolled,
            onChanged: (double newPosition) {
              controller.audioPlayer
                  .seek(Duration(seconds: newPosition.round()));
              controller.update();
            },
            onChangeEnd: (double value) {
              // when the user finishes dragging the slider, update the position of the audio player
              controller.audioPlayer.seek(Duration(seconds: value.round()));
              // you may also want to update the UI to reflect the new position of the audio player
              controller.update();
            },
            activeColor: Colors.white,
            inactiveColor: Colors.blueGrey.shade200,
            min: 0.0,
            max: controller.duration.inSeconds.toDouble(),
            value: controller.position.inSeconds.toDouble(),
          ),
        ),
      ),
    );
  }
}
