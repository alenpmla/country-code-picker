
import 'package:country_picker/features/country_picker/domain/repositories/country_list_repository.dart';

import '../../domain/entities/country.dart';
import '../datasources/country_list_data_source.dart';

class CountryListRepositoryImpl implements CountryListRepository {
  final CountryListDataSource countryListDataSource;

  CountryListRepositoryImpl({
    required this.countryListDataSource,
  });

  @override
  Future<List<Country>> getAllCountryLists() {
    return countryListDataSource.getAllCountryList();
  }

  @override
  Future<List<Country>> searchCountryList(String searchQuery) async {
    List<Country> searchList = [];
    List<Country> countryList = await countryListDataSource.getAllCountryList();
    for (Country country in countryList) {
      if (country.countryName
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          country.countryCode
              .toLowerCase()
              .contains(searchQuery.toLowerCase())) {
        searchList.add(country);
      }
    }
    return searchList;
  }
}
