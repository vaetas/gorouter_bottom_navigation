import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/provider/user_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final nameController = TextEditingController(text: 'John');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                label: Text('Your name'),
                filled: true,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(userProvider).login(nameController.text.trim());
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
