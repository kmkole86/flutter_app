import 'package:equatable/equatable.dart';

final class ProductionCountryData extends Equatable {
  final String isoCode;
  final String name;

  const ProductionCountryData({required this.isoCode, required this.name});

  @override
  List<Object?> get props => [isoCode, name];
}
