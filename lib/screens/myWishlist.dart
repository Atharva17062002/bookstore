import 'dart:convert';

import 'package:bookstore/models/books.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../Constants/utils.dart';
import '../Providers/UserProvider.dart';
import 'book_detail.dart';

class MyWishList extends StatefulWidget {
  final String userId;
  static const String routeName = 'wish';
  MyWishList({super.key, required this.userId});
  @override
  _MyWishListState createState() => _MyWishListState();
}

class _MyWishListState extends State<MyWishList> {
  List<Book> wishlistItems = [];

  @override
  void initState() {
    super.initState();
    fetchWishlistItems();
  }

  Future<void> fetchWishlistItems() async {
    final url = Uri.parse('http://192.168.1.101:3000/api/wishlist/${widget.userId}'); // Replace with your backend API endpoint
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> booksData = jsonDecode(response.body);
      print(response.body);
      setState(() {
        wishlistItems = booksData.map((bookData) => Book(
          id: bookData['_id']??'n',
          title: bookData['name']??'v',
          author: bookData['author']??'vv',
          imageUrl: bookData['image']??'v',
          price: bookData['price']??'200',
        ),).toList();
      },);
      print(wishlistItems);
    } else {
      print('Failed to fetch books. Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
      ),

      body:GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.7,
        ),
        itemCount: wishlistItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailsScreen(book: wishlistItems[index], user: user,),
                ),
              );
            },
            child: BookCard(
              book: wishlistItems[index],
            ),
          );
        },
      ),
    );
  }
}
