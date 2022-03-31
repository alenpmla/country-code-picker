import 'package:country_picker/features/country_picker/domain/entities/country.dart';
import 'package:country_picker/features/country_picker/domain/repositories/country_list_repository.dart';
import 'package:country_picker/features/country_picker/domain/usecases/searched_country_list_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_countries_list_usecase_test.mocks.dart';


@GenerateMocks([CountryListRepository])
void main() {
  late SearchCountryUseCase useCase;
  late MockCountryListRepository mockCountryLisRepository;

  setUp(() {
    mockCountryLisRepository = MockCountryListRepository();
    useCase = SearchCountryUseCase(mockCountryLisRepository);
  });

  final tCountry = [Country(countryCode: 'IN', countryName: 'India')];

  test(
    'should get all country list from the repository',
    () async {
      // arrange
      when(mockCountryLisRepository.searchCountryList("i"))
          .thenAnswer((_) async => tCountry);

      // act
      final result = await useCase(Params(query: 'i'));
      // assert
      expect(result, tCountry);
      verify(mockCountryLisRepository.searchCountryList('i'));
      verifyNoMoreInteractions(mockCountryLisRepository);
    },
  );
}
