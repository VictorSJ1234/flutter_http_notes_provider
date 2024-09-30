import 'package:go_router/go_router.dart';
import 'package:inventi_flutter_exam/home/homepage_ui.dart';
import 'package:inventi_flutter_exam/login/login_page_ui.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPageUi(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomepageUi(),
    ),
  ],
);