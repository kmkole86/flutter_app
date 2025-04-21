import 'package:flutter/material.dart';
import 'package:flutter_app/di/di.dart';
import 'package:flutter_app/features/favourites/favourites_page.dart';
import 'package:flutter_app/features/home/bloc/model.dart';
import 'package:flutter_app/features/movies/movies_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'bloc/home_shell_navigation_bloc.dart';
import 'bloc/home_shell_navigation_state.dart';

class HomeShellPage extends StatelessWidget {
  const HomeShellPage({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeShellNavigationBloc(navigationRepository: di()),
      child: _HomeShellPage(navigationShell: navigationShell),
    );
  }
}

final class _HomeShellPage extends StatefulWidget {
  const _HomeShellPage({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  State<_HomeShellPage> createState() => _HomeShellPageState();
}

class _HomeShellPageState extends State<_HomeShellPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Marko Kostic"),
        leading: _HomeBackButtonWidget(),
      ),
      resizeToAvoidBottomInset: true,
      drawerEnableOpenDragGesture: false,
      body: SafeArea(bottom: false, child: widget.navigationShell),
      bottomNavigationBar: _HomeBottomNavBar(
        onTap: (int index) {
          widget.navigationShell.goBranch(
            index,
            initialLocation: index == widget.navigationShell.currentIndex,
          );
        },
        selectedIndex: widget.navigationShell.currentIndex,
      ),
    );
  }
}

class _HomeBackButtonWidget extends StatelessWidget {
  const _HomeBackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeShellNavigationBloc, HomeShellNavigationState>(
      builder:
          (BuildContext context, HomeShellNavigationState state) =>
              state.canPopGlobalState
                  ? BackButton(onPressed: context.pop)
                  : const SizedBox(),
    );
  }
}

class _HomeBottomNavBar extends StatelessWidget {
  final void Function(int) onTap;
  final int selectedIndex;

  const _HomeBottomNavBar({
    super.key,
    required this.onTap,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items:
          HomeShellBranch.values
              .map((e) => e.toBottomNavigationBarItem())
              .toList(),
      currentIndex: selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: onTap,
    );
  }
}

extension HomeBottomNavBarItemsExtensions on HomeShellBranch {
  BottomNavigationBarItem toBottomNavigationBarItem() => switch (this) {
    HomeShellBranch.movies => BottomNavigationBarItem(
      icon: Icon(Icons.play_arrow),
      label: 'Movies',
    ),
    HomeShellBranch.favourite => BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favourites',
    ),
  };

  String getPath() => switch (this) {
    HomeShellBranch.movies => MoviesPage.path,
    HomeShellBranch.favourite => FavouritesPage.path,
  };
}
