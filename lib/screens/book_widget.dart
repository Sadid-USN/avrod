import 'package:flutter/material.dart';

import '../models/text_model.dart';
import 'content_alltext.dart';

class BookWidget extends StatelessWidget {
  final TextsModel text;
  final int index;

  const BookWidget({Key? key, 
    required this.text,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContetAllTexts(
      text: text.text!,
      arabic: text.arabic!,
      translation: text.translation!,
    );
  }
}
