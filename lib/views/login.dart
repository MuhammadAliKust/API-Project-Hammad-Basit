import 'package:api_project/views/register.dart';
import 'package:flutter/material.dart';

import '../services/auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Email'),
            controller: usernameController,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Password'),
            controller: passwordController,
            obscureText: true,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                if (usernameController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter both email and password'),
                    ),
                  );
                  return;
                }
                try {
                  await AuthServices()
                      .loginUser(
                        email: usernameController.text,
                        password: passwordController.text,
                      )
                      .then((value) async {
                        await AuthServices()
                            .getUser(value.token.toString())
                            .then((val) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Welcome ${val.user!.name}'),
                                ),
                              );
                            });
                      });
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Login failed: $e')));
                }
              },
              child: const Text('Login'),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterView()),
              );
            },
            child: const Text('Go to Register'),
          ),
        ],
      ),
    );
  }
}
