import 'package:equatable/equatable.dart';

final class HomeShellNavigationState extends Equatable {
  final bool canPopGlobalState;

  const HomeShellNavigationState({required this.canPopGlobalState});

  HomeShellNavigationState copyWith({bool? canPopGlobalState}) {
    return HomeShellNavigationState(
        canPopGlobalState: canPopGlobalState ?? this.canPopGlobalState);
  }

  @override
  List<Object?> get props => [canPopGlobalState];
}
