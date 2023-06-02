import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas4/main.dart';
import 'package:tugas4/pages/database_helper.dart';
import 'register_page.dart';
import 'bottom_navigation.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = new TextEditingController();
  final _passwordController =  new TextEditingController();


  saveData() async{
    final localStorage = await SharedPreferences.getInstance();
    localStorage.setString("id", _usernameController.text.toString());
    localStorage.setString("pass", _passwordController.text.toString());
    String? iduser = localStorage.getString("id");

    if(_usernameController.text == "" && _passwordController.text == ""){
      print("tidak bisa login");
    }else{
      Navigator.pushReplacement(
        // Replace current page
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavigation(nama: iduser, key: null,),
        ),
      );
    }
  }
  String _errorMessage = '';

  Future<void> _login() async {
    // Add a method to login
    final username = _usernameController.text;
    final password = _passwordController.text;

    final user = await DatabaseHelper.instance
        .getUser(username); // Get user from database

    if (user != null && user.password == password) {
      // Check if user exists and password is correct
      saveData();
    } else {
      setState(() {
        _errorMessage = 'Invalid username or password';
      });
      _showSnackbar();
    }
  }

  void _showSnackbar() {
    // Add a SnackBar to show error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _errorMessage,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red, // Set background color to red
        duration: Duration(seconds: 1), // Set duration to 1 second
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _errorMessage = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 16.0),
                  Image.asset(
                    'assets/giphy.png',
                    width: 30,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 16.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.black,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _passwordController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.black,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _login();
                            }
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 12.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 1.0),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Register Account',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontStyle: FontStyle.italic,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
