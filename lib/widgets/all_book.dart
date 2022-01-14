class AllBooks {
  final List<String>? allBooks;
  final String? image;
  AllBooks({
    this.allBooks,
    this.image,
  });
}

final allBooks = AllBooks(
  allBooks: [
    'Книги на русском',
    'كتاب هاى فارسى',
  ],
);

final image = AllBooks(
  image: 'https://islamonline.net/wp-content/uploads/2020/11/HADITH-PIX.jpg',
);
