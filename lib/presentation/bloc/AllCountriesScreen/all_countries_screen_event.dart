part of 'all_countries_screen_bloc.dart';

@immutable
sealed class AllCountriesScreenEvent {}

class AllCountriesScreenFetchData extends AllCountriesScreenEvent {}

class AllCountriesScreenFilterUpdate extends AllCountriesScreenEvent {
  final FilterName? filterBy;
  final FilterOrder? filterOrder;

  AllCountriesScreenFilterUpdate(
    this.filterBy,
    this.filterOrder,
  );
}
