class BooksRu {
  List<String>? urlImage;
  List<String>? name;
  List<String>? path;

  BooksRu({this.path, this.name, this.urlImage});
}

class BooksInPersian {
  final String? name;
  final String? path;
  final String? imgUrl;

  BooksInPersian({
    this.name,
    this.path,
    this.imgUrl,
  });
}

final booksRu = BooksRu(name: [
  '',
  '',
  '',
  'Рисолаи муфид',
  '',
  'Причины увеличения и уменьшения веры',
  '',
  'О вхождении джинов в тело человека',
  '',
  'С кем будет женщина в Раю?',
  'پاسخ به 18 شبهه برگزارکنندگان جشن میلاد پیامبر',
  'اصول و مبانی دعوت در سیرت پیامبر رحمت',
], path: [
  "https://firebasestorage.googleapis.com/v0/b/avrod-a2224.appspot.com/o/books%2F%D8%A7%D9%84%D9%82%D8%A7%D8%B9%D8%AF%D8%A9%20%D8%A7%D9%84%D9%86%D9%88%D8%B1%D8%A7%D9%86%D9%8A%D8%A9.pdf?alt=media&token=dd14a84e-ffd4-47e3-8142-e6d107afd0a4",
  "https://static.toislam.ws/files/biblioteka/biblioteka_pdf/05_fiqh/05_hadj/05_hajj_proroka_2022.pdf",
  "https://static.toislam.ws/files/biblioteka/biblioteka_pdf/05_fiqh/09_raznoe/08_umdatul_ahkam_1_tom.pdf",
  "https://firebasestorage.googleapis.com/v0/b/avrod-a2224.appspot.com/o/books%2F%D0%A0%D0%B8%D1%81%D0%BE%D0%BB%D0%B0%D0%B8%20%D0%BC%D1%83%D1%84%D0%B8%D0%B4.pdf?alt=media&token=e9f54c4a-970c-4353-9006-abfe19feab3c",
  "https://static.toislam.ws/files/biblioteka/biblioteka_pdf/08_adab/01_deyaniya_obereg_raba.pdf",
  "https://static.toislam.ws/files/biblioteka/biblioteka_pdf/01_aqida/04_prichini_uvelicheniya_i_umensheniya_imana.pdf",
  'https://static.toislam.ws/files/biblioteka/biblioteka_pdf/01_aqida/25_angeli.pdf',
  'https://static.toislam.ws/files/biblioteka/biblioteka_pdf/01_aqida/21_o_vhojdenii_djinov.pdf',
  'https://static.toislam.ws/files/biblioteka/biblioteka_pdf/01_aqida/27_poslanniki.pdf',
  'https://static.toislam.ws/files/biblioteka/biblioteka_pdf/01_aqida/14_s_kem_jenshina_v_rayu.pdf',
  'https://aqeedeh.com/book_files/pdf/fa/pasokh-ba-18shobhe-jashn-milad-peyambar-PDF.pdf',
  'https://aqeedeh.com/book_files/pdf/fa/osul-va-mabani-davat-dar-sirat-payambar-PDF.pdf',
], urlImage: [
  'https://iqranetwork.com/wp-content/uploads/2012/11/Tajweed.png',
  'https://firebasestorage.googleapis.com/v0/b/avrod-a2224.appspot.com/o/images%2F%D0%A5%D0%B0%D0%B4%D0%B6%20%D0%BF%D1%80%D0%BE%D1%80%D0%BE%D0%BA%D0%B0%20(%EF%B7%BA).png?alt=media&token=818650ee-4034-4cbe-8843-32423d809333',
  'https://toislam.ws/wp-content/uploads/2022/01/sharkh_umdat_al_ahkam_1-830x402.jpg',
  'https://kultsled.ru/wp-content/uploads/2019/01/%D0%A1%D0%B2%D0%B8%D1%82%D0%BE%D0%BA.jpg',
  'https://toislam.ws/wp-content/uploads/2013/05/deyaniya_raba-830x402.jpg',
  'https://i.pinimg.com/originals/e7/3a/52/e73a52cf5dfeb4bfeb9979ba1487947c.jpg',
  'https://toislam.ws/wp-content/uploads/2013/08/angeli_islam-830x402.jpg',
  'https://img5.goodfon.ru/wallpaper/nbig/8/46/priroda-les-derevia-tuman-11.jpg',
  'https://toislam.ws/wp-content/uploads/2013/10/proroki-830x402.jpg',
  'https://cdn.statically.io/img/i.pinimg.com/originals/f3/7d/c5/f37dc5e4ea716ad61962daf36a070c0d.jpg',
  'https://cdn.pixabay.com/photo/2020/07/12/09/41/mosque-5396683_960_720.jpg',
  'https://www.wallpapertip.com/wmimgs/49-499602_download-data-src-wallpaper-mosque-hd-1080p-sheikh.jpg',
]);

// class BooksPer {
//   List<String>? booksPer;
//   BooksPer({this.booksPer});
// }

// final List<BooksPer> booksPer = [
//   BooksPer(booksPer: [
//     'http://aqeedeh.com/book_files/pdf/fa/qoran-ra-chegune-bekhanim-PDF.pdf',
//     'http://aqeedeh.com/book_files/pdf/fa/lahazatee-ba-sokhanan-delnasheen-payambar-PDF.pdf',
//     'http://aqeedeh.com/book_files/pdf/fa/semay-sorat-va-seerat-zan-dar-islam-PDF.pdf',
//     'http://aqeedeh.com/book_files/pdf/fa/seerat-akhlaqi-payambar-PDF.pdf',
//   ])
  // BooksInRussian(
  //     imgUrl:
  //         'https://images.unsplash.com/photo-1542816417-0983c9c9ad53?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  //     path:
  //
  //     name: 'قرآن را چگونه بخوانیم؟'),
  // BooksInRussian(
  //     imgUrl:
  //         'https://images.unsplash.com/photo-1627337840960-d55af60bf8e3?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=687&q=80',
  //     path:
  //
  //     name: ' (ﷺ) لحظاتی باسخنان دلنشین پیامبر '),
  // BooksInRussian(
  //     imgUrl:
  //         'https://images.unsplash.com/photo-1464798429116-8e26f96b2e60?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1170&q=80',
  //     path:
  //
  //     name: 'سیمای صورت و سیرت زن در اسلام'),
  // BooksInRussian(
  //     imgUrl:
  //         'https://images.unsplash.com/photo-1594047543253-43f56592fe1e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80',
  //     path:
  //
  //     name: 'سیرت اخلاقی رسول گرامی (ﷺ) '),
// ];
