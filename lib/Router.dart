import 'package:bookstore/screens/auth_screen.dart';
import 'package:bookstore/screens/bookStore.dart';
import 'package:bookstore/screens/home_screen.dart';
import 'package:bookstore/screens/login_screen.dart';
import 'package:bookstore/screens/search_page.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthPage(),
      );
    case BookstoreApp.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => BookstoreApp(),
      );
    case Login_screen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Login_screen(),
      );
    case HomePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomePage(),
      );
    case SearchPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SearchPage(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Text('This Page does not exist'),
        ),
      );
  }
}
