import 'package:equatable/equatable.dart';

sealed class FavouriteStatusResult {}

final class FavouriteStatusLoading extends FavouriteStatusResult {}

final class FavouriteStatusSuccess extends FavouriteStatusResult
    with EquatableMixin {
  final bool isFavourite;

  FavouriteStatusSuccess({required this.isFavourite});

  @override
  List<Object?> get props => [isFavourite];
}

final class FavouriteStatusFailed extends FavouriteStatusResult
    with EquatableMixin {
  final FavouriteStatusError error;

  FavouriteStatusFailed({required this.error});

  @override
  List<Object?> get props => [error];
}

sealed class FavouriteStatusError {}

final class FavouriteGenericError extends FavouriteStatusError {}

final class FavouriteApiError extends FavouriteStatusError with EquatableMixin {
  final int? errCode;

  FavouriteApiError({required this.errCode});

  @override
  List<Object?> get props => [errCode];
}
