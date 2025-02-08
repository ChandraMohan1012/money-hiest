import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    var usersBox = Hive.box('users');
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (usersBox.containsKey(email)) {
      var user = usersBox.get(email);
      if (user['password'] == password) {
        usersBox.put('loggedInUser', email); // Store only the logged-in user
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Incorrect password!")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User not found! Please register.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: "Email",border: OutlineInputBorder())),
                    SizedBox(height: 20),
                TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: "Password",border: OutlineInputBorder()),
                    obscureText: true),
                SizedBox(height: 20),
                ElevatedButton(onPressed: _login, child: Text("Login")),
                TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/register'),
                    child: Text("Don't have an account? Register")),
              ],
            ),
          ))),
    );
  }
}
