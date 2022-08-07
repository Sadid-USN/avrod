import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Calendars/calendar_tabbar.dart';
import '../screens/search_screen.dart';

class BottomNavBar extends ChangeNotifier {
  //Dcloration
  String? data;
  List<dynamic>? bookFromFB;

  int selectedIndex = 2;
  final String _lounchGooglePlay =
      'https://play.google.com/store/apps/details?id=com.darulasar.avrod';
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: false,
          forceWebView: false,
          headers: <String, String>{'header_key': 'header_value'});
    } else {
      throw 'Пайванд кушода нашуд $url';
    }
  }

  //List<dynamic>? books;
  void onTapBar(context, int index) {
    selectedIndex = index;
    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SearchScreen();
      }));
    } else if (index == 1) {
      // Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return const SelectedBooks();
      // }));
    } else if (index == 2) {
      // Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return const SelectedBooks();
      // }));
    } else if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const CalendarTabBarView();
      }));
    } else if (index == 4) {
      _launchInBrowser(_lounchGooglePlay);
    }
    notifyListeners();
  }
}
