import 'package:auto_route/auto_route.dart';
import 'package:mobiletemplate/storage/global_state.dart';
import 'app_router.gr.dart';

class AppRouteGuard implements AutoRouteGuard {
  final bool canAccessAfterLogin;
  final bool isPrivate;

  AppRouteGuard({this.canAccessAfterLogin = false, this.isPrivate = false});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    GlobalState globalState = GlobalState();
    bool isLoggedIn = globalState.token != null;
    if (isLoggedIn && (isPrivate || canAccessAfterLogin) || !isLoggedIn && !isPrivate) {
      resolver.next();
    } else {
      if (isLoggedIn) {
        resolver.next(false);
        resolver.redirect(const TabControllerRoutes());
      } else {
        resolver.next(false);
        resolver.redirect(const Login());
      }
    }
  }
}
