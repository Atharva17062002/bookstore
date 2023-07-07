class WishlistItem {
  final String userId;
  final String bookId;
  final String title;
  final String author;
  final String imageUrl;
  final String price;

  WishlistItem({
    required this.userId,
    required this.bookId,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.price,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      price :json['price'],
      userId: json['userId'],
      bookId: json['bookId'],
      title: json['name'],
      author: json['author'],
      imageUrl: json['image'],
    );
  }
}

List<WishlistItem> wishlist= [

];
