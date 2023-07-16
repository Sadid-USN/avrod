import 'package:avrod/widgets/radioplayer_body.dart';
import 'package:flutter/material.dart';



class RadioPlayerScreen extends StatelessWidget {
  static String routName = '/radioPlayerScreen';
  const RadioPlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    const Scaffold(
     
          backgroundColor: Color(0xffF3EEE2),
        
          body: RadioPlayerBody(),
        );
    
  }
}
