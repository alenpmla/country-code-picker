import 'dart:convert';

import 'package:flutter/services.dart' show AssetBundle, rootBundle;

import '../model/country_model.dart';

abstract class CountryListDataSource {
  Future<List<CountryModel>> getAllCountryList();
}

class CountryListDataSourceImpl implements CountryListDataSource {
  @override
  Future<List<CountryModel>> getAllCountryList() async {
    String data = await rootBundle.loadString('assets/countries.json');
    final List allList = json.decode(data);
    final List<CountryModel> countryList =
        allList.map((item) => CountryModel.fromJson(item)).toList();
    return countryList;
  }
}
