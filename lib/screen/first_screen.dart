import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/provider/user_provider.dart';

class FirstScreen extends ConsumerStatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends ConsumerState<FirstScreen> {
  @override
  void initState() {
    super.initState();
    dev.log('initState()', name: 'FirstScreen');
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Current user: $user'),
                  TextButton(
                    onPressed: () {
                      ref.read(userProvider).logout();
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.push('/pushed');
                  },
                  child: const Text('Push [PushedScreen]'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.go('/third/pushed');
                  },
                  child: const Text('Go to /third/pushed'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
