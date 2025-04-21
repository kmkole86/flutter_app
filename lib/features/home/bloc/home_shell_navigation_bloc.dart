import 'dart:async';

import 'package:flutter_app/common/repository/navigation_repository.dart';
import 'package:flutter_app/features/home/bloc/home_shell_navigation_event.dart';
import 'package:flutter_app/features/home/bloc/home_shell_navigation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class HomeShellNavigationBloc
    extends Bloc<HomeShellNavigationEvent, HomeShellNavigationState> {
  final NavigationRepository _navigationRepository;
  late StreamSubscription<bool> _canPopGlobalStateSubscription;

  HomeShellNavigationBloc({required NavigationRepository navigationRepository})
    : _navigationRepository = navigationRepository,
      super(HomeShellNavigationState(canPopGlobalState: false)) {
    on<CanPopGlobalStateChangedEvent>(_handleCanPopGlobalStateChangedEvent);
    _canPopGlobalStateSubscription = _navigationRepository
        .homeBackButtonVisibilityStatusObservable()
        .listen((status) {
          add(CanPopGlobalStateChangedEvent(canPopGlobalState: status));
        });
  }

  void _handleCanPopGlobalStateChangedEvent(
    CanPopGlobalStateChangedEvent event,
    Emitter<HomeShellNavigationState> emit,
  ) {
    emit(state.copyWith(canPopGlobalState: event.canPopGlobalState));
  }

  @override
  Future<void> close() {
    _canPopGlobalStateSubscription.cancel();
    return super.close();
  }
}
