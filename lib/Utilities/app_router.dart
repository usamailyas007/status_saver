import 'package:go_router/go_router.dart';
import 'package:status_saver_bloc/Views/Home/loading_splash_page.dart';

import '../Views/home.dart';

final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: "/",
    builder: (context, state) => const SplashPage(),
  ),
  GoRoute(
    path: "/home",
    builder: (context, state) => const Home(),
  ),
]);