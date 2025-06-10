import 'package:go_router/go_router.dart';
import 'package:portal_ckc/main.dart';

class RouteName {
  static final route = GoRouter(
    routerNeglect: true,
    routes: [
      GoRoute(path: '/', builder: (context, state) => MyHomePage(title: ""))
    ]
    );
}
