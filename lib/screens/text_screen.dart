import 'package:avrod/colors/colors.dart';
import 'package:avrod/data/book_class.dart';
import 'package:avrod/data/book_map.dart';
import 'package:flutter/material.dart';

class TextScreen extends StatefulWidget {
  final int ?textIndex;
  final Texts? texts;
  const TextScreen({Key? key, this.textIndex,  this.texts}) : super(key: key);
  @override
  _TextScreenState createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Лафзи бобҳо'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [gradientStartColor, gradientEndColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.3, 0.7])),
        child: FutureBuilder<List<Texts>>(
          future: TextsMap.getTextsLocally(context),
          builder: (contex, snapshot) {
            final texts = snapshot.data;

            if (snapshot.hasData) {
              return buildBook(texts![widget.textIndex ?? 0]);
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Some erro occured'),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget buildBook(Texts texts) {
    return ListView.builder(
        itemCount: texts.text?.length ?? 0,
        itemBuilder: (context, index) {
          //final text = texts.text![index];
          // ignore: avoid_unnecessary_containers
          return Container(child: Center(child: Text(texts.id ?? '', style: const TextStyle(fontSize: 25.0),)));
        });
  }
}
