import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constant/colors/colors.dart';

class Watch extends StatefulWidget {
  final double fontSize;
  const Watch({Key? key, required this.fontSize}) : super(key: key);
  @override
  State<Watch> createState() => _WatchState();
}

class _WatchState extends State<Watch> {
  Timer? _timer;
  @override
  void initState() {
    _timer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  String? _timeString;
  void _getTime() {
    final String formattedDateTime =
        DateFormat('kk:mm:ss').format(DateTime.now()).toString();
    setState(() {
      _timeString = formattedDateTime;
      // print(_timeString);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black38, offset: Offset(0.0, 2.0), blurRadius: 6.0)
        ],
        color: bgColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: _timeString == null
          ?  SizedBox(
            width: 100,
            height: 30,
            child: Center(
                child: LinearProgressIndicator(color: audiplayerColor, backgroundColor: Colors.grey.shade200,),
              ),
          )
          : Text(
              _timeString.toString(),
              style: TextStyle(
                fontSize: widget.fontSize,
                color: navigationColor,
              ),
            ),
    );
  }
}
