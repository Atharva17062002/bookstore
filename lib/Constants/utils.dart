import 'package:flutter/material.dart';

import '../models/books.dart';

void showsnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
  ));
} // SnackBar

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: Image.network(
              book.imageUrl,
              width: double.infinity,
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  book.author,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
            const SizedBox(height: 4),
            Text(
              '₹${book.price}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
