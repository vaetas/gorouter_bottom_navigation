import 'dart:developer' as dev;

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = ChangeNotifierProvider((ref) => UserNotifier());

class UserNotifier extends ChangeNotifier {
  UserNotifier();

  String? user;

  void login(String name) {
    dev.log('login: $name', name: 'UserNotifier');
    user = name;
    notifyListeners();
  }

  void logout() {
    dev.log('logout', name: 'UserNotifier');
    user = null;
    notifyListeners();
  }
}
