class Book {
  final String id;
  final String title;
  final String author;
  final String imageUrl;
  final String price;

  const Book({
    required this.price,
    required this.id,
    required this.title,
    required this.author,
    required this.imageUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      imageUrl: json['image'],
      title: json['name'],
      author: json['author'],
      price: json['price'],
      id: json['_id'],
    );
  }
}

List<Book> books = [

];
