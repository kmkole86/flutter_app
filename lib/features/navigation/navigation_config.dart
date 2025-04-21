import 'package:flutter/widgets.dart' show GlobalKey, NavigatorState;
import 'package:flutter_app/features/details/movie_details_page.dart';
import 'package:flutter_app/features/favourites/favourites_page.dart';
import 'package:flutter_app/features/home/bloc/model.dart';
import 'package:flutter_app/features/home/home_shell_page.dart';
import 'package:flutter_app/features/movies/movies_page.dart';
import 'package:flutter_app/features/navigation/shell_branch_change_listener.dart';
import 'package:flutter_app/features/navigation/shell_branch_navigator_listener.dart';
import 'package:go_router/go_router.dart';

final mainNavKey = GlobalKey<NavigatorState>(debugLabel: 'root');

class NavigationConfig {
  late ShellBranchNavigatorListener _moviesShellNavigatorObserver;
  late ShellBranchNavigatorListener _favouritesShellNavigatorObserver;
  late ShellBranchChangeListener _branchChangeListener;

  static final NavigationConfig _navigationConfig =
      NavigationConfig._internal();

  factory NavigationConfig({
    required ShellBranchNavigatorListener movieShellNavigatorObserver,
    required ShellBranchNavigatorListener favouritesShellNavigatorObserver,
    required ShellBranchChangeListener branchChangeListener,
  }) {
    //throws when same instance is reused
    _navigationConfig._moviesShellNavigatorObserver =
        movieShellNavigatorObserver;
    _navigationConfig._favouritesShellNavigatorObserver =
        favouritesShellNavigatorObserver;
    _navigationConfig._branchChangeListener = branchChangeListener;
    return _navigationConfig;
  }

  NavigationConfig._internal();

  GoRouter? _goRouter;

  GoRouter get goRouter =>
      _goRouter ??= GoRouter(
        // observers: [NavigatorObserver()],
        debugLogDiagnostics: true,
        initialLocation: MoviesPage.path,
        routes: [
          StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              _branchChangeListener.onShellBranchChanged(
                branch: HomeShellBranch.values[navigationShell.currentIndex],
              );
              return HomeShellPage(navigationShell: navigationShell);
            },
            branches: [
              StatefulShellBranch(
                observers: [_moviesShellNavigatorObserver],
                routes: [
                  GoRoute(
                    path: MoviesPage.path,
                    builder: (context, state) => MoviesPage(),
                    routes: [
                      GoRoute(
                        path: MovieDetailsPage.path,
                        builder: (context, state) {
                          return MovieDetailsPage(
                            id: int.parse(
                              state.pathParameters[MovieDetailsPage
                                      .pathParamKey]
                                  as String,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              StatefulShellBranch(
                observers: [_favouritesShellNavigatorObserver],
                routes: [
                  GoRoute(
                    path: FavouritesPage.path,
                    builder: (context, state) => FavouritesPage(),
                    routes: [
                      GoRoute(
                        path: MovieDetailsPage.path,
                        builder: (context, state) {
                          return MovieDetailsPage(
                            id: int.parse(
                              state.pathParameters[MovieDetailsPage
                                      .pathParamKey]
                                  as String,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      );
}
