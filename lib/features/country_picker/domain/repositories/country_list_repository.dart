import 'package:country_picker/features/country_picker/domain/entities/country.dart';

abstract class CountryListRepository {
  Future<List<Country>> getAllCountryLists();

  Future<List<Country>> searchCountryList(String searchQuery);
}
