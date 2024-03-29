import 'package:avrod/Calendars/gregorian_calendar.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import '../constant/colors/colors.dart';
import 'calendar_hijri.dart';

class CalendarTabBarView extends StatefulWidget {
  const CalendarTabBarView({Key? key}) : super(key: key);
  static String routName = '/calendarTabBarView';
  @override
  _CalendarTabBarViewState createState() => _CalendarTabBarViewState();
}

class _CalendarTabBarViewState extends State<CalendarTabBarView> {
  final pages = [
    // ignore: avoid_unnecessary_containers
    // Container(color: Colors.white, child: const HijriPickerScreen()),
    Container(color: Colors.white, child: const GregorianCalendar()),
  ];
  LiquidController? liquidController;

  @override
  void initState() {
    super.initState();
    liquidController = LiquidController();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (contex) {
      return Scaffold(
        body: LiquidSwipe(
            positionSlideIcon: 0.8,
            slideIconWidget: Container(
                decoration: const BoxDecoration(
                    color: gradientStartColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0)
                    ],
                    borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(5), left: Radius.circular(12))),
                height: 35,
                width: 35,
                child: const Icon(Icons.arrow_back,
                    size: 30, color: Colors.white)),
            enableSideReveal: false,
            liquidController: liquidController,
            pages: pages),
      );
    });
  }
}
