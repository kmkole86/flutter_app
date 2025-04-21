import 'package:flutter/material.dart';
import 'package:flutter_app/common/repository/navigation_repository.dart';

class ShellBranchNavigatorListener extends NavigatorObserver {
  ShellBranchNavigatorListener._internal();

  late void Function(bool) callback;

  factory ShellBranchNavigatorListener.movieBranchListener({
    required NavigationRepository navigationRepository,
  }) =>
      ShellBranchNavigatorListener._internal()
        ..callback = (bool canPop) {
          navigationRepository.updateMovieShellCanPopStatus(canPop: canPop);
        };

  factory ShellBranchNavigatorListener.favouritesBranchListener({
    required NavigationRepository navigationRepository,
  }) =>
      ShellBranchNavigatorListener._internal()
        ..callback = (bool canPop) {
          navigationRepository.updateFavouritesShellCanPopStatus(
            canPop: canPop,
          );
        };

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    callback(route.navigator?.canPop() ?? false);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    callback(route.navigator?.canPop() ?? false);
  }
}
