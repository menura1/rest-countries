part of 'all_countries_screen_bloc.dart';

@immutable
sealed class AllCountriesScreenState {}

final class AllCountriesScreenInitial extends AllCountriesScreenState {}

final class AllCountriesScreenLoading extends AllCountriesScreenState {}

final class AllCountriesScreenSuccess extends AllCountriesScreenState {
  final List<Country> countries;

  final FilterName? filterBy;
  final FilterOrder? filterOrder;

  AllCountriesScreenSuccess(
    this.countries,
    this.filterBy,
    this.filterOrder,
  );
}

final class AllCountriesScreenError extends AllCountriesScreenState {
  final String error;

  AllCountriesScreenError(this.error);
}
