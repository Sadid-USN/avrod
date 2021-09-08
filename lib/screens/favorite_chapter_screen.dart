
import 'package:avrod/colors/colors.dart';
import 'package:avrod/data/book_class.dart';
import 'package:avrod/main.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteChapterSceen extends StatelessWidget {
  const FavoriteChapterSceen({Key? key, this.chapter}) : super(key: key);
 final Chapter ?chapter;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [gradientStartColor, gradientEndColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.3, 0.7])),
          ),
          centerTitle: true,
          title: const Text('Фаслҳои маҳбуб'),
        ),
        // ignore: avoid_unnecessary_containers
        body: ValueListenableBuilder(
          valueListenable: Hive.box(FAVORITES_BOX).listenable(),
          builder: (context, box, child) {
            // ignore: avoid_unnecessary_containers
            return Container(
                child: ListView(
              children: [
             
                ListTile(
                  // title: Center(
                  //             child: Text(
                  //               chapter!.name!,
                  //               textAlign: TextAlign.center,
                  //               style: const TextStyle(
                  //                   fontSize: 22.0,
                  //                   fontWeight: FontWeight.w600,
                  //                   color: titleTextColor),
                  //             ),
                  //           ),
                  trailing: IconButton(
                      onPressed: () {
                        Hive.box(FAVORITES_BOX).put(chapter!.id, chapter!.id);
                      },
                      icon: const Icon(
                       
                        Icons.favorite,
                        color: Colors.red,
                      )),
                )
              ],
            ));
          },
        ));
  }
}
