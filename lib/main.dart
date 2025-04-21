import 'package:data/data.dart';
import 'package:flutter/material.dart';

import 'di/di.dart';
import 'features/navigation/navigation_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDataDiAsync();
  initPresentationDi();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Marko Kostic',
      routerConfig:
          NavigationConfig(
            movieShellNavigatorObserver: di(instanceName: "movies"),
            favouritesShellNavigatorObserver: di(instanceName: "favourites"),
            branchChangeListener: di(),
          ).goRouter,
    );
  }
}
