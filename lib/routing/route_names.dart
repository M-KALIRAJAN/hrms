import 'package:go_router/go_router.dart';
import 'package:hrms/routing/app_router.dart';
import 'package:hrms/view/auth/login_view.dart';
import 'package:hrms/view/home_view.dart';
import 'package:hrms/routing/route_names.dart';

GoRouter approuter(bool isLoggedIn) {
  return GoRouter(
    initialLocation: isLoggedIn ? RouteName.home : RouteName.login,
    routes: [
      GoRoute(
        path: RouteName.login,
        builder: (context, state) => LoginView(),
      ),
      GoRoute(
        path: RouteName.home,
        builder: (context, state) => HomeView(),
      ),
    ],
  );
}
