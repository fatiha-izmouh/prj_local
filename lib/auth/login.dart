import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();

  bool _isPasswordVisible = false;

  /// Focus Node
  final _fnEmail = FocusNode();
  final _fnPassword = FocusNode();

  /// Global key
  final _formValidator = <String, bool>{};

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: AutofillGroup(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(context).hintColor,
                      radius: 50.0,
                      child: const CircleAvatar(
                        backgroundImage: AssetImage('images/profile.png'),
                        radius: 46.0,
                      ),
                    ),
                    const SizedBox(height: 50),
                    _loginForm(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }

  Widget _loginForm(BuildContext context) {
    return Column(
      children: [
        TextField(
          autofillHints: const [AutofillHints.email],
          focusNode: _fnEmail,
          controller: _conEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.alternate_email),
            hintText: "eve.holt@reqres.in",
            labelText: "Email",
            labelStyle: TextStyle(color: Theme.of(context).primaryColor),
            errorText: _formValidator["email"] == false
                ? "Invalid email"
                : null,
          ),
          onChanged: (value) {
            setState(() {
              _formValidator["email"] = value.contains('@');
            });
          },
        ),
        const SizedBox(height: 20),
        TextField(
          autofillHints: const [AutofillHints.password],
          focusNode: _fnPassword,
          controller: _conPassword,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_outline),
            hintText: '••••••••••••',
            labelText: "Password",
            labelStyle: TextStyle(color: Theme.of(context).primaryColor),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              icon: Icon(
                _isPasswordVisible
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
            ),
            errorText: _formValidator["password"] == false
                ? "Password must be at least 6 characters"
                : null,
          ),
          onChanged: (value) {
            setState(() {
              _formValidator["password"] = value.length > 5;
            });
          },
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _formValidator.values.every((isValid) => isValid == true)
              ? () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
              : null,
          child: const Text("Login"),
        ),
      ],
    );
  }
}
