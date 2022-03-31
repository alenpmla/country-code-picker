import 'package:flutter/cupertino.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/country.dart';
import '../../domain/usecases/get_all_countries_list_usecase.dart';
import '../../domain/usecases/searched_country_list_usecase.dart';

class CountryCodePickerChangeNotifier extends ChangeNotifier {
  final GetAllCountriesListUseCase allCountryListUseCase;
  final SearchCountryUseCase searchCountryUseCase;

  CountryCodePickerChangeNotifier({
    required this.allCountryListUseCase,
    required this.searchCountryUseCase,
  });

  //Getters
  List<Country> get pickedCountryList => _pickedCountryList;

  List<Country> get allCountriesList => _allCountryList;

  Country get getSelectedCountry => _selectedCountry;

  final List<Country> _pickedCountryList = [];
  List<Country> _allCountryList = [];
  final Map<String, Country> _pickedCountriesMap = {};

  late Country _selectedCountry;

  void fetchAllCountryList() async {
    List<Country> countryList = await allCountryListUseCase(NoParams());
    _allCountryList = countryList;
    if (countryList.isNotEmpty) {
      _selectedCountry = _allCountryList.first;
    }
    notifyListeners();
  }

  void searchCountry(String searchQuery) async {
    List<Country> countryList =
        await searchCountryUseCase(Params(query: searchQuery));
    _allCountryList = countryList;
    if (countryList.isNotEmpty) {
      _selectedCountry = _allCountryList.first;
    }
    notifyListeners();
  }

  void selectCurrentCountry(Country country) {
    _selectedCountry = country;
  }

  bool pickCountry(Country country) {
    bool pickCountryResult = false;
    if (_pickedCountriesMap[country.countryCode] == null) {
      _pickedCountryList.add(country);
      _pickedCountriesMap.putIfAbsent(country.countryCode, () => country);
      notifyListeners();
      pickCountryResult = true;
    } else {
      pickCountryResult = false;
    }
    return pickCountryResult;
  }

  void removeCountry(Country country) {
    _pickedCountryList.remove(country);
    _pickedCountriesMap.remove(country.countryCode);
    notifyListeners();
  }
}
