import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:hijri_picker/hijri_picker.dart';

import '../constant/colors/colors.dart';
import '../constant/colors/gradient_class.dart';

class HijriPickerScreen extends StatefulWidget {
  const HijriPickerScreen({Key? key}) : super(key: key);

  @override
  _HijriPickerScreenState createState() => _HijriPickerScreenState();
}

class _HijriPickerScreenState extends State<HijriPickerScreen> {
  HijriCalendar selectedDate = HijriCalendar.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          elevation: 3.0,
          backgroundColor: appBabgColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12))),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: Text(
            'hijri'.tr,
            style: TextStyle(fontSize: 18, color: calendarAppbar),
          ),
          centerTitle: true,
        ),
        // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: favoriteGradient,
          child: HijriMonthPicker(
            lastDate: HijriCalendar()
              ..hYear = 1445
              ..hMonth = 9
              ..hDay = 25,
            firstDate: HijriCalendar()
              ..hYear = 1438
              ..hMonth = 12
              ..hDay = 25,
            onChanged: (HijriCalendar value) {
              setState(() {
                selectedDate = value;
              });
            },
            selectedDate: selectedDate,
          ),
        ));
  }
}
