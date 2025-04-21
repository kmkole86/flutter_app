import 'package:equatable/equatable.dart';

final class MovieGenreData extends Equatable {
  final int id;
  final String name;

  const MovieGenreData({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
