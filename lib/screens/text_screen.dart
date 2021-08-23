import 'package:avrod/colors/colors.dart';
import 'package:avrod/data/book_class.dart';
import 'package:avrod/data/book_map.dart';
import 'package:flutter/material.dart';

class TextScreen extends StatefulWidget {
  final List<Texts>? texts;

  const TextScreen({Key? key, this.texts}) : super(key: key);

  @override
  _TextScreenState createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.texts!.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: const Text('Лафзи дуо'),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [gradientStartColor, gradientEndColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.3, 0.7],
              ),
            ),
          ),
          bottom: TabBar(
            tabs: widget.texts!
                .map(
                  (Texts e) => Tab(text: e.id),
                )
                .toList(),
          ),
        ),
        body: TabBarView(
          children: widget.texts!
              .map((e) => Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [gradientStartColor, gradientEndColor],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.3, 0.7],
                      ),
                    ),
                    child: Builder(builder: (context) {
                      return buildBook(e);
                    }),
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget buildBook(Texts texts) {
    return ListView(
      children: [
        _contentItem(texts.id!),
        _contentItem(texts.text!),
        _contentItem(texts.arabic!),
        _contentItem(texts.translation!),
      ],
    );
  }

  Widget _contentItem(String text) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
