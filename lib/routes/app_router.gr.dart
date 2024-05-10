// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:mobiletemplate/screens/login/login.dart' as _i1;
import 'package:mobiletemplate/screens/register/register.dart' as _i2;
import 'package:mobiletemplate/screens/tab_controller_screens/tab_controller.dart'
    as _i3;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    Login.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.Login(),
      );
    },
    Register.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.Register(),
      );
    },
    TabControllerRoutes.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.TabControllerRoutes(),
      );
    },
  };
}

/// generated route for
/// [_i1.Login]
class Login extends _i4.PageRouteInfo<void> {
  const Login({List<_i4.PageRouteInfo>? children})
      : super(
          Login.name,
          initialChildren: children,
        );

  static const String name = 'Login';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.Register]
class Register extends _i4.PageRouteInfo<void> {
  const Register({List<_i4.PageRouteInfo>? children})
      : super(
          Register.name,
          initialChildren: children,
        );

  static const String name = 'Register';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.TabControllerRoutes]
class TabControllerRoutes extends _i4.PageRouteInfo<void> {
  const TabControllerRoutes({List<_i4.PageRouteInfo>? children})
      : super(
          TabControllerRoutes.name,
          initialChildren: children,
        );

  static const String name = 'TabControllerRoutes';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
