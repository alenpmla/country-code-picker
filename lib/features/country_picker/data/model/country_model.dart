import '../../domain/entities/country.dart';

class CountryModel extends Country {
  CountryModel({
    required String countryCode,
    required String countryName,
  }) : super(countryCode: countryCode, countryName: countryName);

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      countryName: json['name'],
      countryCode: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': countryName,
      'code': countryCode,
    };
  }
}
