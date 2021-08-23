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
    return DefaultTabController(
      length: 4,
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
                  stops: [0.3, 0.7])),
          ),
          bottom: const TabBar(tabs: [
           Tab(text: 'Дуои 1',),
           Tab(text: 'Дуои 2',),
           Tab(text: 'Дуои 3',),
           Tab(text: 'Дуои 4',),
          ],),
           
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
                return buildBook(texts![widget.textIndex ?? 0] );
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
      ),
    );
  }

  Widget buildBook(Texts texts) {
    return ListView.builder(
        itemCount: texts.text?.length ?? 0,
        itemBuilder: (context, index) {
          final id = texts.id![index];
          // ignore: avoid_unnecessary_containers
          return TabBarView(children:[
            // ignore: avoid_unnecessary_containers
            Container(
             
              child: 
            Center(child: Text(id, style: const TextStyle(fontSize: 25.0),)))
          ] );
        });
  }
}
