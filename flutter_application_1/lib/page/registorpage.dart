import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _fullPhoneNumber = "";

  void _register() async {
    var usersBox = Hive.box('users');
    String email = _emailController.text.trim();
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    
    if (usersBox.containsKey(email)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User already exists! Try logging in.")));
      return;
    }
    
    usersBox.put(email, {'username': username, 'password': password, 'phone': _fullPhoneNumber});
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registration successful! Please log in.")));
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            IntlPhoneField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: "Mobile Number",
                border: OutlineInputBorder(),
              ),
              initialCountryCode: 'IN',
              onChanged: (phone) {
                setState(() {
                  _fullPhoneNumber = phone.completeNumber;
                });
              },
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
