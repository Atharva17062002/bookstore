import 'package:bookstore/screens/profile_screen.dart';
import 'package:bookstore/screens/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import '../Providers/UserProvider.dart';
import 'home_screen.dart';
import 'package:bookstore/models/books.dart';

class BookstoreApp extends StatefulWidget {
  static const String routeName = 'store';

  const BookstoreApp({super.key});
  @override
  _BookstoreAppState createState() => _BookstoreAppState();
}

class _BookstoreAppState extends State<BookstoreApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){
              Navigator.pushNamedAndRemoveUntil(
                context,
                SearchPage.routeName,
                    (route) => false,
              );
            }, icon: Icon(AntDesign.search1) )
          ],
          title: const Text('Bookstore'),
        ),
        body: Center(
          child: _buildPage(_selectedIndex), // Function to build the corresponding page based on the selected index
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.library_books),
            //   label: 'Library',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      );
  }

  Widget _buildPage(int index) {
    final user = Provider.of<UserProvider>(context).user;
    switch (index) {
      case 0:
        return const HomePage();
      // case 1:
      //   return LibraryScreen();
      case 1:
        return ProfileScreen("John",user.email);
      default:
        return const HomePage();
    }
  }
}
