import 'package:equatable/equatable.dart';

final class SpokenLanguage extends Equatable {
  final String englishName;
  final String isoCode;
  final String name;

  const SpokenLanguage({
    required this.englishName,
    required this.isoCode,
    required this.name,
  });

  @override
  List<Object?> get props => [name, englishName, isoCode];
}
