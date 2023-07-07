import 'dart:convert';

import 'package:bookstore/screens/bookStore.dart';
import 'package:bookstore/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../Providers/UserProvider.dart';
import '../models/books.dart';
import 'book_detail.dart';

class SearchPage extends StatefulWidget {
  static const String routeName = 'search';
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchBooks();
  }

  List<Book> _books = [];

  void _searchBooks() async {
    String query = _searchController.text;

    var response = await http.get(Uri.parse('http://192.168.1.101:3000/api/books/search?query=$query'));

    if (response.statusCode == 200) {
      final List<dynamic> booksData = jsonDecode(response.body);
      setState(() {
        _books = booksData.map((bookData) => Book(
          id: bookData['_id']??'n',
          title: bookData['name']??'v',
          author: bookData['author']??'vv',
          imageUrl: bookData['image']??'v',
          price: bookData['price']??'200',
        ),).toList();
      },);
    }
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> BookstoreApp()));}, icon: Icon(AntDesign.left),),
        title: const Text('Search Books'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _searchController,
            onChanged: (query) {
              setState(() {
                _searchBooks();
              });
            },
            decoration: const InputDecoration(
              labelText: 'Search Books',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _books.length,
              itemBuilder: (context, index) {
                final book = _books[index];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.author),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailsScreen(book: book, user: user,),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
