import 'package:auto_route/auto_route.dart';
import 'package:mobiletemplate/routes/app_route_guard.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: TabControllerRoutes.page, path: '/', guards: [AppRouteGuard(canAccessAfterLogin: true, isPrivate: true)]),
        AutoRoute(page: Login.page, path: '/login', guards: [AppRouteGuard(canAccessAfterLogin: false, isPrivate: false)], initial: true),
        AutoRoute(page: Register.page, path: '/register', guards: [AppRouteGuard(canAccessAfterLogin: false, isPrivate: false)])
      ];
}
