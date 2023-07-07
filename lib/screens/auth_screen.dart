import 'package:bookstore/screens/login_screen.dart';
import 'package:bookstore/services/authservice.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  static const String routeName = '/signup';
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passController.text,
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  const Icon(
                    Icons.book,
                    size: 70,
                  ),
                  const Text("Sign Up",style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 5),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: const TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Enter your email';
                          }
                          return null;
                        }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 10),
                    child: TextFormField(
                      obscureText: true,
                      controller: _passController,
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: const TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Enter your email';
                          }
                          return null;
                        }),
                  ),
                  Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width * 0.95,
                    decoration: BoxDecoration(
                      color: const Color(0xff2E3B62),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {
                        signUpUser();
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder:(context)=> const Login_screen()));
                      }, 
                      child: const Text('Already have an account ? Login',style: TextStyle(color: Colors.black),))
                ],
              ),
            ),
          ),
        ));
  }
}
