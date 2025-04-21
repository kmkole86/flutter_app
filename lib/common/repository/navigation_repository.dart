import 'dart:async';

import 'package:flutter_app/features/home/bloc/model.dart';
import 'package:rxdart/rxdart.dart';

abstract class NavigationRepository {
  Stream<bool> homeBackButtonVisibilityStatusObservable();

  void updateMovieShellCanPopStatus({required bool canPop});

  void updateFavouritesShellCanPopStatus({required bool canPop});

  void homeBranchChanged({required HomeShellBranch current});
}

final class NavigationRepositoryImpl extends NavigationRepository {
  //movies can pop status
  final BehaviorSubject<bool> _canPopMovieShellBranchBehaviourSubject =
      BehaviorSubject.seeded(false);

  //favourites can pop status
  final BehaviorSubject<bool> _canPopFavouritesShellBranchBehaviourSubject =
      BehaviorSubject.seeded(false);

  //selected shell branch
  final BehaviorSubject<HomeShellBranch>
  _currentShellBranchSelectedBehaviourSubject = BehaviorSubject.seeded(
    HomeShellBranch.movies,
  );

  //selected shell branch
  final BehaviorSubject<bool> _homeBackButtonVisibilityStatus =
      BehaviorSubject.seeded(false);

  NavigationRepositoryImpl() {
    _homeBackButtonVisibilityStatus.sink.addStream(
      CombineLatestStream.combine3<bool, bool, HomeShellBranch, bool>(
        _canPopMovieShellBranchBehaviourSubject.stream.distinct(),
        _canPopFavouritesShellBranchBehaviourSubject.stream.distinct(),
        _currentShellBranchSelectedBehaviourSubject.stream.distinct(),
        (canPopMoviesShell, canPopFavouritesShell, selectedBranch) =>
            switch (selectedBranch) {
              HomeShellBranch.movies => canPopMoviesShell,
              HomeShellBranch.favourite => canPopFavouritesShell,
            },
      ),
    );
  }

  @override
  void updateMovieShellCanPopStatus({required bool canPop}) {
    _canPopMovieShellBranchBehaviourSubject.add(canPop);
  }

  @override
  void updateFavouritesShellCanPopStatus({required bool canPop}) {
    _canPopFavouritesShellBranchBehaviourSubject.add(canPop);
  }

  @override
  void homeBranchChanged({required HomeShellBranch current}) {
    _currentShellBranchSelectedBehaviourSubject.add(current);
  }

  @override
  Stream<bool> homeBackButtonVisibilityStatusObservable() =>
      _homeBackButtonVisibilityStatus;
}
