import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/component/lazy_indexed_stack.dart';
import '/provider/user_provider.dart';
import '/screen/first_screen.dart';
import '/screen/login_screen.dart';
import '/screen/pushed_screen.dart';
import '/screen/second_screen.dart';
import '/screen/third_screen.dart';

void main() {
  runApp(
    const ProviderScope(child: ExampleApp()),
  );
}

class ExampleApp extends ConsumerStatefulWidget {
  const ExampleApp({Key? key}) : super(key: key);

  @override
  ConsumerState<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends ConsumerState<ExampleApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'go_router Bottom Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }

  late final router = GoRouter(
    redirect: (state) {
      // if the user is not logged in, they need to login
      final loggedIn = ref.read(userProvider).user != null;

      final isInAuthProcess = state.subloc == '/login';
      if (!loggedIn) return isInAuthProcess ? null : '/login';

      // if the user is logged in but still on the login page, send them to
      // the home page
      if (isInAuthProcess) return '/';

      // no need to redirect at all
      return null;
    },
    refreshListenable: ref.read(userProvider.notifier),
    routes: [
      GoRoute(
        path: '/',
        redirect: (state) => '/first',
      ),
      GoRoute(
        path: '/first',
        pageBuilder: (context, state) => _build(0),
      ),
      GoRoute(
        path: '/second',
        pageBuilder: (context, state) => _build(1),
      ),
      GoRoute(
        path: '/third',
        pageBuilder: (context, state) => _build(2),
        routes: [
          GoRoute(
            path: 'pushed',
            builder: (context, state) => const PushedScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/pushed',
        builder: (context, state) => const PushedScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
    ],
    debugLogDiagnostics: true,
  );

  Page _build(int currentIndex) {
    return NoTransitionPage<void>(
      child: Scaffold(
        key: const ValueKey('main_scaffold'),
        body: LazyIndexedStack(
          index: currentIndex,
          children: const [
            FirstScreen(),
            SecondScreen(),
            ThirdScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            switch (value) {
              case 0:
                return router.go('/first');
              case 1:
                return router.go('/second');
              case 2:
                return router.go('/third');
            }
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF1554F6),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white38,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.looks_one),
              label: 'First',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.looks_two),
              label: 'Second',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.looks_3),
              label: 'Third',
            ),
          ],
        ),
      ),
    );
  }
}
