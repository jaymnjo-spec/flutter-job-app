import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthTestPage extends StatefulWidget {
  const AuthTestPage({Key? key}) : super(key: key);

  @override
  State<AuthTestPage> createState() => _AuthTestPageState();
}

class _AuthTestPageState extends State<AuthTestPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String status = '';

  Future<void> _signUp() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      setState(() => status = '✅ Signup successful');
    } catch (e) {
      setState(() => status = '❌ Signup failed: $e');
    }
  }

  Future<void> _signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      setState(() => status = '✅ Login successful');
    } catch (e) {
      setState(() => status = '❌ Login failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firebase Auth Test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _signUp, child: const Text('Sign Up')),
            ElevatedButton(onPressed: _signIn, child: const Text('Login')),
            const SizedBox(height: 20),
            Text(status),
          ],
        ),
      ),
    );
  }
}
