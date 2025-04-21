import 'package:equatable/equatable.dart';

final class SpokenLanguageData extends Equatable {
  final String englishName;
  final String isoCode;
  final String name;

  const SpokenLanguageData({
    required this.englishName,
    required this.isoCode,
    required this.name,
  });

  @override
  List<Object?> get props => [isoCode, name, englishName];
}
