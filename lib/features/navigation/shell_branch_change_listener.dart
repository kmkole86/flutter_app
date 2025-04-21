import 'package:flutter_app/common/repository/navigation_repository.dart';
import 'package:flutter_app/features/home/bloc/model.dart';

abstract class ShellBranchChangeListener {
  void onShellBranchChanged({required HomeShellBranch branch});
}

class ShellBranchChangeListenerImpl extends ShellBranchChangeListener {
  final NavigationRepository _navigationRepository;

  ShellBranchChangeListenerImpl({
    required NavigationRepository navigationRepository,
  }) : _navigationRepository = navigationRepository;

  @override
  void onShellBranchChanged({required HomeShellBranch branch}) {
    _navigationRepository.homeBranchChanged(current: branch);
  }
}
