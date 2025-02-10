// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:teste_guia_de_moteis/src/presentation/go/home_page.dart';

abstract class INavigationHandler {
  late GlobalKey<NavigatorState> appGlobalKey;

  Route<dynamic> appRoutes(RouteSettings settings);

  Future<T?> push<T extends Object?>(String route, {Object? arguments});

  pop<T extends Object?>([T? result]);

  BuildContext? get context;
}

class NavigationHandler implements INavigationHandler {
  @override
  Route<dynamic> appRoutes(RouteSettings settings) {
    debugPrint('NavigationHandler: appRoute ${settings.name}');

    switch (settings.name) {
      case HomePage.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return HomePage();
          },
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return Center(child: Text('Route not found'));
          },
        );
    }
  }

  @override
  Future<T?> push<T extends Object?>(String route, {Object? arguments}) async {
    return Navigator.pushNamed(
      appGlobalKey.currentContext!,
      route,
      arguments: arguments,
    );
  }

  @override
  void pop<T extends Object?>([T? result]) {
    return Navigator.pop<T>(appGlobalKey.currentContext!, result);
  }

  @override
  GlobalKey<NavigatorState> appGlobalKey = GlobalKey();

  @override
  BuildContext? get context => appGlobalKey.currentContext;
}
