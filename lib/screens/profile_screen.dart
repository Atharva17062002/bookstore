import 'package:bookstore/Constants/utils.dart';
import 'package:bookstore/screens/auth_screen.dart';
import 'package:bookstore/screens/myWishlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../Providers/UserProvider.dart';

class ProfileScreen extends StatefulWidget {
  final String name;
  final String email;

  ProfileScreen(this.name, this.email);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  Future<bool>logout()async{
    final url = Uri.parse('http://192.168.1.101:3000/api/logout'); // Replace with your backend API endpoint
    final response = await http.post(url);

    if (response.statusCode == 200) {
      showsnackBar(context, 'Logged Out');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthPage()),
      );
      return true;

      // Redirect to login screen or home screen
    } else {
      showsnackBar(context, 'Failed to Logout');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(

      body: Center(
        child: SizedBox(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text(
              //   'Name: ${widget.name}',
              //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              // ),
              const SizedBox(height: 16),
              Text(
                'Email: ${widget.email}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context)=> MyWishList(userId: user.id??'0')));
                  // Handle My Wishlist button pressed
                  // Add the desired functionality here
                },
                child: const Text('My Wishlist'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  logout();
                  // Handle My Wishlist button pressed
                  // Add the desired functionality here
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
