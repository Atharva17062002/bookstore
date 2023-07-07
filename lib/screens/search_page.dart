import 'dart:convert';

import 'package:flutter/material.dart';
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
    searchBooks(_searchController.text);
  }

  List<Book> searchResults = [];

  Future<void> searchBooks(String query) async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.101:3000/api/books/search?query=$query'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          searchResults = List<Book>.from(data.map((book) => Book.fromJson(book)));
        });
      } else {
        print('Error searching books: ${response.statusCode}');
      }
    } catch (e) {
      print('Error searching books: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Books'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _searchController,
            onChanged: (query) {
              setState(() {
                searchBooks(query);
              });
            },
            decoration: const InputDecoration(
              labelText: 'Search Books',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final book = searchResults[index];
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
