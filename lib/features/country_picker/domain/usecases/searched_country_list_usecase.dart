import '../../../../core/usecases/usecase.dart';
import '../entities/country.dart';
import '../repositories/country_list_repository.dart';

class SearchCountryUseCase implements UseCase<List<Country>, Params> {
  final CountryListRepository repository;

  SearchCountryUseCase(this.repository);

  @override
  Future<List<Country>> call(Params params) async {
    return await repository.searchCountryList(params.query);
  }
}

class Params {
  final String query;

  Params({required this.query});
}
