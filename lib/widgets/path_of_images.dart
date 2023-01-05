const String path = 'assets/images';

class PathOfImages {
  final String pathImages;
  final String name;
  PathOfImages({
    required this.pathImages,
    required this.name,
  });
}

List<PathOfImages> images = [
  PathOfImages(pathImages: '$path/morning.png', name: 'title1'),
  PathOfImages(pathImages: '$path/duasalah.png', name: 'title2'),
  PathOfImages(pathImages: '$path/silhouette.png', name: 'title3'),
  PathOfImages(pathImages: '$path/sleep.png', name: 'title4'),
  PathOfImages(pathImages: '$path/food.png', name: 'title5'),
  PathOfImages(pathImages: '$path/sadness.png', name: 'title6'),
  PathOfImages(pathImages: '$path/hajj.png', name: 'title7'),
  PathOfImages(pathImages: '$path/shakinghands.png', name: 'title8'),
  PathOfImages(pathImages: '$path/storm.png', name: 'title9'),
  PathOfImages(pathImages: '$path/sick.png', name: 'title10'),
  PathOfImages(pathImages: '$path/ruqya.png', name: 'title11'),
  PathOfImages(pathImages: '$path/family.png', name: 'title12'),
  PathOfImages(pathImages: '$path/adha.png', name: 'title13'),
  PathOfImages(pathImages: '$path/duafromQuran.png', name: 'title14'),
];
