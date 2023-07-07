import 'dart:convert';
import 'package:bookstore/Constants/utils.dart';
import 'package:flutter/material.dart';
import '../models/books.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class BookDetailsScreen extends StatelessWidget {
  static const String routeName = 'detail';
  final Book book;
  final User user;

  const BookDetailsScreen({super.key, required this.book,required this.user});

  @override
  Widget build(BuildContext context) {
    Future<bool> addToWishlist(String userId, String bookId, String title,
        String author, String imageUrl, String price) async {
      final url = Uri.parse('http://192.168.1.101:3000/api/wishlist');
      print(userId);
      print(bookId);
      print(title);
      print(author);
      print(imageUrl);
      final response = await http.post(url,
          body: jsonEncode({
            'price' :price,
            'userId': userId,
            'bookId': bookId,
            'name': title,
            'author': author,
            'image': imageUrl,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      print(response.body);
      if (response.statusCode == 201) {
        showsnackBar(context, 'Added to wishlist');
        print('Added to wishlist');
        return true; // Book added to wishlist successfully
      } else {
        showsnackBar(context, 'Failed to add to wishlist');
        print(response.body);
        print("Failed to add to wishlist");
        return false; // Failed to add book to wishlist
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 6 / 9,
                child: Image.network(
                  book.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                book.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                book.author,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                '₹${book.price}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 8),
              const SizedBox(height: 16),
              Container(
                width: MediaQuery.of(context).size.width*0.9,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle buy button pressed
                  },
                  child: const Text('Buy'),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.9,
                child: ElevatedButton(
                  onPressed: () {
                    addToWishlist(user.id!, book.id, book.title, book.author,
                        book.imageUrl,book.price);
                    // Handle add to wishlist button pressed
                  },
                  child: const Text('Add to Wishlist'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
