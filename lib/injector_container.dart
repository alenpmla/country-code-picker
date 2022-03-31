import 'package:get_it/get_it.dart';

import 'features/country_picker/data/datasources/country_list_data_source.dart';
import 'features/country_picker/data/repositories/country_list_repository_impl.dart';
import 'features/country_picker/domain/repositories/country_list_repository.dart';
import 'features/country_picker/domain/usecases/get_all_countries_list_usecase.dart';
import 'features/country_picker/domain/usecases/searched_country_list_usecase.dart';
import 'features/country_picker/presentation/changenotifiers/country_code_picker_change_notifier.dart';


final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => CountryCodePickerChangeNotifier(
      allCountryListUseCase: sl(),
      searchCountryUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAllCountriesListUseCase(sl()));
  sl.registerLazySingleton(() => SearchCountryUseCase(sl()));

  // Repository
  sl.registerLazySingleton<CountryListRepository>(
    () => CountryListRepositoryImpl(
      countryListDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<CountryListDataSource>(
    () => CountryListDataSourceImpl(),
  );
}
