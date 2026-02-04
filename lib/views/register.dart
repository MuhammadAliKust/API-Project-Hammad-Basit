import 'package:flutter/material.dart';

import '../services/auth.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Name'),
            controller: nameController,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Email'),
            controller: emailController,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Password'),
            controller: passwordController,
            obscureText: true,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                if (nameController.text.isEmpty ||
                    emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter name, email and password'),
                    ),
                  );
                  return;
                }
                try {
                  await AuthServices()
                      .registerUser(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      )
                      .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Register successful')),
                        );
                      });
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Login failed: $e')));
                }
              },
              child: const Text('Register'),
            ),
          ),
        ],
      ),
    );
  }
}
