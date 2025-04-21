import 'package:flutter_app/common/repository/navigation_repository.dart';
import 'package:flutter_app/features/navigation/shell_branch_change_listener.dart';
import 'package:flutter_app/features/navigation/shell_branch_navigator_listener.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

void initPresentationDi() {
  di.registerSingleton<NavigationRepository>(NavigationRepositoryImpl());
  //navigator throws when same instance is reused
  di.registerSingleton(
    ShellBranchNavigatorListener.movieBranchListener(
      navigationRepository: di(),
    ),
    instanceName: "movies",
  );
  //navigator throws when same instance is reused
  di.registerSingleton(
    ShellBranchNavigatorListener.favouritesBranchListener(
      navigationRepository: di(),
    ),
    instanceName: "favourites",
  );
  di.registerSingleton<ShellBranchChangeListener>(
    ShellBranchChangeListenerImpl(navigationRepository: di()),
  );
}
