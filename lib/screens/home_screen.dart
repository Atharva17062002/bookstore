import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../Constants/utils.dart';
import '../Providers/UserProvider.dart';
import '../models/books.dart';
import 'book_detail.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    final response = await http.get(Uri.parse('http://192.168.1.101:3000/api/books'));

    if (response.statusCode == 200) {
      final List<dynamic> booksData = jsonDecode(response.body);

      setState(() {
        books = booksData.map((bookData) => Book(
          id: bookData['_id']??'',
          title: bookData['name']??'',
          author: bookData['author']??'',
          imageUrl: bookData['image']??'',
          price: bookData["price"],
        ),).toList();
      },);
    } else {
      print('Failed to fetch books. Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(

      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.7,
        ),
        itemCount: books.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailsScreen(book: books[index], user: user,),
                ),
              );
            },
            child: BookCard(
              book: books[index],
            ),
          );
        },
      ),
    );
  }
}
