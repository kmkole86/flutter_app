import 'package:equatable/equatable.dart';

final class ProductionCountry extends Equatable {
  final String isoCode;
  final String name;

  const ProductionCountry({required this.isoCode, required this.name});

  @override
  List<Object?> get props => [isoCode, name];
}
