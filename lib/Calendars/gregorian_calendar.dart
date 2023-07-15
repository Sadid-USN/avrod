import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:table_calendar/table_calendar.dart';

import '../constant/colors/colors.dart';

class GregorianCalendar extends StatefulWidget {
  const GregorianCalendar({Key? key}) : super(key: key);
  static const routName = '/calendar';

  @override
  _GregorianCalendarState createState() => _GregorianCalendarState();
}

class _GregorianCalendarState extends State<GregorianCalendar> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
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
          'calendar'.tr,
          style: TextStyle(fontSize: 18, color: calendarAppbar),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: TableCalendar(
          calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.blueAccent),
              isTodayHighlighted: true,
              selectedDecoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.green),
              selectedTextStyle: TextStyle(color: Colors.white)),
          daysOfWeekVisible: true,
          onDaySelected: (DateTime selecteDay, DateTime focuseDay) {
            setState(() {
              selectedDay = selecteDay;
              focusedDay = focuseDay;
            });
          },
          selectedDayPredicate: (DateTime date) {
            return isSameDay(selectedDay, date);
          },
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarFormat: format,
          focusedDay: selectedDay,
          firstDay: DateTime(1988),
          lastDay: DateTime(2050),
          onFormatChanged: (CalendarFormat format) {
            setState(() {
              format = format;
            });
          },
        ),
      ),
    );
  }
}
