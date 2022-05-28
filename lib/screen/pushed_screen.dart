import 'package:flutter/material.dart';

class PushedScreen extends StatelessWidget {
  const PushedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pushed Screen'),
      ),
    );
  }
}
