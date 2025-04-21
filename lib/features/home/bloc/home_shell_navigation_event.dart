import 'package:equatable/equatable.dart';

sealed class HomeShellNavigationEvent {}

final class CanPopGlobalStateChangedEvent extends HomeShellNavigationEvent
    with EquatableMixin {
  final bool canPopGlobalState;

  CanPopGlobalStateChangedEvent({required this.canPopGlobalState});

  @override
  List<Object?> get props => [canPopGlobalState];
}
