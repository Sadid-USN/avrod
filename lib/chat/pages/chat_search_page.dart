import 'package:flutter/material.dart';

class ChatSearchPage extends StatelessWidget {
  const ChatSearchPage({Key? key}) : super(key: key);
  static String routName = '/chatSearchPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Text(
              'SEARCH PAGE',
              style: TextStyle(color: Colors.black54, fontSize: 50),
            ),
          ),
        ],
      ),
    );
  }
}
