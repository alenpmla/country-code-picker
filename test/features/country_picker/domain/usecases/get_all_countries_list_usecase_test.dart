import 'package:country_picker/core/usecases/usecase.dart';
import 'package:country_picker/features/country_picker/domain/repositories/country_list_repository.dart';
import 'package:country_picker/features/country_picker/domain/entities/country.dart';
import 'package:country_picker/features/country_picker/domain/usecases/get_all_countries_list_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_countries_list_usecase_test.mocks.dart';

@GenerateMocks([CountryListRepository])
void main() {
  late GetAllCountriesListUseCase useCase;
  late MockCountryListRepository mockCountryLisRepository;

  setUp(() {
    mockCountryLisRepository = MockCountryListRepository();
    useCase = GetAllCountriesListUseCase(mockCountryLisRepository);
  });

  final tCountry = [Country(countryCode: 'IN', countryName: 'India')];

  test(
    'should get all country list from the repository',
    () async {
      // arrange
      when(mockCountryLisRepository.getAllCountryLists())
          .thenAnswer((_) async => tCountry);

      // act
      final result = await useCase(NoParams());
      // assert
      expect(result, tCountry);
      verify(mockCountryLisRepository.getAllCountryLists());
      verifyNoMoreInteractions(mockCountryLisRepository);
    },
  );
}
