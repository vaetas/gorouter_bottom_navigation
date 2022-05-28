import 'package:flutter/material.dart';

/// [RootScreen] is not meant to be visible at any time. Is serves as a entry
/// point for navigation and user will be redirected to different page.
class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
