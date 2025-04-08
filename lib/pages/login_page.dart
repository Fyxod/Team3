import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pinController = TextEditingController();

  bool isLogin = true;
  bool isLoading = false;

  void _toggleFormType() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final pin = _pinController.text.trim();

    String responseMessage;

    try {
      if (isLogin) {
        responseMessage = await AuthService.loginUser(username, password);
        if (responseMessage == 'Login successful') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(username: username),
            ),
          );
          return;
        }
      } else {
        responseMessage = await AuthService.registerUser(username, password, pin);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(responseMessage),
          backgroundColor: responseMessage.contains('successful')
              ? Colors.green
              : Colors.red,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          width: 430,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Icon(Icons.lock_outline,
                      size: 80, color: Colors.greenAccent),
                  const SizedBox(height: 20),
                  Text(
                    isLogin ? 'Login' : 'Register',
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _usernameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Colors.white70),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Enter username' : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white70),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value!.length < 6
                        ? 'Password must be at least 6 characters'
                        : null,
                  ),
                  if (!isLogin) ...[
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _pinController,
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: '4-digit PIN',
                        labelStyle: TextStyle(color: Colors.white70),
                        border: OutlineInputBorder(),
                        counterText: '',
                      ),
                      validator: (value) =>
                          value!.length != 4 ? 'PIN must be 4 digits' : null,
                    ),
                  ],
                  const SizedBox(height: 30),
                  isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.greenAccent)
                      : ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: Colors.greenAccent,
                          ),
                          child: Text(isLogin ? 'Login' : 'Register',
                              style: const TextStyle(color: Colors.black)),
                        ),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: _toggleFormType,
                    child: Text(
                      isLogin
                          ? "Don't have an account? Register"
                          : "Already have an account? Login",
                      style: const TextStyle(color: Colors.white70),
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
