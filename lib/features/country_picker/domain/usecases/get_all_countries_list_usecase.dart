import '../../../../core/usecases/usecase.dart';
import '../entities/country.dart';
import '../repositories/country_list_repository.dart';

class GetAllCountriesListUseCase implements UseCase<List<Country>, NoParams> {
  final CountryListRepository repository;

  GetAllCountriesListUseCase(this.repository);

  @override
  Future<List<Country>> call(NoParams params) async {
    return await repository.getAllCountryLists();
  }
}
