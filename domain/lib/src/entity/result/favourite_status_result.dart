import 'package:equatable/equatable.dart';

sealed class FavouriteStatusResult extends Equatable {}

final class FavouriteStatusLoading extends FavouriteStatusResult {
  @override
  List<Object?> get props => [];
}

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

sealed class FavouriteStatusError extends Equatable {}

final class FavouriteGenericError extends FavouriteStatusError {
  @override
  List<Object?> get props => [];
}

final class FavouriteApiError extends FavouriteStatusError {
  final int? errCode;

  FavouriteApiError({required this.errCode});

  @override
  List<Object?> get props => [errCode];
}
