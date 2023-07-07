import 'dart:convert';

import 'package:bookstore/Constants/error_handling.dart';
import 'package:bookstore/Providers/UserProvider.dart';
import 'package:bookstore/models/user.dart';
import 'package:bookstore/screens/bookStore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/utils.dart';

String uri = 'http://192.168.1.101:3000';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(email: email, password: password);
      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print("User signed up");
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showsnackBar(
              context,
              'Account created! Login with the same credentials!',
            );
          });
      print(res.body);
    } catch (e) {
      print(e);
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
              context,
              BookstoreApp.routeName,
              (route) => false,
            );
          });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
