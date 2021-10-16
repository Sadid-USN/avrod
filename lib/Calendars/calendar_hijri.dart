import 'package:avrod/colors/colors.dart';
import 'package:avrod/colors/gradient_class.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:hijri_picker/hijri_picker.dart';

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
        backgroundColor: Colors.white70,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: favoriteGradient,
          ),
          elevation: 0.0,
          backgroundColor: gradientStartColor,
          title: const Text('Тақвими ҳиҷрӣ', style: TextStyle(fontSize: 22)),
          centerTitle: true,
        ),
        // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
        body: Container(
          height: double.infinity,
          decoration: favoriteGradient,
          width: double.infinity,
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
