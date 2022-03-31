import 'dart:convert';

import 'package:country_picker/features/country_picker/data/model/country_model.dart';
import 'package:country_picker/features/country_picker/domain/entities/country.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tCountryModel = CountryModel(countryCode: 'IN', countryName: 'India');

  test(
    'should be a subclass of country entity',
    () async {
      // assert
      expect(tCountryModel, isA<Country>());
    },
  );

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tCountryModel.toJson();
        // assert
        final expectedMap = {"code": 'IN', "name": 'India'};
        expect(result, expectedMap);
      },
    );
  });

  group('fromJson', () {
    test(
      'should return a valid model when the JSON',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('country.json'));
        // act
        final result = CountryModel.fromJson(jsonMap);
        // assert
        expect(result.countryName, tCountryModel.countryName);
        expect(result.countryCode, tCountryModel.countryCode);
      },
    );
  });
}
